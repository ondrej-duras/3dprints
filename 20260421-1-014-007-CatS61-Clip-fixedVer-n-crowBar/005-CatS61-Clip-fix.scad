// Catepilar S61 - Clip to hold Military Case
// 2026-04-13, Ondrej DURAS (dury) NOKIA
// prichytenie mobilu : priviazane o snurku drzi vojenske ocharrne puzro na mobilny telefon CatS61
// dva moduly; slider - spodna zasuvna cast a cover - zakrytka zvierajuca snurku k slideru.
// pevne pojenie bude realizovane dvoma samoreznymi skrutkami
//include <003-roundedCube-lib.scad>

/* [Viever] */
preview="basic";    // [basic,cover,slider,plate]
distance=5;        // [0:1:50] vzdialenost kritky od podlozky
$fn=30;

/* [Dimensions] */
spi=0.1;            // spacing povrchu vnutornej suciatky sucheho spoja - pravidlo: I sa strka do O
spo=0.1;            // spacing povrchu vonkajsej suciastky sucheho spoja - I treba obvikle zuzit, O rozsirit aby sa veci do seba dali zasunut
roundedRadius=2.0;  // polomer zabrusenia hran slidera
roundedRadiusBig=4.5; 
sliderDepthM=40.5;  // celkova hlbka Slidera ... v podstate sirka, hlavny rozmer
sliderDepthL=30.0;  // hlbka lavej(blizsie k X)-celistvej casti slidera
sliderDepthR=10.5;  // hlbka pravej(dalej od X)-zarezanej casti slidera 
sliderWidthM=20.0;  // celkova sirka slidera
sliderWidthT=13.0;  // sirka horneho-noseneho pasu slidera
sliderWidthB=7.0;   // sirka spodneho-leziaceho pasika slidera (su dva, kazdy 6.0mm podla originalu, ale skusime 7.0mm)
sliderHightM=4.5;   // celkova vyska slidera - oboch pasikov dohromady (B+T=M !!!)
sliderHightB=2.5;   // vyska spodnych-leziacich dvoch pasikov slidera
sliderHightT=2.0;   // vyska horneho-noseneho pasika slidera
sliderCutLen=10.5;  // dlzka zarezu do slidera .. su dva
sliderCutTck=0.71;  // hrubka (Tick) zarezu do sldera .. su dva (merany original 1.5, 1.51 funkcny)
sliderCutDis=5.5;   // vzdialenost okraja zarezu od okraja slidera
sliderTipWid=8.0;   // sirka drziaceho hrotu i vyhynacieho jazycka (8.0 funkcny)
sliderTipDis=6.0;   // okraj jazycka/hrotu od okraja slidera // druhy okraj vyrezu // =poloha+sirka vyrezu
sliderTipDep=3.0;   // v podstate hrubka hrotu
sliderTipHig=8.0;   // vyska hrotu od podlozky
sliderCylRad=8.0;   // polomer cylindra, sluziaceho k pruznemu vyrezu
screwBodyM=2.0;     // priemer tela skrutky asi 2.0mm, este premerat
screwHeadM=5.0;     // ten najvacsi priemer hlavy skruptky, merany na asi 5.0, premerat este raz
screwHeadH=2.0;     // vyska hlavy skrutky
ferulaTick=1.0;     // hrubka steny ferule, teda kuzela s dierou, do ktorej pojde skrutka
ferulaHolders=8;    // pocet drziacikov, ktore zvysuju pevnost refule - zvacsuju plochu zakladne ktorou vznika prepoj medzi ferulou a suciastkou
ferulaHight=7.0;    // REFERENCNY rozmer - vyska vnutorneho pristoru pod coverom/krytkou ... urcuje vysku krytku
coverTick=2.0;      // hrubka materialu cover-a
cbArm=80.0;         // dlzka paky pacidla
cbTip=5.0;          // dlzka hrotu pacidla
cbRad=5.0;          // polomer zaoblenia pacidla
cbExt=5.0;          // sirka pacidla



/* [Colors] */
colorSliderBottom="#908010"; // farba spodnych dvoch pasikov slidera
colorSliderTop="#706008";    // farba horneho pasika slidera
colorFerulaFemale="#701010"; // Farba valcovej objimky na slideri, ktora do ktorej sa zasunie FerulaMale z covera
colorFerulaMale="#108080";   // Farba valcovej objimky na coveri s dierou, do ktorej pojde pridrzajuca skrutka
colorScrew="#108020";        // farba skrutky
colorCover="#407040";        // farba krytky/cover-a
colorCrowBar="#105030";      // farba pacidla ... je nepodstatna


module crowBar(Arm=cbArm,Tip=cbTip,Rad=cbRad,Ext=cbExt) {
    linear_extrude(Ext) {
    union() {
        translate([0,0,0])      // Tip - polygon hrotu
            polygon([[0,0],[Tip,0],[Tip,Rad]],[[0,1,2]]);
        translate([Tip,Rad])    // Arm - rameno pacidla
            square([Rad,Arm]);
        difference() {          // zaoblena cast stvrtkruh/stcrtvalec
            translate([Tip,Rad])
                circle(r=Rad);  // zakladny kruh, z ktoreho rezeme stvorec a obdlznik
            translate([0,0])
                square([Tip,2*Rad]); // urezanie 2. a 3. kvadrantu kruhu
            translate([Tip,Rad])
                square([Rad,Rad]);   // urezanie 1. kvadrandu. Ostava iba 4.-ty kvadrant.
        } //diff
    } // union
    } //Ext
}

module ferulaFemale() {
    difference() {
        union() {
            cylinder(h=ferulaHight/2-spi,d=screwBodyM+4*ferulaTick);
            for(i=[0:360/ferulaHolders:360]) {
                rotate([0,0,i])
                cube([ferulaTick,screwBodyM+3*ferulaTick,ferulaTick]);
            }
        }
        translate([0,0,-1])
        cylinder(h=ferulaHight/2-spi+2,d=screwBodyM+2*ferulaTick+spo);
    }
}
module ferulaMale() {
    difference() {
        union() {
            cylinder(h=ferulaHight/2-spi,d=screwBodyM+4*ferulaTick);
            for(i=[0:360/ferulaHolders:360]) {
                rotate([0,0,i])
                cube([ferulaTick,screwBodyM+3*ferulaTick,ferulaTick]);
            }
            cylinder(h=ferulaHight-spi,d=screwBodyM+2*ferulaTick-spi);
        }
        translate([0,0,-1])
        cylinder(h=ferulaHight-spi+2,d=screwBodyM);
    }
    
}

module roundedCoverUp(w,d,h,r1,r2) {  // sirka, hlbka/dlzka, vyska/hrubka, polomer velkeho zaoblenia, polomer malych hran
    union() {
    difference() {
        cube([w,d,h]);
        translate([-1,d-r1,h-r1])
            cube([w+2,r1+1,r1+1]);      // vyrez pre velke zaoblenie (vzadu hore)
        translate([-1,-1,h-r2])
            cube([r2+1,d+2,r2+1]);  // lavy horny vyrez pre okrajove zaoblenie
        translate([w-r2,-1,h-r2])
            cube([r2+1,d+2,r2+1]);  // pravy horny vyrez pre okrajove zaoblenie
        translate([-1,d-r2,-1])
            cube([r2+1,r2+1,h+2]);  // vyrez pre zaoblenie vlavo vzadu
        translate([w-r2,d-r2,-1])
            cube([r2+1,r2+1,h+2]);  // vyrez pre zaoblenie vpravo vzadu
    } // diff
        translate([r2,d-r1,h-r1])
            rotate([0,90,0])
            cylinder(h=w-2*r2,r=r1); // velke zaoblenie vzadu hore
        translate([r2,0,h-r2])
            rotate([-90,0,0])       // lave horne zaoblenie
            cylinder(h=d-r1,r=r2);
        translate([w-r2,0,h-r2])
            rotate([-90,0,0])       // prave horne zaoblenie
            cylinder(h=d-r1,r=r2);
        translate([r2,d-r2,0])
            cylinder(h=h-r1,r=r2);  // lave zadne zaoblenie
        translate([w-r2,d-r2,0])
            cylinder(h=h-r1,r=r2);  // prave zadne zaoblenie


        translate([r2,d-r1,h-r1])   // velke zaoblenie v lavom hornom rohu
            rotate([0,-90,0])
            //rotate_extrude(angle=90,start=0,convexity=100)
            rotate_extrude(angle=90,convexity=20)
                translate([r1-r2,0,0])
                circle(r=r2);

        translate([w-r2,d-r1,h-r1])   // velke zaoblenie v lavom hornom rohu
            rotate([0,-90,0])
            //rotate_extrude(angle=90,start=0,convexity=100)
            rotate_extrude(angle=90,convexity=20)
                translate([r1-r2,0,0])
                circle(r=r2);

        translate([0,d-r1,h-r1])  // vyplnenie dier na velkom zaobleni z oboch stran pomocou valca
            rotate([0,90,0])
            cylinder(h=w,r=r1-r2);
    } // union
}

module roundedCoverDown(w,d,h,r1,r2) {  // zaoblena krytka otocena dnom dole v zakladnej polohe
                                        //sirka,hlbka/dlzka,vyska/hrubka,polomer velkeho zaoblenia vzadu,polomer malych zaobleni po stranach
                                        // z pohladu komponent zjednodusena ...ovsem nedokonala verzia
    union() {
    difference() {
        cube([w,d,h]);             // zakladny kvader
        translate([r2-0.1,d-r1,-1])
            cube([w-2*r2+0.2,r1+1,r1+1]);  //vyrez pre velke zaoblenie

        translate([-1,-1,-1])
            cube([r2+1,d+2,r2+1]);  // lavy dolny vyrez
        translate([w-r2,-1,-1])
            cube([r2+1,d+2,r2+1]); //pravy dolny vyrez
        translate([-1,d-r2,-1])
            cube([r2+1,r2+1,h+2]);  // lavy zadny vyrez 
        translate([w-r2,d-r2,-1])
            cube([r2+1,r2+1,h+2]);  // lavy zadny vyrez 
        
    } //diff
        translate([r2,0,r2])
            rotate([-90,0,0])
            cylinder(h=d-r1,r=r2);  // lave dolne zaoblenie
        translate([w-r2,0,r2])
            rotate([-90,0,0])
            cylinder(h=d-r1,r=r2);  // prave dolne zaoblenie
        translate([r2,d-r2,r1])
            cylinder(h=h-r1,r=r2);  // lave zadne zaoblenie
        translate([w-r2,d-r2,r1])
            cylinder(h=h-r1,r=r2);  // prave zadne zaoblenie
        translate([r2,d-r1,r1])
            rotate([0,90,0])
            cylinder(h=w-2*r2,r=r1);  // zadne dolne velke zaoblenie


        translate([r2,d-r1,r1])   // velke zaoblenie v lavom hornom rohu
            rotate([0,90,0])
            //rotate_extrude(angle=90,start=0,convexity=100)
            rotate_extrude(angle=90,convexity=20)
                translate([r1-r2,0,0])
                circle(r=r2);

        translate([w-r2,d-r1,r1])   // velke zaoblenie v lavom hornom rohu
            rotate([0,90,0])
            //rotate_extrude(angle=90,start=0,convexity=100)
            rotate_extrude(angle=90,convexity=20)
                translate([r1-r2,0,0])
                circle(r=r2);

    } //union
}
module roundedCubeHightLeft(w=sliderWidthB,d=sliderDepthM,h=sliderHightB,r=roundedRadius) {
    union() {
        difference() {
            cube([w,d,h],center=false);  //zakladny kvader, ktory sa ide orezavat
            translate([-1,-1,-1])
                cube([r+1,r+1,h+2]);     // vyrez vlavo vpredu
            //translate([w-r,-1,-1])            
            //    cube([r+1,r+1,h+2]);   // vyrez vpravo vpredu
            translate([-1,d-r,-1])
                cube([r+1,r+1,h+2]);     // vyrez vlavo vzadu
            //translate([w-r,d-r,-1])
            //    cube([r+1,r+1,h+2]);   // vyrez vpravo vzadu
        } // difference
            translate([r,r,0])
                cylinder(h=h,r=r);       // cylinder zaoblenia vlavo vpredu
            //translate([w-r,r,0])            
            //    cylinder(h=h,r=r);     // cylinder zaoblenia vpravo vpredu
            translate([r,d-r,0])
                cylinder(h=h,r=r);       // cylinder zaoblenia vlavo vzadu
            //translate([w-r,d-r,0])
            //    cylinder(h=h,r=r);     // cylinder zaoblenia vpravo vzadu
    } // union

}

module roundedCubeHightRight(w=sliderWidthB,d=sliderDepthM,h=sliderHightB,r=roundedRadius) {
    union() {
        difference() {
            cube([w,d,h],center=false);  //zakladny kvader, ktory sa ide orezavat
            //translate([-1,-1,-1])
            //    cube([r+1,r+1,h+2]);   // vyrez vlavo vpredu
            translate([w-r,-1,-1])            
                cube([r+1,r+1,h+2]);     // vyrez vpravo vpredu
            //translate([-1,d-r,-1])
            //    cube([r+1,r+1,h+2]);   // vyrez vlavo vzadu
            translate([w-r,d-r,-1])
                cube([r+1,r+1,h+2]);     // vyrez vpravo vzadu
        }
            //translate([r,r,0])
            //    cylinder(h=h,r=r);     // cylinder zaoblenia vlavo vpredu
            translate([w-r,r,0])            
                cylinder(h=h,r=r);       // cylinder zaoblenia vpravo vpredu
            //translate([r,d-r,0])
            //    cylinder(h=h,r=r);     // cylinder zaoblenia vlavo vzadu
            translate([w-r,d-r,0])
                cylinder(h=h,r=r);       // cylinder zaoblenia vpravo vzadu
    }

}

module slider() {  // spodna zasuvacia cast 
// zakladnou polohou je poloha na plate
// referencny bod je vlavo dole v zadu
    difference() {
    union() {
        color(colorSliderBottom)
        translate([0,0,0])
            //cube([sliderWidthB,sliderDepthM,sliderHightB]); // lavy leziaci pasik
            roundedCubeHightLeft(sliderWidthB,sliderDepthM,sliderHightB,2); // lavy leziaci pasik
        color(colorSliderBottom)
        translate([sliderWidthM-sliderWidthB,0,0])
            //cube([sliderWidthB,sliderDepthM,sliderHightB]); // pravy leziaci pasik
            roundedCubeHightRight(sliderWidthB,sliderDepthM,sliderHightB,2); // pravy leziaci pasik
        color(colorSliderTop)
        translate([(sliderWidthM-sliderWidthT)/2,0,sliderHightB])
            cube([sliderWidthT,sliderDepthM,sliderHightT]); // horny noseny pasik
        color(colorSliderTop)
        translate([sliderTipDis,sliderDepthM,0]) // hlavny kvader hrotu prichytenia, z kvoreho sa bude rezat
            cube([sliderTipWid,sliderTipDep,sliderTipHig]);


        color(colorSliderBottom)                            // prva ferula od predneho okraja
            translate([sliderWidthM/2,1*sliderDepthL/3,sliderHightM])
            ferulaFemale();
        color(colorSliderBottom)                            // druha ferula od predneho okraja
            translate([sliderWidthM/2,2*sliderDepthL/3,sliderHightM])
            ferulaFemale();
    } //union
        color(colorSliderTop)
        translate([sliderCutDis,sliderDepthL,-1])
            cube([sliderCutTck,sliderDepthR+sliderTipDep+1,sliderTipHig+2]); // lavy zarez
        color(colorSliderTop)
        translate([sliderWidthM-sliderCutDis-sliderCutTck,sliderDepthL,-1])
            cube([sliderCutTck,sliderDepthR+sliderTipDep+1,sliderTipHig+2]); //pravy zarez
        color(colorSliderTop)
        //translate([sliderTipDis,sliderDepthM-sliderDepthR/2,sliderCylRad+sliderHightM-1])
        //    rotate([0,90,0])
        //    cylinder(h=sliderTipWid,r=sliderCylRad); // valcovity vyrez, ktory by mal umoznit pruznost
        color(colorSliderTop)
        translate([0,sliderDepthM+sliderTipDep/2,0])
            rotate([-45,0,0])
            cube([sliderWidthM,sliderTipDep,sliderTipHig]); // skosenie hrotu prichytenia
        color(colorSliderBottom)
            rotate([0,45,0])
            translate([-sliderHightB,-1,0])
            cube([sliderHightB,sliderDepthM+2,sliderHightM]); // skosenie lavej strany slidera
        color(colorSliderBottom)
            translate([sliderWidthM,-1,0])
            rotate([0,-45,0])
            cube([sliderHightB,sliderDepthM+2,sliderHightM]); // skosenie pravej strany slidera
        color(colorSliderTop)
            translate([sliderTipDis,sliderDepthM+sliderTipDep,sliderTipHig/2])
            rotate([0,90,0])
            cylinder(h=sliderTipWid,d=sliderTipHig/5);
        color(colorSliderBottom)                            // diera pre prvu skrutku od predneho okraja
            translate([sliderWidthM/2,1*sliderDepthL/3,0])
            cylinder(h=sliderHightM+1,d=screwBodyM);
        color(colorSliderBottom)                            // diera pre druhu skrutku od predneho okraja
            translate([sliderWidthM/2,2*sliderDepthL/3,0])
            cylinder(h=sliderHightM+1,d=screwBodyM);

        color(colorScrew)                                   // vyhlbenie pre hlavu prvej skrutky od predneho okraja
            translate([sliderWidthM/2,1*sliderDepthL/3,sliderHightB/2])
            cylinder(h=screwHeadH,d1=screwHeadM,d2=screwBodyM);
        color(colorScrew)                                   // vyhlbenie pre hlavu druhej skrutky od predneho okraja
            translate([sliderWidthM/2,2*sliderDepthL/3,sliderHightB/2])
            cylinder(h=screwHeadH,d1=screwHeadM,d2=screwBodyM);

        color(colorSliderTop)
            translate([sliderTipDis-spi,sliderDepthL,-spi]) // odrezanie z bocnych leziacich pasikov, aby noseny pasik nemal nepruzne supporty
            cube([sliderTipWid+2*spi,sliderDepthR,sliderHightB+spi]);
    } //diff

}

module cover() {   // zakrytka zvierajuca snurku k zasuvacej casti
// zakladnou polohou je poloha na plate, teda chrbatom dole.
// referencny bod je vlavo dole v zadu na chrbate
    union() {
    difference() {
        color(colorCover)
            roundedCoverDown(sliderWidthT,sliderDepthL,ferulaHight+coverTick,roundedRadiusBig,roundedRadius);
        color(colorCover)
            translate([coverTick,-1,coverTick])
            roundedCoverDown(sliderWidthT-2*coverTick,sliderDepthL-coverTick+1,ferulaHight+coverTick,roundedRadiusBig,roundedRadius);
    } //diff
        color(colorSliderBottom)                            // prva ferula od predneho okraja
            translate([sliderWidthT/2,1*sliderDepthL/3,coverTick])
            ferulaMale();
        color(colorSliderBottom)                            // druha ferula od predneho okraja
            translate([sliderWidthT/2,2*sliderDepthL/3,coverTick])
            ferulaMale();
    } //union
}

if(preview=="basic") {
    slider();     
}
if(preview=="slider") {
    slider();
}
if(preview=="cover") {
    cover();
}
if(preview=="plate") {
    translate([0,0,0])
        slider();

    translate([sliderWidthM+distance,0,0])
        cover();

    color(colorCrowBar)
    translate([sliderWidthM+distance+sliderWidthT+distance,0,0])
        crowBar();
}
