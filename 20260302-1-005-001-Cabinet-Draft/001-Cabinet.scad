// Telco Cabinet - common 2G example
// 20260109, Ondrej DURAS (dury) NOKIA 
/* [Preview] */
preview="basic"; // [basic,detail,movie,plate]
doorPull=-10;    // [-20:0]
roofPull=0;      // [0:30]

/* [Dimensions] */

padding=10;    // rozostup medzi vecami na vyrovnej doske
spacingO=0.1;  // vonkajsi odstup dotykajucich sa casti - IN  - skrutku "I" do matice "O"
spacingI=0.1;  // vnutorny odstup dotykajucich sa casti - OUT - palicu "I" pichame do diery "O"
sysTick=2.0;   // hrubka steny - zakladny rozmer
clueDimm=4.0;  // hrana  prepojovacieho stvorca
clueTick=1.0;  // hrubka prepojovacieho stvorca
spo=spacingO;
spi=spacingI;
pad=padding;

lineWidth=40;  // sirka karty
lineDepth=40;  // hlbka karty
lineHight=4;   // vyska karty
lineTick=1.0;  // hrubka dosky
fanWidth=20;   // sirka ventilatora
fanDepth=15;   // hlbka ventilatora ... iz droja, pozor ! rucky sa nerataju
fanHight=20;   // vyska ventilatora
psuWidth=13;   // sirka zdroja (3 zdroje pre chassis)
psuHight=15;   // vyska zdroja a Filtrov
psuDepth=40;   // hlbka zdroja
filtWidth=40;  // firka filtra 
filtHight=15;  // vyska filtra = musi byt rovnaka ako vyska zdroja
filtDepth=15;   // hlbka filtra

cabWidth=140;  // sirka kabinetu tecoTower-a
cabHight=80;   // vyska kabinetu
cabDepth=50;   // hlbka kabinetu
cabTick=2.0;
doorWidth=50;
doorHight=70;
door1at=15;      // umiestnenie 1.dveri od odkraja skrinky, 2.dvere nizsie 
pantStick=3.5;    // hrubka pantoveho valca
pantDepth=6;      //hrubka podlozky pantu
lockHight=16;     // vyska zamku na dverach
lockDepth=4;      // hrubka zamku na dverach
lockWidth=4;      // sirka zamku na dverach
lockExcav=2;      // Excavation - Vyhlbenie do hranola (normalny rozmer - vyhlbenie)

// musi platit : psuDepth+filtDepth = lineDepth + fanDepth
// dohromady spolu by mal byt vlastne iba jeden spacing
// spacing0 + spacingi = spacing
// spacing:
// 0.0 - masaker, veci ktore do seba nezastrcis
// 0.1 - naozaj na pevno, aj zlomis ...a uz nevytiahnes.
// 0.2 - ide tazko, casom sa trosku rozbeha
// 0.3 - neviem
// 0.4 - urcite bude vypadavat

/* [Colors] */

colorW = "#e0e0e0"; // ostro biela
colorL = "#c0c0c0"; // velmi svetla
colorS = "#808080"; // siva - zakladna
colorD = "#404040"; // tmava - Dark
colorK = "#202020"; // uplne cierna
colorR = "#802020"; // cervena
colorG = "#208000"; // zelena
colorB = "#202080"; // modra

colorCabinet = "#808080";  // farba bocnych stien skrinky
colorDoor = "#808020";     // farba dveri
colorPant = "#101090";     // farba pantov na dverach
colorLock = "#105590";     // farba zamku na dverach
colorRoof = "#104080";     // farba vrchu a spodku kabinetu

/* [Calculations] */

door2at=cabWidth-door1at-doorWidth; // umiestnenie 2.dveri od odkraja skrinky
doorBase=(cabHight-doorHight)/2;
doorTick=cabTick;   // hrubka dveri = hrubke stien skrine
/* [Modules] */


module cabPant() {
    union() {
        translate([2,-pantDepth/2-spi-spo,0])
            cylinder(h=8,d=pantStick-spi);
        difference() {
            translate([0,-pantDepth,-8])
                cube([4,pantDepth,8]);
            translate([-1,-pantDepth,0])
                rotate([210,0,0])
                cube([6,pantDepth,10]);
        }
    } 
}

module leftPant() {
   difference() { 
        union() {
            translate([5,-1,0])   // spojka medzi pantom a dverami
                cube([12,1.5,4]);
            translate([2,-pantDepth,0])  // hranol
                cube([16,pantDepth-spi-spo,4]);
            translate([2,-pantDepth/2-spi-spo,0])  // a cylinder vonkajsej casti
                cylinder(h=4,d=pantDepth-spi-spo);
        }
        translate([2,-pantDepth/2-spi-spo,-1]) // diera
            cylinder(h=6,d=pantStick+spo);
        translate([10,-2*pantDepth,-1])    // zrezanie hranolu
            rotate([0,0,30])
            cube([16,pantDepth,6]);
    }
}

module rightPant() {
   difference() { 
        union() {
            translate([-13,-1,0])   // spojka medzi pantom a dverami
                cube([12,1.5,4]);
            translate([-14,-pantDepth,0])  // hranol
                cube([16,pantDepth-spi-spo,4]);
            translate([2,-pantDepth/2-spi-spo,0])  // a cylinder vonkajsej casti
                cylinder(h=4,d=pantDepth-spi-spo);
        }
        translate([2,-pantDepth/2-spi-spo,-1]) // diera
            cylinder(h=6,d=pantStick+spo);
        translate([-6,-1*pantDepth,-1])    // zrezanie hranolu
            rotate([0,0,150])
            cube([16,pantDepth,6]);
    }

}

module leftLock() {  // referencny bod je uprostred hlavneho kvadru  vlavo vzadu
    difference() {
        translate([0,-lockDepth,-lockHight/2])
            cube([lockWidth,lockDepth,lockHight]);
        translate([-1,-lockDepth+lockExcav,-lockHight/2+lockExcav])
            cube([lockWidth-lockExcav+1,lockDepth-lockExcav,lockHight-2*lockExcav]);
    }
}
module rightLock() {
    difference() {
        translate([0,-lockDepth,-lockHight/2])
            cube([lockWidth,lockDepth,lockHight]);
        translate([lockExcav,-lockDepth+lockExcav,-lockHight/2+lockExcav])
            cube([lockWidth-lockExcav+1,lockDepth-lockExcav,lockHight-2*lockExcav]);
    }
}

module cabinetBody() {
    union() {
    difference() {
        cube([cabWidth,cabDepth,cabHight]);
        translate([cabTick-spo,cabTick-spo,-1])
            cube([cabWidth-2*cabTick+2*spo,cabDepth-2*cabTick+2*spo,cabHight+2]);
        translate([door1at,-1,doorBase])
            cube([doorWidth+2*spo,cabTick+2,doorHight+2*spo]);
        translate([door2at,-1,doorBase])
            cube([doorWidth+2*spo,cabTick+2,doorHight+2*spo]);
    }
        translate([door1at-4,0,doorBase+doorHight*6/7])
            cabPant();
        translate([door1at-4,0,doorBase+doorHight*1/7])
            cabPant();
        translate([cabWidth-15,0,doorBase+doorHight*6/7])
            cabPant();
        translate([cabWidth-15,0,doorBase+doorHight*1/7])
            cabPant();
    }
}

module cabinetRoof() {  // v polohe na vyrobnej doske
    union() {
        translate([0,0,0])
            cube([cabWidth,cabDepth,cabTick]);
        difference() {
            translate([cabTick+spi,cabTick+spi,cabTick])
                cube([cabWidth-2*cabTick-spi,cabDepth-2*cabTick-spi,doorBase]);
            translate([cabTick*2-spo,cabTick*2-spo,cabTick*2-spo])
                cube([cabWidth-4*cabTick+2*spo,cabDepth-4*cabTick+2*spo,doorBase+1]);
        }
    }
}

module cabinetRoofTop() {
    translate([0,cabDepth,cabTick])
        rotate([180,0,0])
        cabinetRoof();
}

module modCabinet() {
    color(colorCabinet)
    cabinetBody();

    color(colorRoof)
    translate([0,0,cabHight+roofPull])
    cabinetRoofTop();

    color(colorRoof)
    translate([0,0,-cabTick-roofPull])
    cabinetRoof();
    
}

module doorLeft() {
    color(colorDoor)
    union() {
        translate([0,0,0])   // doska dveri
            cube([doorWidth,doorTick,doorHight]);    
        translate([-4,0,doorHight*6/7+spi])  // horny pant
            leftPant();
        translate([-4,0,doorHight*1/7+spi])  // dolny pant
            leftPant();
        translate([doorWidth-lockWidth*2,0,doorHight/2])
            leftLock();
    }
}
module doorRight() {
    color(colorDoor)
    union() {
        translate([0,0,0])  // doska dveri
            cube([doorWidth,doorTick,doorHight]);    
        translate([doorWidth,0,doorHight*6/7+spi])  // horny pant
            rightPant();
        translate([doorWidth,0,doorHight*1/7+spi])  // dolny pant
            rightPant();
        translate([lockWidth,0,doorHight/2])
            rightLock();
    }
}

/* [Previews] */
if(preview=="basic") {
    translate([0,0,0])
        modCabinet();

    translate([-40,0,0])
        cabPant();
    translate([-20,0,0])
        cabPant();
    translate([-20,0,0])
        leftPant();
    translate([-20,-10,0])
        leftPant();

    translate([-40,20,0])
        cabPant();
    translate([-20,20,0])
        cabPant();
    translate([-20,20,0])
        rightPant();
    translate([-20,10,0])
        rightPant();

    translate([door1at,doorPull,doorBase])
        doorLeft();
    translate([door2at,doorPull,doorBase])
        doorRight();
}

if(preview=="plate") {
    translate([0,0,0])
        cabinetRoof();
    translate([0,cabDepth+pad,0])
        cabinetRoof();
    translate([0,cabDepth*2+pad*2,0])
        cabinetBody();
    translate([cabWidth+pad,0,cabTick])
        rotate([-90,0,0])
        doorLeft();
    translate([cabWidth+pad,doorHight+pad,cabTick])
        rotate([-90,0,0])
        doorRight();


}

/* [NOTEs] */
// 1. v gramatike SCAD nastavit hviezdickovy fold ako uroven-2, ostatne if/module ako uroven-1
// 2. v Towers ... opravit spacing, zmenit spacing na holderoch na spacing-I (0.0mm)  a vsade inde na spacing-O (0.2mm) 
// 3. urobit experiment, ci spacingI/O zafunguje a pripadne podla toho opravit spacing 014-mSR7-i2
// 4. vyskusat zavit
// 5. zaviest zavit do vnutra kolieska
// 6. 014-mSR7-i3 na baze 4mm = lineCardHeight, skusit, ci by sa take nieco dalo
// 7. 014-mSR7-i4 zalozeny na dimenziach vyskaKarty=4mm sirkaKarty=40mm sirkaRacku=50mm hlbkaKarty=??pozri hlbkaZdroja=15mm
// 8. telcoTower s trojuholnikovym zakladom
// 9. RRFU - to su tie vonkajsie jednotky - koncove stupne radia
//10. Vyskusat 1.0mm kabel (medeny drot) 0.6mm kabel (ocelovy drot)

// --- end ---
