// Wire Hinges
// 20260510, Ondrej DURAS (dury) NOKIA
// dalsi experiment s pantami krabiciek ... telco cabinetov

/* [Preview] */

spi=0.1; // spacing (zmensenie) kolika
spo=0.1; // spacing (zvacsenie) dierky ...aby kolik a dierka do seba pasovali a nezadreli sa
spp=10;  // spacing on plate ... medzera medzi dvoma vedla seba leziacimi komponentami na vyrobnom plate 
$fn=100;
preview="basic"; // [basic,body,cover,hinge,plate]
// uhol otvorenia dveri 0-zatvorene, 90 uplne otvorene
angle=30;        // [0:1:180] 
wire=1.0;        // [0.6:Cu_06.1.0:Fe_10] hrubka drotu

/* [Dimenssions] */
boxWidth=50;  // standartna hlzka skatulky - vonkajsi rozmer
boxDepth=40;  // standartna sirka skatulky - vonkajsi rozmer
boxHight=30;  // standartna vyska skatulky - vonkajsi rozmer
boxTick=2.0;  // hrubka steny skatulky - o ktory sa zmensuje priesto vo vnutri oproti vonkajsku
boxHinges=5;  // celkovy pocet pantov na skatulke - pocet na skatulke + na vrchnaku

/* [Colors] */
colorBoxBody="#2020a0";  // farba skatulky
colorBoxCover="#a02020"; // farba deklika

module hinge(h=5,do=2.0,di=1.0) {  // dlzka pantu, vonkajsi priemer, primed diery pantu
// zakladna polona je taka, pri ktorej by sa drot pantu viedol vodorovne s osou X
// referencny bod pantu je predny lavy dolny roh.
    difference() {
    union() {
        translate([0,0,0])
            cube([h,do,do/2]);
        translate([0,do/2,do/2])
           rotate([0,90,0])
           cylinder(h=h,d=do);
    } //uni
        translate([-1,do/2,do/2])
           rotate([0,90,0])
           cylinder(h=h+2,d=di+spo);
    } // diff
}

module boxBody(bw=boxWidth,bd=boxDepth,bh=boxHight,bt=boxTick,bn=boxHinges) {
// bw-boxWidth, bd-boxDepth, bh-boxHight, bt-boxTick, bn-number of hinges
// zakladna poloha boxu je dnom na spodku a pantami k osi X
// referencny bod ja vlavo dole vpredu v zakladnej polohe rohovy bod
// bw,bd,bh - definuju vonkajsi rozmer boxu
    union() {
    difference() {
    translate([0,0,0])     // vonkajsi box, z ktoreho rezeme
        cube([bw,bd,bh-bt]); // pozor - od dvadra odpocitavame krubku dekla
    translate([bt,bt,bt])
        cube([bw-2*bt,bd-2*bt,bh-bt]);
    } //diff
    for(i=[0:(bw/bn)*2:bw-0.1]) {
        translate([i,0,bh-bt])
            hinge(h=bw/bn-spi,do=bt,di=wire);
    } //i
    } //uni

}

module boxCover(bw=boxWidth,bd=boxDepth,bh=boxHight,bt=boxTick,bn=boxHinges) {
// zakladna poloha je lezmo s pantami vpredu na ose X
// referencny bod je za uplnom zaciatku dole pod lavym pantom
    union() {
    translate([0,bt,0])      //  doska dekla
        cube([bw,bd-bt,bt]);

    for(i=[bw/bn:(bw/bn)*2:bw-0.1]) { // prirabka pantov
        translate([i,bt,0])
        rotate([90,0,0])
        hinge(h=bw/bn-spi,do=bt,di=wire);
    } //i
    } // uni

}

if(preview=="basic") {    // zakladna pozicia zlozenej bednicky/krabicky...
    color(colorBoxBody)   // umoznuje odklapanie a zaklapanie deklika na krabicke
    translate([0,0,0])
    boxBody();
    
    color(colorBoxCover)
    translate([0,0,boxHight-boxTick])
    translate([0,+boxTick/2,+boxTick/2]) // spatna korekcia vrchnaku po otoceni s nulou na povodnom mieste v zakladnej pozicii
    rotate([angle,0,0])                  // stredom pre otacanie je stred podstavy valca pantu, osa otacanie je po vyske pantu
    translate([0,-boxTick/2,-boxTick/2]) // dopredna korekcia vrchnaku na os otacania
    boxCover();

}
if(preview=="body") {
    color(colorBoxBody)
    translate([0,0,0])
    boxBody();

}
if(preview=="cover") {
    color(colorBoxCover)
    translate([0,0,0])
    boxCover();

}
if(preview=="hinge") {
    color(colorBoxBody)
    hinge();

}
if(preview=="plate") {
    color(colorBoxBody)
    translate([0,0,0])
    boxBody(boxWidth,boxDepth,boxHight,boxTick,boxHinges);

    color(colorBoxCover)
    translate([boxWidth+spp,0,0])
    boxCover(boxWidth,boxDepth,boxHight,boxTick,boxHinges);

}
