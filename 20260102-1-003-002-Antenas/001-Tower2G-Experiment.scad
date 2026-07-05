//:: Telco Tower 2G
// 20251219, Ondrej DURAS (dury) Nokia
//
// Toto by mala byt akoze telekomunikacna veza
// s dvomi 180% sektorovymi antenami RAN 
// a dvomi linkovymi antenami pre tranzit

/* [Previews] */
preview="basic"; // [basic,variants-antena,variants-tower,variants-holder,slider,movie,plate,plate-tower]
// basic - je zakladny pohlad, ked sa vytvaraju komponenty ...tu vsetky vo svojej finalnej polohe
// veriants - sluzi na odskusanie roznych parametrov ...aj tych ktore nikdy vyrobene nebudu
// slider - kontrolny pohlad na prekontrolovanie prienikov materialu roznych komponent cez seba a pod..
// movie - vyzualizacia celej zostavy v pohybe
// plate - vsetky komponenty v jednej rovine tak, ako ich vyrobi 3Dtlaciaren


/* [Dimensions] */
// rozostup medzi do seba vlozenymi vecami - nepresnost tlaciarne
spacing=0.2; // [0:0.05:0.4]
// hrana zakladnej dosky podstavca
baseRange=50; // [20:10:100]
// hrubka zakladnej dosky podstavca
baseTick=2; // [1:0.2:4]

// sirka veze
towerWidth=20; // [10:1:30]
// vyska jedneho poschodia
towerStep=20;  // [10:1:30]
// pocet poschodi
towerLevels=8; // [1:1:10]
// hrubka konstrukcie
towerTick=2;   // [1:0.2:4]

// sirka drziaka 2mm
holderWidth=towerTick; // [1:1:4]
// vyska drziaka 4mm
holderHight=towerTick*2;   // [2:1:8]
// rozostup holderov na vyrobnej doske (LEN PLATE)
holderDepth=towerTick*10;   // [towerTick*4:towerTick:TowerTick*10]
holderCylinderHight=towerTick*5;
/* [Colors] */
// Farba zakladne dosky podstavy
baseColor="#108010";
// Farba zakladneho materialu veze
towerColor="#505050";
// Farba drziakov
holderColor="#ff3030";
// Farba drziakov blezkozvodu
holderColorLR="#2020a0";
// Farba anten
antenaColor="#10a020";
linkColor="#40c040";
accessColor="#c08040";
//:: Skryte prepocty rozmerov
echo("Calculations...");  // this is the 1st command, to cout out the rest
towerWo=towerWidth;
towerHo=towerStep;
towerWi=towerWidth-2*towerTick;
towerHi=towerStep-2*towerTick;
//towerHigh=4*baseStep*towerLevels;

module towerPattern(wo=10,ho=20,wi=6,hi=16,ext=2) {
    // toto je jedno konstrukcne okienko telco veze
    x1=(wo-wi)/2; y1=(ho-hi)/2;
    linear_extrude(ext) { difference() {
        translate([0,0]) square([wo,ho]);
        translate([x1,y1]) square([wi,hi]);
    } }
}

module squareTower(wo=towerWo,ho=towerHo,wi=towerWi,hi=towerHi,ext=towerTick,levels=towerLevels) {
    // wo  - Width Outside  - vonkajsi rozmer jedneho okienka
    // ho  - Hight Outside - vonkajsia vyska jedneho okienka
    // wi  - Width Inside   - vnutorna sirka jedneho okienka
    // hi  - Hight Inside  - vnutorna vyska jedneho okrienka
    // ext - Extrusion      - vytiahnutie polygonu jedneho okienka/hlbka konstrukcnej listy
    // levels - pocet okienok tvoriacich vysku veze 
    union() {
    for(i=[0:1:levels]) { color(towerColor) {
        y=i*ho;
        translate([0,ext,y])     rotate([90,0,  0]) towerPattern(wo,ho,wi,hi,ext);
        translate([wo-ext,0,y])  rotate([90,0, 90]) towerPattern(wo,ho,wi,hi,ext);
        translate([wo,wo-ext,y]) rotate([90,0,180]) towerPattern(wo,ho,wi,hi,ext);
        translate([ext,wo,y])    rotate([90,0,270]) towerPattern(wo,ho,wi,hi,ext);
    } } // levels of tower
    } //union
}

module holderHole(center=false) { // iba diera do ktorej sa strci niektory z holderov - uz s pridanym spacingom
    w=1.5; /// nasobok sirky diery pre drziak
    y1=-1; d1=towerTick*2+1; // diera, hlboka cca 4mm, siroka a vysoka podla hrubky steny veze, teda 2x2mm (towerTick)
    if(center==true) {             // vysunutie -1 je kvoli dobrej differencii
        x1=0-(w*holderWidth+spacing)/2;
        z1=0-(towerTick+spacing)/2;
        translate([x1,y1,z1]) // TENTO MODUL pouzivat iba do difference na vyhryzavanie standartnej diery
            cube([w*holderWidth+spacing,d1,towerTick+spacing],center=false);
    } else {
        x1=0;
        z1=0;
        translate([x1,y1,z1]) // TENTO MODUL pouzivat iba do difference na vyhryzavanie standartnej diery
            cube([w*holderWidth+spacing,d1,towerTick+spacing],center=false);
    }
}
module holderNarrow() {
    color(holderColor) difference() {
    translate([0,0,0])   // zakladny kvader
        cube([holderWidth,towerTick*7,holderHight]);
    translate([-1,towerTick-spacing,-1]) // vyrez ktorym je drziak prichyteny o vezu
        cube([holderWidth+2,towerTick+2*spacing,1+towerTick+spacing]);
    translate([-1,3*towerTick,towerTick-spacing]) // zostihlanie hrotu na uchytenie anteny
        cube([holderWidth+2,towerTick*7,holderHight]);
    }
}
module holderLightingRodSide() {
    color(holderColorLR) difference() {
    translate([0,0,0])   // zakladny kvader
        cube([holderWidth,towerTick*5,holderHight]);
    translate([-1,towerTick-spacing,-1]) // vyrez ktorym je drziak prichyteny o vezu
        cube([holderWidth+2,towerTick+2*spacing,1+towerTick+spacing]);
    translate([-1,3*towerTick,towerTick-spacing]) // zostihlanie hrotu na uchytenie anteny
        cube([holderWidth+2,towerTick*5,holderHight]);
    }
}
module holderTooth() {
    color(holderColor) 
    union() {
    translate([spacing,towerTick*3/2-towerTick/2,holderHight])  //stuplik na vrchu
        cube([holderWidth-2*spacing,towerTick-2*spacing,3*towerTick]);
    difference() {
    translate([0,0,0])   // zakladny kvader
        cube([holderWidth,towerTick*3,holderHight]);
    translate([-1,towerTick-spacing,-1]) // vyrez ktorym je drziak prichyteny o vezu
        cube([holderWidth+2,towerTick+2*spacing,1+towerTick+spacing]);
    } // diff 
    } // union
}
module holderLightingRodUp() {
    color(holderColorLR) 
    union() {
    translate([spacing,towerTick*3/2-towerTick/2,holderHight])  //stuplik na vrchu
        cube([holderWidth-2*spacing,towerTick-2*spacing,7*towerTick]);
    difference() {
    translate([0,0,0])   // zakladny kvader
        cube([holderWidth,towerTick*3,holderHight]);
    translate([-1,towerTick-spacing,-1]) // vyrez ktorym je drziak prichyteny o vezu
        cube([holderWidth+2,towerTick+2*spacing,1+towerTick+spacing]);
    } // diff 
    } // union
}
module holderCylinder() {
    hh=holderCylinderHight;
    color(holderColor) union() {
    difference() { // copy of holderNarrow
        translate([0,0,0])   // zakladny kvader
            cube([holderWidth,towerTick*5,hh]);
        translate([-1,towerTick-spacing,-1]) // vyrez ktorym je drziak prichyteny o vezu
            cube([holderWidth+2,towerTick+2*spacing,1+hh-towerTick+spacing]);
        translate([-1,3*towerTick,towerTick-spacing]) // zostihlanie hrotu na uchytenie anteny
            cube([holderWidth+2,towerTick*5,hh]);
    } // diff holderNarrow
    translate([holderWidth/2,towerTick*5,0])
        cylinder(h=hh,r1=towerTick*7/10,r2=towerTick*4/10);
    }
}
module holderEye() {
    color(holderColor) union() {
        difference() {
            translate([towerTick*3/2,towerTick*3/2,0])
                cylinder(h=towerTick,d=towerTick*27/10);
            translate([towerTick*3/2,towerTick*3/2,-1])
                cylinder(h=towerTick+2,d=towerTick*13/10);
        }
        translate([towerTick*3/2-towerTick/2-spacing/2,towerTick*2,0])
            cube([towerTick-spacing,5*towerTick,towerTick-spacing]);
    }
}
module holderType(xx,yy,zz,type=1) {     // modul iba umiestnuje holder do zakladnej polohy vozi vezi
    translate([xx,yy,zz])                // posun podla offsetu
    translate([towerTick,towerTick,0])   // korekcia po otoceni
    rotate([0,0,180]) {                  // otocenie aby drziak bol smerom vonku z veze
        if(type==1) { holderNarrow();   }
        if(type==2) { holderTooth();    }
        if(type==3) { translate([0,0,2*towerTick-holderCylinderHight]) holderCylinder(); }
        if(type==5) { holderLightingRodUp(); }
        if(type==6) { holderLightingRodSide(); }
        if(type==7) { translate([towerTick/2,holderDepth,0]) linkComboQ10_basic(); }
        if(type==8) { translate([towerTick/2,holderDepth,0]) linkComboD10_basic(); }
        if(type==9) { translate([towerTick/2,holderDepth,0]) linkComboC10_basic(); }
        if(type==10){ translate([-7.5,holderDepth,-15]) accessAntenaD800_basic(); }
        if(type==11){ translate([-7.5,holderDepth,-15]) accessAntenaH800_basic(); }
   }
}
module holder(level,side,offset,type=1) { // modul pocita [x,y,z] podla polohy na vezi a aplikuje spravny holder
    // level - poschodie vo vezi
    // side  - strana veze squareTower 1-predna,2-prava,3-zadna,4-lava (proti smeru hodinovych ruciciek)
    //                     triangleTower 5-predna,6-prava,7-lava (taktiez proti smeru hodinovych ruciciek)
    // offset - posun z vychodzej polohy (1-predna z lava,2-zpredu,3-z prava, 4-odzadu)
    // type - typ holdera (1-Narrow, 2-tooth,3-cylinder)
    xx=(towerWo-towerWi)/2+offset; //v polohe 1 - t.j. predna stena
    yy=towerTick;                  //v polohe 1
    zz=level*towerHo;              //v polohe 1
    if(side==1) {    
        holderType(xx,yy,zz,type);
    }
    if(side==2) {
        translate([towerWidth,0,0])
        rotate([0,0,90])
        holderType(xx,yy,zz,type);
    }
    if(side==3) {
        translate([towerWidth,towerWidth,0])
        rotate([0,0,180])
        holderType(xx,yy,zz,type);
    }
    if(side==4) {
        translate([0,towerWidth,0])
        rotate([0,0,270])
        holderType(xx,yy,zz,type);
    }
}
module lentil(H=10,D=3,lcolor=antenaColor) {  // lentil-ka=sosovica lens=sosovka
    // H = hight je vyska sosovky (os-Z v zakladnej polohe)
    // D = depth je hrubka sosovky (os-Y v zakladej polohe)
    // Q = vzdialenost stredu referensnej gule od povrchu sosovky v jej najhrubsom strede (os-Y v zakladnej polohe)
    // R = radius je polomer referencnej gule
    // sosovku vyrobime ako prenik dvoch rovnakych referencnych guli - funcia intersection()
    // H a D su ako parameter, zatialco X a R potrebujeme vypocitat
    // R = (D*D + H*H) / (4*D)
    // Q = R-D .... ci ???
    // manualik  OpenSCAD-u:
    // $fa = minimalny uhol pre jeden segment, default=12, to znamena, ze ktruh je potom z 360/12=30-ich segmentov
    // $fs = minimalna dlzka ciaroveho segmentu kruhu, default=2mm najmenej 0.01mm 
    //       (pre nas 3D print 0.4mm alebo 0.2mm. Ine hodnoty tu nedavaju zmysel) .. potom to zaokruhluje
    // $fn = pocet ciarovych segmentov kruhu, default=0 znamena ze sa beru v uvahu $fa a $fs,
    //       striktne sa neodporuca viacej ako 128 - lebo to zerie privela pamate
    //       zaroven pre riesenie vykonnostnych problemov je dobre pouzivat menej ako 50
    R=(D*D + H*H) / (4*D); // vypocet polomeru referencnej gule
    Q=R-D;                 // ona vzdialenost stredu gule od povrchu sosovky ... nepoucijeme to zatial
    Y=R-(D/2);             // Y=suradnica stredu zadnej referencnej gule ; -Y=suradnica stredu prednej referencnej gule
    color(lcolor) intersection() {
        translate([0,Y,0]) // zadna referencna gula
           sphere(r=R);

        translate([0,-Y,0]) // predna referencna gula
            sphere(r=R);
    } // prienik referencnych guli sosovky
}
module lentilHalf(H=10,D=3,lcolor=antenaColor) {  // lentil-ka=sosovica lens=sosovka
    R=(D*D + H*H) / (4*D); // vypocet polomeru referencnej gule
    Q=R-D;                 // ona vzdialenost stredu gule od povrchu sosovky ... nepoucijeme to zatial
    Y=R-(D/2);             // Y=suradnica stredu zadnej referencnej gule ; -Y=suradnica stredu prednej referencnej gule
    color(lcolor) intersection() {
        translate([0,Y,0]) // zadna referencna gula - spodok taniera
            sphere(r=R);
        translate([0,-Y,0]) // predna referencna gula
            cube([2*R,2*Y,2*R],center=true);
    } // prienik referencnych guli sosovky
}
module lentilSurf(H=10,D=3,S=2,lcolor=antenaColor) {  // miska vyrezana ako rozdiel dvoch polovicnych sosoviciek
    // S je hrubka misky.
    R=(D*D + H*H) / (4*D); // vypocet polomeru referencnej gule
    Q=R-D;                 // ona vzdialenost stredu gule od povrchu sosovky ... nepoucijeme to zatial
    Y=R-(D/2);             // Y=suradnica stredu zadnej referencnej gule ; -Y=suradnica stredu prednej referencnej gule
    color(lcolor) intersection() {
        difference() {
            translate([0,Y,0]) // zadna referencna gula - spodok taniera
                sphere(r=R);
            translate([0,Y+S,0]) // gula ktorou vyrezavame objem referencnej gule na patricnu hrubku S
                sphere(r=R);
        }
        translate([0,-Y,0]) // predna referencna gula
            cube([2*R,2*Y,2*R],center=true);
    } // prienik referencnych guli sosovky
}
module cooler(w=20,d=10,h=40,c=2) { // chladiace rebrovanie ODU ... musi sa 'union-ovat' s kvadrami aby davalo zmysel
    // w=sirka chladica
    // d=hlbka chladica
    // h=vyska chladica
    // c=rebrovanie chladica, sirka rebra sa rovna sirke medzery
    for(i=[0:2*c:w+c]) {
        translate([i,0,0])
            cube([c,d,h]);
    }
}

module linkComboQ10_basic() {   // zakladna poloha - namontovane na vezi
    color(linkColor)
    difference() {
        union() {                   // referencnym bodom je stred sosovky/anteny
            lentil(15,7);           // linkove/smerove radio Combo-teda antena plus koncovy stupen radia s chladicom
            translate([-3,-6,-3])
                cooler(6,5,6,0.5);
            translate([-3,-6,-3])
                cube([6,5,2]); 
            translate([-3,-5,-3])
                cube([6,4,6]); 
        }
        //translate([0-(holderWidth+spacing)/2,-7,0-(towerTick+spacing)/2])
        //    cube([holderWidth+spacing,5,towerTick+spacing]);
        translate([0,-6,0])
            holderHole(center=true);
    }
}
module linkComboQ10_plate() {  // polona na vyrobnej doske
    translate([7.5,7.5,6]) rotate([90,0,0]) // referencnym bodom je lavy spodny roh stvorca podstavy
        linkComboQ10_basic();               // na ktorej linkove radio lezi
}
module linkComboD10_basic() {   // zakladna poloha - namontovane na vezi
    color(linkColor)
    difference() {
        union() {                   // referencnym bodom je stred sosovky/anteny
            lentilHalf(15,7);           // linkove/smerove radio Combo-teda antena plus koncovy stupen radia s chladicom
            translate([-3,-6,-3])
                cooler(6,5,6,0.5);
            translate([-3,-6,-3])
                cube([6,5,2]); 
            translate([-3,-5,-3])
                cube([6,4,6]); 
        }
        //translate([0-(holderWidth+spacing)/2,-7,0-(towerTick+spacing)/2])
        //    cube([holderWidth+spacing,5,towerTick+spacing]);
        translate([0,-6,0])
            holderHole(center=true);
    }
}
module linkComboD10_plate() {  // polona na vyrobnej doske
    //translate([7.5,7.5,6]) 
    translate([7.5,7.5,0]) 
    rotate([-90,0,0]) // referencnym bodom je lavy spodny roh stvorca podstavy
        linkComboD10_basic();               // na ktorej linkove radio lezi
}
module linkComboC10_basic() {   // zakladna poloha - namontovane na vezi
    color(linkColor)
    difference() {
        union() {                   // referencnym bodom je stred sosovky/anteny
            lentilSurf(15,7,2);           // linkove/smerove radio Combo-teda antena plus koncovy stupen radia s chladicom
            translate([-3,-6,-3])
                cooler(6,5,6,0.5);
            translate([-3,-6,-3])
                cube([6,5,2]); 
            translate([-3,-5,-3])
                cube([6,4,6]); 
        }
        //translate([0-(holderWidth+spacing)/2,-7,0-(towerTick+spacing)/2])
        //    cube([holderWidth+spacing,5,towerTick+spacing]);
        translate([0,-6,0])
            holderHole(center=true);
    }
}
module linkComboC10_plate() {  // polona na vyrobnej doske
    //translate([7.5,7.5,6]) 
    translate([7.5,7.5,0]) 
    rotate([-90,0,0]) // referencnym bodom je lavy spodny roh stvorca podstavy
        linkComboC10_basic();               // na ktorej linkove radio lezi
}

module accessAntenaH800_basic() { // Radio Access Network
    color(accessColor)
    difference() {
    union() {
        translate([0,1,0])  // zakladny dvader
            cube([15,5,60]);
        translate([1,0,1])  // predna aj zadna vystupena plocha
            cube([13,7,58]);
        translate([4,3,-3]) // lavy spodny connector na pripojenie kabla
        difference() {
            cylinder(h=3,d=3);
            cylinder(h=3,d=1);
        }
        translate([11,3,-3]) // pravy spodny connector na pripojenie kabla
        difference() {
            cylinder(h=3,d=3);
            cylinder(h=3,d=1);
        }
    } // union
    // a tu vyhryzneme diery na uchyty
    x1=7.5-holderWidth/2;
    translate([x1,0,15]) holderHole(center=false); // skupina s rozsahom 40mm
    translate([x1,0,55]) holderHole(center=false);
    translate([x1,0,7])  holderHole(center=false); // skupina s rozsahom 42mm
    translate([x1,0,49]) holderHole(center=false);
    } // difference
}
module accessAntenaH800_plate() {
    translate([0,60,0])
    rotate([90,0,0])
    accessAntenaH800_basic();
}
module accessAntenaD800_basic() { // Radio Access Network
    color(accessColor)
    difference() {
    union() { // objem anteny
        translate([0,1,0]) // zakladny kvader
            cube([15,5,60]);
        translate([1,0,1]) // zadna vystupena plocha
            cube([13,2,58]);
        difference() {     // predny polvalec
            translate([7.5,4,1])
                cylinder(h=58,r=6.5);
            translate([0,-5,0])
                cube([15,11,60]);
        } 
        translate([4,3,-3]) // lavy spodny connector na pripojenie kabla
        difference() {
            cylinder(h=3,d=3);
            cylinder(h=3,d=1);
        }
        translate([11,3,-3]) // pravy spodny connector na pripojenie kabla
        difference() {
            cylinder(h=3,d=3);
            cylinder(h=3,d=1);
        }
    } // union
    // a tu vyhryzneme diery na uchyty
    x1=7.5-holderWidth/2;
    translate([x1,0,15]) holderHole(center=false); // skupina s rozsahom 40mm
    translate([x1,0,55]) holderHole(center=false);
    translate([x1,0,7])  holderHole(center=false); // skupina s rozsahom 42mm
    translate([x1,0,49]) holderHole(center=false);
    } // difference
}
module accessAntenaD800_plate() {
    translate([0,60,0])
    rotate([90,0,0])
    accessAntenaD800_basic();
}
module tower2R2T_plate() {  // toto je iba tower bez vybavenia
    // zelena podlozka, ktora cini oporu vezi
    translate([0,0,0])
        color(baseColor)
        cube([baseRange,baseRange,baseTick]);
    // telco veza so stvorcovou podstavou, zakladnej velkosti
    x1=(baseRange-towerWidth)/2;
    translate([x1,x1,baseTick])
        color(towerColor)
        squareTower(); // default dimensions
}
module tower2R2T_full() { // toto je tower s kompletnou vybavou na sebe
    tower2R2T_plate();
    x1=(baseRange-towerWidth)/2; // x1 je posu x aj y suradnice zaciatku veze voci podlozke "base"
    x2=towerHi/2-towerTick/2;    // x2 je suradnica-offset "stredu" pre umiestnenie holdera
    x3=0;                        // x3 lavy okraj
    x4=towerWi-holderWidth;      // x4 pravy okraj
    x5=holderWidth;              // x5 lavy okraj +1
    x6=towerWi-2*holderWidth;    // x6 pravy okraj -1
    translate([x1,x1,baseTick]) {
        //RAN-y - horne drziaky
        //holder(7,1,x2,3); // level=5 side=predna offset=7mm (stred) type=Narrow
        holder(7,2,x2,1); // level=5 side=prava  offset=7mm (stred) type=Narrow
        //holder(7,3,x2,3); // level=5 side=zadna  offset=7mm (stred) type=Narrow
        holder(7,4,x2,1); // level=5 side=lava   offset=7mm (stred) type=Narrow

        // RAN-y - dolne drziaky
        //holder(4,1,x2,3); // level=5 side=predna offset=7mm (stred) type=Narrow
        holder(5,2,x2,1); // level=5 side=prava  offset=7mm (stred) type=Narrow
        //holder(4,3,x2,3); // level=5 side=zadna  offset=7mm (stred) type=Narrow
        holder(5,4,x2,1); // level=5 side=lava   offset=7mm (stred) type=Narrow

        holder(5,2,x2,10); //RAN-y
        holder(5,4,x2,10); // 10-velky uhol(vypukle) 11-maly uhol(ploche) 

        // LINK-y    
        holder(8,2,x4,1); //drziaky
        holder(8,3,x3,1);
        holder(8,2,x4,7); //radia
        holder(8,3,x3,9);
        // LightingRod - hromozvod (a majak)
        holder(9,3,x6,5);
        holder(9,1,x4,2);   // hrot na majak
        for(i=[0:1:towerLevels]) { holder(i+1,3,x4,6); }
        
    } // on tower
}
//:: Previews
if(preview=="basic") {
    translate([0,0,0])
        tower2R2T_full();
}
if(preview=="variants-antena") {
    translate([0,0,0])
        linkComboQ10_basic();
    translate([30,0,0])
        linkComboD10_basic();
    translate([60,0,0])
        linkComboC10_basic();
    translate([90,0,0])
        accessAntenaD800_basic();
}
if(preview=="variants-holder") {
    translate([0,0,0])
        holderNarrow();
    translate([holderWidth*10,0,0])
        holderTooth();
    translate([holderWidth*20,0,0])
        holderCylinder();
    translate([holderWidth*30,0,0])
        holderEye();
    translate([holderWidth*40,0,0])
        holderLightingRodUp();
    translate([holderWidth*50,0,0])
        holderLightingRodSide();
}
if(preview=="variants-tower") {
    translate([0,0,0]) 
        color(baseColor)
        cube([4*baseRange,4*baseRange,baseTick]);

    // telco veza so stvorcovou podstavou, zakladnej velkosti
    x1=(baseRange-towerWidth)/2;
    translate([x1,x1,baseTick])
        color(towerColor)
        squareTower(); // default dimensions
 
    translate([x1,x1+3*baseRange,baseTick])
        color(towerColor)
        squareTower();

    translate([x1+3*baseRange,x1+3*baseRange,baseTick])
        color(towerColor)
        squareTower();

   
    translate([1*baseRange,x1,baseTick])
        color(towerColor)
        squareTower(10,10,6,6,2,10);

    translate([2*baseRange,x1,baseTick])
        color(towerColor)
        squareTower(12,10,8,6,2,10);

    translate([3*baseRange,x1,baseTick])
        color(towerColor)
        squareTower(13,10,9,6,2,10);

    translate([1*baseRange,x1+1*baseRange,baseTick])
        color(towerColor)
        squareTower(14,10,10,6,2,10);

    translate([2*baseRange,x1+1*baseRange,baseTick])
        color(towerColor)
        squareTower(15,10,11,6,2,10);

    translate([3*baseRange,x1+1*baseRange,baseTick])
        color(towerColor)
        squareTower(16,10,12,6,2,10);

    translate([1*baseRange,x1+2*baseRange,baseTick])
        color(towerColor)
        squareTower(17,10,13,6,2,10);

    translate([2*baseRange,x1+2*baseRange,baseTick])
        color(towerColor)
        squareTower(18,10,14,6,2,10);

    translate([3*baseRange,x1+2*baseRange,baseTick])
        color(towerColor)
        squareTower(19,10,15,6,2,10);
}
if(preview=="slider") {

}
if(preview=="movie") {

}
if(preview=="plate") {
    y1=0;  // zaciatok prvej rady veci
    translate([0,y1,0])  // pridrzanie holderov, aby ich tlacova hlava nezhodila pocas tlacenia
        cube([57*holderWidth,1,1]);


    for(x=[0:3*holderWidth:30*holderWidth]){  
        translate([x,y1,0])
            holderNarrow();
    } 
    for(x=[33*holderWidth:6*holderWidth:56*holderWidth]) {
        translate([x,y1,0])
            holderCylinder();
        translate([x+3*holderWidth,y1,0])
            holderEye();
    }
    y2=holderDepth; // zaciatok druhej rady veci
    translate([0,y2,0])  // pridrzanie holderov, aby ich tlacova hlava nezhodila pocas tlacenia
        cube([57*holderWidth,1,1]);

    for(x=[0:3*holderWidth:30*holderWidth]){  
        translate([x,y2,0])
            holderLightingRodSide();
    } 
    for(x=[33*holderWidth:6*holderWidth:56*holderWidth]) {
        translate([x,y2,0])
            holderTooth();
        translate([x+3*holderWidth,y2,0])
            holderLightingRodUp();
    }
    y3=2*holderDepth;
    translate([0,y3,0]) // 1. seria linkRadii 
        linkComboQ10_plate();
    translate([20,y3,0]) 
        linkComboD10_plate();
    translate([40,y3,0]) 
        linkComboC10_plate();

    translate([60,y3,0]) // 2. seria linkovych radii
        linkComboQ10_plate();
    translate([80,y3,0]) 
        linkComboD10_plate();
    translate([100,y3,0]) 
        linkComboC10_plate();

    y4=y3+20;
    translate([0,y4,0])
        accessAntenaD800_plate(); 
    translate([20,y4,0])
        accessAntenaD800_plate(); 
    translate([60,y4,0])
        accessAntenaH800_plate(); 
    translate([80,y4,0])
        accessAntenaH800_plate(); 
} // plate
if(preview=="plate-tower") {
    translate([0,0,0])
        tower2R2T_plate();
}
// --- end ---
