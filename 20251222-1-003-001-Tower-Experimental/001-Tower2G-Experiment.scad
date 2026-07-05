//:: Telco Tower 2G
// 20251219, Ondrej DURAS (dury) Nokia
//
// Toto by mala byt akoze telekomunikacna veza
// s dvomi 180% sektorovymi antenami RAN 
// a dvomi linkovymi antenami pre tranzit

/* [Previews] */
preview="basic"; // [basic,variants,slider,movie,plate]
// basic - je zakladny pohlad, ked sa vytvaraju komponenty ...tu vsetky vo svojej finalnej polohe
// veriants - sluzi na odskusanie roznych parametrov ...aj tych ktore nikdy vyrobene nebudu
// slider - kontrolny pohlad na prekontrolovanie prienikov materialu roznych komponent cez seba a pod..
// movie - vyzualizacia celej zostavy v pohybe
// plate - vsetky komponenty v jednej rovine tak, ako ich vyrobi 3Dtlaciaren


/* [Dimensions] */
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

/* [Colors] */
// Farba zakladne dosky podstavy
baseColor="#108010";
// Farba zakladneho materialu veze
towerColor="#404040";

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
    // ho  - Height Outside - vonkajsia vyska jedneho okienka
    // wi  - Width Inside   - vnutorna sirka jedneho okienka
    // hi  - Height Inside  - vnutorna vyska jedneho okrienka
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

module tower2R2T() {
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

//:: Previews
if(preview=="basic") {
    translate([0,0,0])
        tower2R2T();
}
if(preview=="variants") {
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

}
// --- end ---
