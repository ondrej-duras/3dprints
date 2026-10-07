// uniBox - pizzaBox Chasiss
// 20260917, Ondrej DURAS NOKIA Public OpenWare GNU/GPLv2
/* [PREVIEW] */
preview="basic"; // [basic,plate,bases,covers]

$fn=100;   // pocet fragmentov kruhu
spi=0.2;   // odsadenie od kolika
spo=0.2;   // odsadenie v diere
spp=5.0;   // odsadenie medzi suciastkami na vyrobnej doske
head=0.4;  // primer 3D tlacovej hlavy tlaciarne / podstava bodky filamentu
slise=0.2; // vyska bodky filamenty / hrubka jednej tlacovej vrstvy

shift=10;  // [0:1:100]  /posun suciatky oproti inej suciastke v pracovnej polohe basic

MM=5;  // pocet vyrobkov na sirku
NN=4;  // pocet vyrobkov na hlbku

// F1..F4 - povolenie pouzitia filamentov
// MONOchromatic - pouzitie iba jedneho filamentu - ked skusame zrnitost modelu (1 filament 13min 4filamenty 1h3min)

F1=true;    // [0:Enabled 1:Disabled] Extruder_1
F2=true;    // [0:Enabled 1:Disabled] Extruder_2
F3=true;    // [0:Enabled 1:Disabled] Extruder_3
F4=true;    // [0:Enabled 1:Disabled] Extruder_4
MONO=false; // [0:Enabled 1:Disabled] 


/* [COLORS] */
// Svetla farebna schema (krabicky, skrinky, stoziare, anteny)
C1="#c0c0c0"; // Extruder_1 Biela
C2="#c09090"; // Extruder_2 Cervena
C3="#90c090"; // Extruder_3 Zelena
C4="#9090c0"; // Extruder_4 Modra
// Tmava farebna schema (routre, suciastky)
C5="#505050"; // Extruder_1 Siva plechy chassis
C6="#101010"; // Extruder_2 Cierna - konektory
C7="#c0c0c0"; // Extruder_3 Kovova - chladice
C8="#4040c0"; // Extruder_4 Zelena/Modra - PCB doska plosneho spoja
C9="#707070"; // Extruder_1 Siva plechy chassis, trosku ina kvoli rozliseniu

// GREY varianta svetlej farebnej schemy (skatulky,skrinky,stoziare)
G1="#c0c0c0"; // Extruder_1 Biela                    (was #c0c0c0)
G2="#9e9e9e"; // Extruder_2 Cervena                  (was #c09090)
G3="#acacac"; // Extruder_3 Zelena                   (was #90c090)
G4="#959595"; // Extruder_4 Modra                    (was #9090c0)
G5="#505050"; // Extruder_1 Siva plechy chassis      (was #505050) // GREY Varianta tmavej farebnej chemy (routre)
G6="#101010"; // Extruder_2 Cierna - konektory       (was #101010)
G7="#c0c0c0"; // Extruder_3 Kovova - chladice        (was #c0c0c0)
G8="#4f4f4f"; // Extruder_4 Zelena/Modra - PCB doska (was #4040c0)
G9="#707070"; // Extruder_1 Siva plechy chassis 2    (was #707070)

/* [EXTRUDERS] */
// extrudery, ktore idu do systemu ako premmena "e" do "F"

EXTRUDER_1=1;
EXTRUDER_2=2;
EXTRUDER_3=3;
EXTRUDER_4=4;

/* [COLOR_INDEX] */
// indexy farieb (tu neriesime farebnu/grey schemu)

WHITE=1;  // zakladny material - mramorovy filament
RED=2;
GREEN=3;
BLUE=4;
PLATE=5;  // vonkajsie plechy - base
RUBER=6;  // umelohmotne obaly
METAL=7;  // kov chladicov
BOARD=8;  // doska plosnych spojov
PLATX=9;  // vonkajsie plechy - trochu inde kvoli rozliseniu - cover

FF=[0,F1,F2,F3,F4]; // povolenie jednotlivych extruderov
// pouzitie farebnych filamentov
FC = (MONO==false) ? ["",C1,C2,C3,C4,C5,C6,C7,C8,C9] // farebne
                   : ["",G1,G2,G3,G4,G5,G6,G7,G8,G9] // sive
                   ; // pridelenie RGB jednotlivymi farebnym indexom

FE = (MONO==false) ? [0 ,1 ,2 ,3 ,4 ,1 ,2 ,3 ,4 ,1 ] // farebne
                   : [0 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ] // sive
                   ; // pridelenie extruderov jedotlivym farebnym idexom

// O com je taky zlozity model farieb ?
// aby jednemu extruderu mohlo byt pridelenych viacero farieb

/* [Dimensions] */
boxObj=object(
  width=44.0,    // standartna sirka 19" v mierke 1:10
  depth=26.5,    // hlbka bezneho 1RU switcha
  hight=5.0,     // 1RU ... by malo byt 44.5mm 1:10 bude 5mm
  tick=0.4,      // 0.4 hrubka jednej pevnej dosky objektu
  faceTick=1.0,  // hrubka prednej listy
  portWidth=1.2, // sirka diery portu
  portSpace=1.6, // rozostup medzi portami (zahrnajuci aj sirku portu)
  portHight=0.8  // vyska portu (USB sa pocita ako polovica tejto vysky)
);
// Cat-6 RJ-45 connector with=11.7mm depth=21.5mm hight=8.1mm
// cube([1.2,2.2,0.8]); - diera pre rj45
box1=object(boxObj);

module F(e,c) {
// e = extruder, c = color
// 0.299·R + 0.587·G + 0.114 = vzorec transformacie RGB na GREY
  if((FF[e]==true) && (e==FE[c])) { color(FC[c]) children(); }
  else {}
}


module uniBoxBase(f,p=box1,t="orion") {
// spodna cast pizzaBox-u s prednym celom
// referencny bod je vredu vlavo dole v rohu celneho plechu
    ports=[0,0,1,1,1,1,1,1,0,1,1,1,1,1,1,0,1,1,1,2,0,3];
    front=1; // vyrezy v cele routra
    ruber=1; // gumene komory portov za celom routra
    union() {
    F(f,PLATE) union() {
        translate([0,0,0]) cube([p.width,p.depth,p.tick]); // zakladny plech
        difference() {
        translate([p.tick,0,0]) cube([p.width-2*p.tick,p.faceTick,p.hight-p.tick]); // celo chassis
            if(front==1) {
                for (i=[0:1:len(ports)-1]) {
                    x=p.width-i*p.portSpace;
                    if(ports[i]==1) { // bezny jednoradovy port
                        translate([x,-1,p.tick*2])    // SFP Port
                        cube([p.portWidth,2+p.faceTick,p.portHight]); // jedna diera
                    }
                    if(ports[i]==2) { // dva porty nad sebou
                        translate([x,-1,p.tick*5])    // vrchna diera
                        cube([p.portWidth,2+p.faceTick,p.portHight]); 

                        translate([x,-1,p.tick*2])    // spodna diera
                        cube([p.portWidth,2+p.faceTick,p.portHight]); 
                    }
                    if(ports[i]==3) { // dva porty nad sebou a medzi nimi jeden tenky-USB
                        translate([x,-1,p.tick*7])    // vrchna diera
                        cube([p.portWidth,2+p.faceTick,p.portHight]); 

                        translate([x,-1,p.tick*5])    // vrchna diera
                        cube([p.portWidth,2+p.faceTick,p.portHight/2]); 

                        translate([x,-1,p.tick*2])    // spodna diera 
                        cube([p.portWidth,2+p.faceTick,p.portHight]); 
                    }
                }
            } //front
        }
        difference() { // lavy predny zachyt
            translate([p.tick,p.faceTick,p.tick])
                cube([p.tick*3,p.depth/10,p.hight/2]);
            translate([p.tick,p.faceTick,p.hight/3])  
                rotate([-90,0,0])
                cylinder(h=p.depth, d=p.hight/4);
        }
        difference() { // pravy predny zachyt
            translate([p.width-p.tick-p.tick*3,p.faceTick,p.tick])
                cube([p.tick*3,p.depth/10,p.hight/2]);
            translate([p.width-p.tick,p.faceTick,p.hight/3])  
                rotate([-90,0,0])
                cylinder(h=p.depth, d=p.hight/4);
        }
        difference() { // lavy zadny zachyt
            translate([p.tick,p.depth-p.depth/10-p.tick,p.tick])
                cube([p.tick*3,p.depth/10,p.hight/2]);
            translate([p.tick,p.depth-p.depth/10-p.tick-0.001,p.hight/3])  
                rotate([-90,0,0])
                cylinder(h=p.depth+0.002, d=p.hight/4);
        }
        difference() { // pravy zadny zachyt
            translate([p.width-p.tick-p.tick*3,p.depth-p.depth/10-p.tick,p.tick])
                cube([p.tick*3,p.depth/10,p.hight/2]);
            translate([p.width-p.tick,p.depth-p.depth/10-p.tick-0.001,p.hight/3])  
                rotate([-90,0,0])
                cylinder(h=p.depth+0.002, d=p.hight/4);
        }
    } //uni PLATE
    F(f,BOARD) difference() {
        translate([p.tick,p.faceTick,p.tick]) 
            cube([p.width-2*p.tick,p.depth-p.tick-p.faceTick,p.tick]);  // zakladna doska plosnych spojov - PCB - BOARD

            //odrezky z PCB aby to nepreblikovalo
            translate([p.tick-0.001,p.faceTick-0.001,p.tick-0.001])                   // lavy predny zachyt
                cube([p.tick*3+0.001,p.depth/10+0.001,p.hight/2+0.002]);

            translate([p.width-p.tick-p.tick*3,p.faceTick-0.001,p.tick-0.001]) // pravy predny zachyt
                cube([p.tick*3+0.001,p.depth/10+0.001,p.hight/2+0.002]);

            translate([p.tick-0.001,p.depth-p.depth/10-p.tick,p.tick-0.001])   // lavy zadny zachyt
                cube([p.tick*3+0.001,p.depth/10+0.001,p.hight/2+0.002]);

            translate([p.width-p.tick-p.tick*3,p.depth-p.depth/10-p.tick,p.tick-0.001]) // pravy zadny zachyt
                cube([p.tick*3+0.001,p.depth/10+0.001,p.hight/2+0.002]);
    } //diff BOARD
    F(f,RUBER) union() {
            if(front==1) {
                for (i=[0:1:len(ports)-1]) {
                    x=p.width-i*p.portSpace;
                    if(ports[i]==1) { // bezny jednoradovy port
                        translate([x,p.faceTick,p.tick*2])
                        cube([p.portWidth,2+p.faceTick,p.portHight]);
                    }
                    if(ports[i]==2) { // dva porty nad sebou
                        translate([x,p.faceTick,p.tick*2])
                        cube([p.portWidth,2+p.faceTick,p.tick*3+p.portHight]); 
                    }
                    if(ports[i]==3) { // dva porty nad sebou a medzi nimi jeden tenky-USB
                        translate([x,p.faceTick,p.tick*2])
                        cube([p.portWidth,2+p.faceTick,p.tick*5+p.portHight]); 
                    }
                }
            } //front
    } // uni RUBER
    F(f,METAL) union() {
        p2=p.tick*2;
        w2=p.width/10;
        d2=p.depth/10;
        translate([p.width/2-w2,p.depth/2-d2,p2])
            cube([2*d2,2*d2,p2]);
    } //uni METAL
    } // uni module
}

module uniBoxCover(f,p=box1) {
// horna cast pizzaBox-u, prikryvajuca vsetko
// tu vo vyrobnej polohe.
// referencny bod je vpredu vlavo dole pred rohom plechu
    F(f,PLATX) union() {
        translate([0,0,0]) cube([p.width,p.depth,p.tick]); // vrchny plech
        translate([0,0,0]) cube([p.tick,p.depth,p.hight-p.tick]); // pravy plech
        translate([p.width-p.tick,0,0]) cube([p.tick,p.depth,p.hight-p.tick]); //lavy plech
        translate([0,p.depth-p.tick,0]) cube([p.width,p.tick,p.hight-p.tick]); //zadny plech

        d1=p.hight/4;  // priemer valca zachytneho body dekla
        r1=d1/2;       // polomer valca zachytneho body
        h1=p.depth/10; // dlzka zachytu smerom do hlbky

        translate([p.tick-spi,p.faceTick,p.hight*2/3])  //lavy predny zachyt
            rotate([-90,0,0])
            intersection() {
                cylinder(h=h1,d=d1);
                translate([0,-r1,0])
                cube([d1,d1,h1]);
            }

        translate([p.width-p.tick+spi,p.faceTick,p.hight*2/3])  //pravy predny zachyt
            rotate([-90,0,0])
            intersection() {
                cylinder(h=h1,d=d1);
                translate([-d1,-r1,0])
                cube([d1,d1,h1]);
            }

        translate([p.tick-spi,p.depth-h1-p.tick,p.hight*2/3])  //lavy zadny zachyt
            rotate([-90,0,0])
            intersection() {
                cylinder(h=h1,d=d1);
                translate([0,-r1,0])
                cube([d1,d1,h1]);
            }

        translate([p.width-p.tick+spi,p.depth-h1-p.tick,p.hight*2/3])  //pravy predny zachyt
            rotate([-90,0,0])
            intersection() {
                cylinder(h=h1,d=d1);
                translate([-d1,-r1,0])
                cube([d1,d1,h1]);
            }

    }
}

module basicUniBox(f,p=box1) {
    translate([0,0,0]) uniBoxBase(f,p);
    translate([p.width,shift,p.hight]) rotate([0,-180,0]) uniBoxCover(f,p);
}

module plateUniBox(f,p=box1) {
    translate([0,0,0]) uniBoxBase(f,p);
    translate([p.width+spp,0,0]) uniBoxCover(f,p);
}

module preview(f,preview=preview) {
    if(preview=="basic") basicUniBox(f,box1);
    if(preview=="plate") plateUniBox(f,box1);
}

preview(EXTRUDER_1); // zobrazenie vsetkych styroch materialov
preview(EXTRUDER_2);
preview(EXTRUDER_3);
preview(EXTRUDER_4);

