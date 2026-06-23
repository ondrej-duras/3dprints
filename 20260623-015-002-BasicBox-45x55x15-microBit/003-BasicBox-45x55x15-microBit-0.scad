// Basic Box - boxPool and boxCover
// 2026-06-22, Ondrej DURAS (dury) Nokia
/* [Preview] */
// parametricka krabicka urcena na prenasanie veci vo vrecku
// dolezitou vlastnostou su jej zaoblenia po stranach, aby
// netrhala nohavice a nedrala sa o stehno.
// dve casti: 
// spodna cast - vanicka - boxPool
// vrchna cast - deklik  - boxCover
preview="basic"; // [basic,plate]
$fn=30;  // pocet fradmentov kruhu (30 pri manipulacii 100 pri renderovani)
spi=0.2; // odsadenie na vnutornej casti
spo=0.2; // odsadenie na vonkajsej casti
spp=5.0; // odsadenie na vyrobnej doske
// vzdialenost vrchnaka od vanicky
distance=0; // [0:1:100] 

/* [Dimensions] */
// parametre krabicky idu v standartnom duchu : width,depth,hight,tick,round
// sirka krabicky - vonkajsi rozmer boxPool spodnej casti
boxWidth=45.0;  // [30:10:150]
// hlbka/dlzka krabicky - vonkajsi rozmer boxPool spodnej casti
boxDepth=55.0;  // [30:10:200] 
// vyska krabicky - vonkajsi rozmer boxPool spodnej casti
boxHight=15.0;   // [10:1:50]
// polomer zaoblenia vsetkych krabicky
boxRound=3.0;    // [0:0.1:20]
// hrubka materialu krabicky ...boxCover si ju musi pripocitat
boxTick=1.0;     // [0.5:0.1:5.0]

// Tabulka rozmerov
// 002 10x15x3-T2-R5  maxi (vacsia na plate 256x256x256 asi ani nevojde  205x150x30)
// 003 55x45x15-T1-R3 micro:bit

/* [Colors] */
colorBoxPoolOut="#208080"; // vonkajsia farba vanicky
colorBoxPoolInt="#208020"; // vnutorna farba vanicky
colorBoxCoverOut="#802020";
colorBoxCoverInt="#808020";


module boxRoundBottom(bw=boxWidth,bd=boxDepth,bh=boxHight,br=boxRound) {
// kvared/vanicka, leziaca zaoblenym dnom dole, hore je useknuta rovina

    union() {
    difference() {
        cube([bw,bd,bh]); // hlavny kvader, z ktoreho orezavame priestory pre zaoblenia
        translate([-1,-1,-1])       // lavy spodny bodny vyrez
            cube([br+1,bd+2,br+1]);
        translate([bw-br,-1,-1])    // pravy spodny bodny vyrez
            cube([br+1,bd+2,br+1]);
        translate([-1,-1,-1])       // predny spodny vyrez
            cube([bw+2,br+1,br+1]);
        translate([-1,bd-br,-1])    // zadny spodny vyrez
            cube([bw+2,br+1,br+1]);

        translate([-1,-1,-1])       // predny lavy rohovy vyrez
            cube([br+1,br+1,bh+2]);
        translate([bw-br,-1,-1])    // predny pravy rohovy vyrez
            cube([br+1,br+1,bh+2]);
        translate([-1,bd-br,-1])    // zadny lavy rohovy vyrez
            cube([br+1,br+1,bh+2]);
        translate([bw-br,bd-br,-1]) // zadny pravy rohovy vyrez
            cube([br+1,br+1,bh+2]);
    } // diff
        translate([br,br,br])    // lavy spodny/bodny  vyplnovaci valec
            rotate([-90,0,0])
            cylinder(h=bd-br-br,r=br);
        translate([bw-br,br,br]) // pravy spodny/bocny vypnovaci valec
            rotate([-90,0,0])
            cylinder(h=bd-br-br,r=br);
        translate([br,br,br])    // predny spodny vyplnovaci valec
            rotate([0,90,0])
            cylinder(h=bw-br-br,r=br);
        translate([br,bd-br,br]) // zadny spodny vyplnovaci valec
            rotate([0,90,0])
            cylinder(h=bw-br-br,r=br);

        translate([br,br,br])    // lavy predny rohovy vyplnovaci valec
            { cylinder(h=bh-br,r=br); sphere(r=br); }
        translate([bw-br,br,br])    // pravy predny rohovy vyplnovaci valec
            { cylinder(h=bh-br,r=br); sphere(r=br); }
        translate([br,bd-br,br])    // lavy zadny rohovy vyplnovaci valec
            { cylinder(h=bh-br,r=br); sphere(r=br); }
        translate([bw-br,bd-br,br])    // pravy zadny rohovy vyplnovaci valec
            { cylinder(h=bh-br,r=br); sphere(r=br); }

    } // union
} 

module boxPool(bw=boxWidth,bd=boxDepth,bh=boxHight,bt=boxTick,br=boxRound,ci=colorBoxPoolInt,co=colorBoxPoolOut) {
    bw2=bw-bt-bt; // vnutorne rozmery vanicky/vyhlbenia
    bd2=bd-bt-bt;
    bh2=bh-bt;

    difference() {
        color(co)
            boxRoundBottom(bw,bd,bh,br);
        color(ci)
            translate([bt,bt,bt])
            boxRoundBottom(bw2,bd2,bh,br);
        color(ci)
            translate([bw/2,-1,bw/2+bh*3/4])
            rotate([-90,0,0])
            cylinder(h=bd+2,d=bw);

    } // diff
}


module boxCover(bw=boxWidth,bd=boxDepth,bh=boxHight,bt=boxTick,br=boxRound,ci=colorBoxCoverInt,co=colorBoxCoverOut) {
    bw1=bw+bt+bt+spo+spo;
    bd1=bd+bt+bt+spo+spo;
    bh1=bh;

    bw2=bw1-bt-bt; // vnutorne rozmery vanicky/vyhlbenia
    bd2=bd1-bt-bt;
    bh2=bh1-bt;

    difference() {
        color(co)
            boxRoundBottom(bw1,bd1,bh1,br);
        color(ci)
            translate([bt,bt,bt])
            boxRoundBottom(bw2,bd2,bh,br);
        color(ci)
            translate([bw1/2,-1,bw1/2+bh1*3/4])
            rotate([-90,0,0])
            cylinder(h=bd1+2,d=bw1);

    } // diff
}

module placeBoxCover(bw=boxWidth,bd=boxDepth,bh=boxHight,bt=boxTick,br=boxRound,ci=colorBoxCoverInt,co=colorBoxCoverOut) {
    translate([bw+bt,-bt,bh+br])
        rotate([0,180,0])
        boxCover(bw,bd,bh,bt,br,ci,co);
    
}

module preview(preview=preview) {
    if(preview=="basic") {
        translate([0,0,0])
            boxPool();
        translate([0,0,distance])
            placeBoxCover(); 
    }

    if(preview=="plate") {
        translate([0,0,0])
            boxPool();
        translate([boxWidth+spp,0,0])
            boxCover();
    }
}
preview(preview);
// --- end ---

