// SlideBox - zasuvacia krabicka
// 20260627, Ondrej DURAS (dury) NOKIA
/* [Preview] */
// spodny diel - vanicka ako aj vrchny diel - vrchnak su dielce kodovo identicke
// jedinym rozdielom medzi vanickou a vrchnako je, ze vrchnal je hrubku materialu vacsi nez vanicka
$fn=20;
spi=0.1;
spo=0.1;
spp=5.0;

preview="basic"; // [basici,cubeRound,plate]

/* [Dimensions] */
boxWidth=50;
boxDepth=60;
boxHight=15;
boxTick=1.0;
boxRound=5.0;

/* [Colors] */
colorBoxPool="#802020";
colorBoxCover="#208020";

module cubeRound(bw=boxWidth,bd=boxDepth,bh=boxHight,bt=boxTick,br=boxRound) {
// kvader so zaoblenymi rohmi ... zaklad boxROund / SlideBox-u
// referencny box je lavy spodny predny roh "cube" 
// kvoli zaobleniam je referencny bod malinko mimo objektu
    union() {
    difference() {
        cube([bw,bd,bh]);
        translate([-1,-1,-1]) cube([bw+2,br+1,br+1]);       // predny spodny vyrez pre zaoblenie
        translate([-1,bd-br,-1]) cube([bw+2,br+1,br+1]);    //zadny spodny vyrez
        translate([-1,-1,bh-br]) cube([bw+2,br+1,br+1]);    // predny horny vyrez
        translate([-1,bd-br,bh-br]) cube([bw+2,br+1,br+1]); //zadny horny vyrez

        translate([-1,-1,-1]) cube([br+1,bd+2,br+1]);       //lavy spodny vyrez
        translate([bw-br,-1,-1]) cube([br+1,bd+2,br+1]);    //pravy spodny
        translate([-1,-1,bh-br]) cube([br+1,bd+2,br+1]);    //lavy horny
        translate([bw-br,-1,bh-br]) cube([br+1,bd+2,br+1]); //pravy horny

        translate([-1,-1,-1]) cube([br+1,br+1,bh+2]);       // lavy predny zvysly vyrez
        translate([bw-br,-1,-1]) cube([br+1,br+1,bh+2]);    // pravy predny
        translate([-1,bd-br,-1]) cube([br+1,br+1,bh+2]);    // lavy zadny
        translate([bw-br,bd-br,-1]) cube([br+1,br+1,bh+2]); // pravy zadny 
    } //diff
        translate([br,br,br]) cylinder(h=bh-2*br,r=br);        // lava predna valcova vypln
        translate([bw-br,br,br]) cylinder(h=bh-2*br,r=br);     // prava predna valcova vypln
        translate([br,bd-br,br]) cylinder(h=bh-2*br,r=br);     // lava zadna valcova vypln
        translate([bw-br,bd-br,br]) cylinder(h=bh-2*br,r=br);  // prava zadna valcova vypln

        translate([br,br,br]) rotate([-90,0,0]) cylinder(h=bd-2*br,r=br); //lava spodna zalcova vypln
        translate([bw-br,br,br]) rotate([-90,0,0]) cylinder(h=bd-2*br,r=br); //lava spodna zalcova vypln
        translate([br,br,bh-br]) rotate([-90,0,0]) cylinder(h=bd-2*br,r=br); //lava spodna zalcova vypln
        translate([bw-br,br,bh-br]) rotate([-90,0,0]) cylinder(h=bd-2*br,r=br); //lava spodna zalcova vypln

        translate([br,br,br]) rotate([0,90,0]) cylinder(h=bw-2*br,r=br);    // predna spodna valcova vypln
        translate([br,br,bh-br]) rotate([0,90,0]) cylinder(h=bw-2*br,r=br); // predna horna
        translate([br,bd-br,br]) rotate([0,90,0]) cylinder(h=bw-2*br,r=br);  // zadna spodna
        translate([br,bd-br,bh-br]) rotate([0,90,0]) cylinder(h=bw-2*br,r=br); //zadna vrchna

        translate([br,br,br]) sphere(r=br);        //lava spodna predna
        translate([bw-br,br,br]) sphere(r=br);     //prava spodna predna
        translate([br,br,bh-br]) sphere(r=br);     //lava horna predna
        translate([bw-br,br,bh-br]) sphere(r=br);  //lava horna predna

        translate([br,bd-br,br]) sphere(r=br);        //lava spodna zadna
        translate([bw-br,bd-br,br]) sphere(r=br);     //prava spodna zadna
        translate([br,bd-br,bh-br]) sphere(r=br);     //lava horna zadna
        translate([bw-br,bd-br,bh-br]) sphere(r=br);  //lava horna zadna
    } //union
}

module slideBox_1OFF(bw=boxWidth,bd=boxDepth,bh=boxHight,bt=boxTick,br=boxRound) {
    difference() {
        color(colorBoxCover)
        translate([0,0,0])
            cubeRound(bw,bd,bh,bt,br);
        color(colorBoxPool)
        translate([bt-spo,-2*bt+spo,-bt+spo])
            cubeRound(bw-2*bt+2*spo,bd+bt,bh,bt,br);
    }
}

module slideBox(bw=boxWidth,bd=boxDepth,bh=boxHight,bt=boxTick,br=boxRound) {
    difference() {
        color(colorBoxCover)
        translate([0,0,0])
            cubeRound(bw,bd,bh,bt,br);
        color(colorBoxPool)
        translate([bt,-2*bt,bt])
            cubeRound(bw-2*bt,bd+bt,bh,bt,br);
    }
}

module slideBoxIn(bw=boxWidth,bd=boxDepth,bh=boxHight,bt=boxTick,br=boxRound) {
    slideBox(bw-2*bt-2*spi,bd-bt,bh-bt,bt,br);
}

module preview(preview=preview) {
    if(preview=="basic") {
        color(colorBoxPool)
        slideBox();
    }
    if(preview=="cubeRound") {
        color(colorBoxPool)
        cubeRound();
    }
    if(preview=="plate") {
        translate([0,0,0])
            slideBox();
        translate([boxWidth+spp,0,0])
            slideBoxIn();
    }
}
preview();
