// Prepad vody z umyvadla
// 20260712, Ondrej DURAS (dury) NOKIA
/* [Bugfix] */

// Cize zoznam chyb:
// 1.[v] diera pre skrutku by mala byt zvacsena z 1.5mm na 2.2mm
// 2.[v] treba zvacsit priemer otvoru pre zasunutie odpadovej trubky 32.0 mm na 2xspo=min0.4mm ...alebo mozno na hulvata na 33mm
// 3.[v] prehlbenie plochy opierajucej sa o umyvadlo zmensit z 7mm/5mm na nejakych mozno 2mm (zatial experimentalny rozmer)
// 4.[!] znizit vypln materialu zo 70% iba na 50% ...alebo mozno default 15% tiez nebude uplne zly ...aby skrutka nelamala stlpik.
// 5.[v] pridat opory pre stlpik, drziaci skrutku, hlavne aby zavadzanie skrutky ho krutiacim momentom nezlomilo.
// 6.[-] skrutka nema plnu vysku prepadu vody ... 3-4cm uplne stacia
// 7.[-] skrutka dobre drzi aj ked je zaskrutkovana len asi 1cm.

/* [Preview] */
$fn=20; // [10:10:100] 
// pocet fradmentov
spi=0.1; // I-odsadenie
spo=0.1; // O-odsadenie
spp=5.0; // odsadenie veci na plate
preview="plate";   // [basic,roundBox,stick,plate]

/* [Dimmensions] */
boxWidth=79.0; //sirka hlavneho boxu
boxHight=40.0; // hlbka objektu v pracovnej polohe, vyska lezmo
boxDepth=32.0; // vyska boxu v pracovneho polohe, hlbka lezmo
boxRound=10.0; // zaoblenia na rohoch krabice
boxHold=20.0;  // dlzka diery na 32mm trubku smerom k odpadu, ktorou bude odtekat voda
boxCavit=2.0;  // ani 5.0 ani 7.0mm odmerane ;; hlbka vyklenku/dutiny smerom k umyvadlu (Cavity)
boxTick=2.0;   // hrubka materialu krabice
tubeHight=90;  // vyska rurky ...celkova spolu aj krabickou prepadu
tubeRound=2.0; // zaoblenie okrajov drziaka rury
tubeDiaB=35.0; // priemer trubky hruby   (Broad)
tubeDiaN=33.0; // priemer trubky tenky / normovany (narrow) 32.mm bolo malo 
tubeHold=30.0; // vyska drzadla trubky
stickDia=14.0; // premier stlpika
stickHol=2.2;  // priemer diery /1.5mm bolo malo, lamalo to stlpik, da sa to zmiernit postupnym povysuvanim
stickRad=27.0; // polomer zaoblenia podstavca stlpika
stickHig=33;   // vyska stlpika ; normalne boxHeight-boxCavit-boxTick

/* [Colors] */
colorSifonOut="#c0c0b0"; //vonkajsia farba
colorSifonInn="#a0a090"; //vnutorna farba
colorRuber="#202010";    // farba gumovych tesneni
colorTube="#802020";     // farba trubky
colorStickOut="#404090"; // farba stlpika na drzanie skrutky
colorStickInn="#5050a0"; // farba diery v stlpiku
render(convexity=3); //expensive_model();

module roundCubeBottom(bw=boxWidth,bd=boxDepth,bh=boxHight,br=boxRound) {
// box v zakladnej polohe
// hore zrezany, dole a po strana zaobleny
    union() {
    difference() {
    cube([bw,bd,bh]);
        translate([-1,-1,-1]) cube([bw+2,br+1,br+1]);       // predny spodny vyrez
        translate([-1,bd-br,-1]) cube([bw+2,br+1,br+1]);    // zadny spodny vyrez
        translate([-1,-1,-1]) cube([br+1,br+1,bh+2]);       // lavy predny 
        translate([bw-br,-1,-1]) cube([br+1,br+1,bh+2]);    // pravy predny 
        translate([-1,bd-br,-1]) cube([br+1,br+1,bh+2]);    // lavy zadny 
        translate([bw-br,bd-br,-1]) cube([br+1,br+1,bh+2]); // pravy zadny 
        translate([-1,-1,-1]) cube([br+1,bd+2,br+1]);       // lavy spodny
        translate([bw-br,-1,-1]) cube([br+1,bd+2,br+1]);    // pravy spodny
    } //diff
        translate([br,br,br])    rotate([0,90,0])  cylinder(h=bw-2*br,r=br); // predny spodny vyplnovaci valec
        translate([br,bd-br,br]) rotate([0,90,0])  cylinder(h=bw-2*br,r=br); // zadny spodny vyplnovaci valec
        translate([br,br,br])    rotate([-90,0,0]) cylinder(h=bd-2*br,r=br); // lavy spodny
        translate([bw-br,br,br]) rotate([-90,0,0]) cylinder(h=bd-2*br,r=br); //pravy spodny
        translate([br,br,br])       cylinder(h=bh-br,r=br); // pravy predny
        translate([bw-br,br,br])    cylinder(h=bh-br,r=br); // lavy  predny
        translate([br,bd-br,br])    cylinder(h=bh-br,r=br); // pravy zadny
        translate([bw-br,bd-br,br]) cylinder(h=bh-br,r=br); // lavy  zadny

        translate([br,br,br])       sphere(r=br); // pravy predny zaobleny roh
        translate([bw-br,br,br])    sphere(r=br); // lavy  predny zaobleny roh
        translate([br,bd-br,br])    sphere(r=br); // pravy zadny zaobleny roh
        translate([bw-br,bd-br,br]) sphere(r=br); // lavy  zadny zaobleny roh
        
    } // union
}

module roundCubeHole(bw=tubeDiaB,bd=tubeHold,bh=tubeDiaB,br=tubeRound,dia=tubeDiaN) {
// cast, ktora drzi trubku k prepadu, zaobleny kvadrik s valcovitou i
// dierou, z boku prilepeny k vanicke prepadu
    color(colorTube)
    difference() {
    union() {
    difference() {
        cube([bw,bd,bh]);
        translate([-1,-1,-1]) cube([br+1,bd+2,br+1]);
        translate([bw-br,-1,-1]) cube([br+1,bd+2,br+1]);
        translate([-1,-1,bh-br]) cube([br+1,bd+2,br+1]);
        translate([bw-br,-1,bh-br]) cube([br+1,bd+2,br+1]);
    } // diff in - vyrezy rohov
        translate([br,0,br]) rotate([-90,0,0]) cylinder(h=bd,r=br); // lavy spodny vyplnovaci valec
        translate([bw-br,0,br]) rotate([-90,0,0]) cylinder(h=bd,r=br); // lavy spodny vyplnovaci valec
        translate([br,0,bh-br]) rotate([-90,0,0]) cylinder(h=bd,r=br); // lavy spodny vyplnovaci valec
        translate([bw-br,0,bh-br]) rotate([-90,0,0]) cylinder(h=bd,r=br); // lavy spodny vyplnovaci valec
    } // unio
        translate([bw/2,-1,bh/2]) rotate([-90,0,0])  cylinder(h=bd+2,d=dia+2*spo);

    } // diff out - trubka
}


module skrewStick(sh=stickHig,sd=stickDia,sx=stickHol,sr=stickRad,bw=boxWidth,bd=stickDia+2,bh=boxHight) {
// stlpik pre pritiahnutie prepadu k umyvadlu skrutkou
// referencny bod je tam, kde aj na cylindri ...na podstave valca uprostred
    color(colorStickOut)
    intersection() {
    translate([-bw/2-0.001,-bd/2-0.001,-0.001]) cube([bw+0.002,bd+002,bh+0.002]);
    //rotate([90,0,0]) 
    difference() {
    union() {
    cylinder(h=sh,d=sd);
    rotate_extrude() {
        difference() { // zaoblena spevnena pata palice
            translate([sd/2,0]) square([sr,sr]); 
            translate([sd/2+sr,sr]) circle(r=sr);
        }
    } //ext
    } //uni
        color(colorStickInn)
        translate([0,0,sh*3/4]) cylinder(h=sh,d=sx);
    } //diff
    } // intersect
}

module prepadVody() {
// telo prepadu vody bez odpadovej trubky
// v zakladnej polohe, identickej s vyrobnou polohou
// sirkou prepadu k ose X, chrbtom k podlozke

// ak B je polovica sirky okna a D je hlbka prepadu, potom 
// C je polomer valca, ktory treba od krabice odrezat, by mala spravne zakryvenie k umyvadlu
// C=(B*B-D*D)/2D+D ... vypocet polomeru valca
// A - vzdialenost stredu valca od prepadu do umyvadla = C-D
// A = C-D
// alebo pocitajme najprv vzdialenost valca od krabice A=(BB-DD)/2D
// a potom jeho polomer ako C=A+D

    bw=boxWidth; bd=boxDepth; bh=boxHight; br=boxRound; bt=boxTick;
    tw=tubeDiaB; td=tubeHold; th=tubeDiaB; tr=tubeRound; dia=tubeDiaN;

    B=bw/2; D=boxCavit;
    C=(B*B-D*D)/(2*D)+D;
    A=C-D;

    union() {
    color(colorSifonOut)
    difference() {
    union() {
        roundCubeBottom(bw,bd,bh,br); // vanicka
        //translate([bw/2-bd/2,bd-br,0]) roundCubeHole(tw,td,th,tr,dia); // drziak trubky
        translate([bw/2-tw/2,bd-br,0]) roundCubeHole(tw,td,th,tr,dia); // drziak trubky
    } //unio
        translate([bt,bt,bt]) roundCubeBottom(bw-2*bt,bd-2*bt,bh-bt+0.001,br); // vynus vyhlbenie vo vanicke na hrubku materialu
        translate([bw/2,bd-2*br,th/2]) rotate([-90,0,0])  cylinder(h=bd+2,d=dia*4/5+2*spo);
        translate([bw/2,-1,bh+A]) rotate([-90,0,0]) cylinder(h=bd+td+2,r=C);

    //TODO: este dieru pre odtok vody a zaoblenie podla umyvadla viz vzorceky v 001-.scad
    } // diff
        translate([bw/2,bd/2,bt]) skrewStick();  // stlpik pre uchytenie skrutkou uprostred vanicky
    } // union
}

module preview(preview=preview) {
    if(preview=="roundBox") {
        color(colorSifonOut)
        roundCubeBottom();

        translate([boxWidth/2-tubeDiaB/2,2*boxDepth,0])
        roundCubeHole();
    }
    if(preview=="stick") {
        skrewStick();
    }
    if(preview=="plate") {
        prepadVody();
    }

}
preview();


