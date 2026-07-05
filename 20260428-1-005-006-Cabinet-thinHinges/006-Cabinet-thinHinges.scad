// Telco Cabinet - common 2G example
// 20260109, Ondrej DURAS (dury) NOKIA 
/* [Preview] */
preview="basic"; // [basic2,basic4,hinges,detail,movie,plate2,plate4]
doorPull=10;     // [0:40]
roofPull=0;      // [0:40]
$fn=100;         // pocet fragmentov kruhu/cylindra

/* [Dimensions of Cabinet] */

cabWidth=50;   // [70:140] 75 sirka kabinetu tecoTower-a
cabHight=40;   // [50:100] 60 vyska kabinetu
cabDepth=20;   // [20:70]  30 hlbka kabinetu
cabTick=1.0;   // [1:0.1:3] 2.0 hrubka steny kabinetu 
doorWidth=18;  // [30:60]  30 sirka dveri
doorHight=30;  // [40:80]  40 vyska dveri
door1at=5;     // [5:1:20] umiestnenie 1.dveri od odkraja skrinky, 2.dvere nizsie 
pantStick=2;   // [0.2:0.1:5.0] hrubka pantoveho valca
pantPeak=5;    // [0.5:0.1:8]  vyska pantoveho valca v zarubni
pantDepth=4;   // [0.3:0.1:7.0]  hrubka podlozky pantu
pantWidth=7;   // [0.5:0.5:20] sirka kovania na lavom i pravom pante
pantHight=4;   // [0.5:0.1:4]  vyska pantu ...kovania aj valcovej casti
lockHight=10;  // vyska zamku na dverach
lockDepth=4;   // hrubka zamku na dverach
lockWidth=4;   // sirka zamku na dverach
lockExcav=1;   // Excavation - Vyhlbenie do hranola (normalny rozmer - vyhlbenie)

// musi platit : psuDepth+filtDepth = lineDepth + fanDepth
// dohromady spolu by mal byt vlastne iba jeden spacing
// spacing0 + spacingi = spacing
// spacing:
// 0.0 - masaker, veci ktore do seba nezastrcis
// 0.1 - naozaj na pevno, aj zlomis ...a uz nevytiahnes.
// 0.2 - ide tazko, casom sa trosku rozbeha
// 0.3 - neviem
// 0.4 - urcite bude vypadavat

/* [Dimensions of Common Items] */
padding=10;    // [2:1:20] rozostup medzi vecami na vyrovnej doske
spacingO=0.10; // vonkajsi odstup dotykajucich sa casti - IN  - skrutku "I" do matice "O"
spacingI=0.10; // vnutorny odstup dotykajucich sa casti - OUT - palicu "I" pichame do diery "O"
hingeSpi=0.15; // special spi pre pohyblive casti - pant
hingeSpo=0.15; // special spo pre pohyblive casti - pant
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
        translate([2,-pantDepth/2-hingeSpi-hingeSpo,0])
            cylinder(h=pantPeak,d=pantStick-2*hingeSpi);
        difference() {
            translate([0,-pantDepth,-8])
                cube([4,pantDepth,8]);
            translate([-1,-pantDepth,0])
                rotate([210,0,0])
                cube([6,pantDepth,10]);
        }
    } 
}

module leftPant() { // pant na dverach otvaranych do lava
   difference() { 
        union() {
            translate([pantDepth,-1,0])   // spojka medzi pantom a dverami
                cube([pantWidth-pantDepth/2,1.5,pantHight]);
            translate([pantDepth/2,-pantDepth/3,0])  // hranol
                cube([pantWidth,pantDepth/3-hingeSpi-hingeSpo,pantHight]);
            translate([pantDepth/2,-pantDepth/2-hingeSpi-hingeSpo,0])  // a cylinder vonkajsej casti
                cylinder(h=pantHight,d=pantDepth-hingeSpi-hingeSpo);
        }
        translate([pantDepth/2,-pantDepth/2-hingeSpi-hingeSpo,-1]) // diera
            cylinder(h=pantHight+2,d=pantStick+2*hingeSpo);
        //translate([10,-2*pantDepth,-1])    // zrezanie hranolu
        //    rotate([0,0,30])
        //    cube([16,pantDepth,6]);
    }
}

module rightPant() { // pant na dverach otvaranych do prava
   difference() { 
        union() {
            translate([-pantWidth+pantDepth/2,-1,0])   // spojka medzi pantom a dverami
                cube([pantWidth-pantDepth/2,1.5,pantHight]);
            translate([-pantWidth+pantDepth/2,-pantDepth/3,0])  // hranol
                cube([pantWidth,pantDepth/3-hingeSpi-hingeSpo,pantHight]);
            translate([pantDepth/2,-pantDepth/2-hingeSpi-hingeSpo,0])  // a cylinder vonkajsej casti
                cylinder(h=pantHight,d=pantDepth-hingeSpi-hingeSpo);
        }
        translate([pantDepth/2,-pantDepth/2-hingeSpi-hingeSpo,-1]) // diera
            cylinder(h=pantHight+2,d=pantStick+hingeSpo);
        //translate([-6,-1*pantDepth,-1])    // zrezanie hranolu
        //    rotate([0,0,150])
        //    cube([16,pantDepth,6]);
    }

}

module leftLock() {  // referencny bod je uprostred vysky hlavneho kvadru  vlavo vzadu
    difference() {
        translate([0,-lockDepth,-lockHight/2])      // hlavny hranol, z ktoreho budeme rezat
            cube([lockWidth,lockDepth,lockHight]);
        translate([-1,-lockDepth+lockExcav,-lockHight/2+lockExcav])  // vyrez z lavej strany
            cube([lockWidth-lockExcav+1,lockDepth-lockExcav,lockHight-2*lockExcav]); //vyzer normalny, na hrubku matrosa
            //cube([lockWidth+2,lockDepth-lockExcav,lockHight-2*lockExcav]); //vyrez prestreleny na druhu stranu
    }
}
module rightLock() { //referencny bod je uprostred vysky hlavneho kvadra, vlavo vzadu
    difference() {
        translate([0,-lockDepth,-lockHight/2])
            cube([lockWidth,lockDepth,lockHight]);
        translate([lockExcav,-lockDepth+lockExcav,-lockHight/2+lockExcav]) //vyrez z pravejstrany
            cube([lockWidth-lockExcav+1,lockDepth-lockExcav,lockHight-2*lockExcav]); //vyrez normalny, na hrubku matrosa
        //translate([-1,-lockDepth+lockExcav,-lockHight/2+lockExcav])
        //    cube([lockWidth+2,lockDepth-lockExcav,lockHight-2*lockExcav]); // vyrez prestreleny na druhu stranu
    }
}
module uniLock() {  //referencny bod je uprostred vysky hlavneho kvadra, vlavo vzadu
    difference() {
        translate([0,-lockDepth,-lockHight/2])     // hlavny hranol
            cube([lockWidth,lockDepth,lockHight]);
        translate([-1,-lockDepth+lockExcav,-lockHight/2+lockExcav])
            cube([(lockWidth-lockExcav)/2+1,lockDepth-lockExcav,lockHight-2*lockExcav]);
        translate([(lockWidth+lockExcav)/2,-lockDepth+lockExcav,-lockHight/2+lockExcav])
            cube([(lockWidth-lockExcav)/2+1,lockDepth-lockExcav,lockHight-2*lockExcav]);
            
    }
}
module cabinetBody2() {
    union() {
    difference() {
        cube([cabWidth,cabDepth,cabHight]);  // vonkajsi hruby kvare, z ktoreho sa vyrezava
        translate([cabTick-spo,cabTick-spo,-1])
            cube([cabWidth-2*cabTick+2*spo,cabDepth-2*cabTick+2*spo,cabHight+2]); // kvadrovy vyrez vnutorneho priestoru
        translate([door1at,-1,doorBase])
            cube([doorWidth+2*spo,cabTick+2,doorHight+2*spo]);  // vyrez lavych dveri
        translate([door2at,-1,doorBase])
            cube([doorWidth+2*spo,cabTick+2,doorHight+2*spo]);  // vyrez pravych dveri
    }
        translate([cabWidth/2-cabTick/2,0,doorBase])  // spodna spojovacia prepazka
            cube([cabTick,cabDepth,doorBase]);
        translate([cabWidth/2-cabTick/2,0,cabHight/2-doorBase/2])  // prostredna spojovacia prepazka
            cube([cabTick,cabDepth,doorBase]);
        translate([cabWidth/2-cabTick/2,0,cabHight-doorBase-doorBase])  // spodna spojovacia prepazka
            cube([cabTick,cabDepth,doorBase]);

        translate([door1at-4,0,doorBase+doorHight*6/7])   // hodny lavy pant
            cabPant();
        translate([door1at-4,0,doorBase+doorHight*1/7])   // dolny lavy pant
            cabPant();
        translate([cabWidth-door1at,0,doorBase+doorHight*6/7])  // horny pravy pant
            cabPant();
        translate([cabWidth-door1at,0,doorBase+doorHight*1/7])  // dolny pravy pant
            cabPant();
    }
}

module cabinetBody4() {
    union() {
    difference() {
        cube([cabWidth,cabDepth,cabHight]);  // vonkajsi hruby kvare, z ktoreho sa vyrezava
        translate([cabTick-spo,cabTick-spo,-1])
            cube([cabWidth-2*cabTick+2*spo,cabDepth-2*cabTick+2*spo,cabHight+2]); // kvadrovy vyrez vnutorneho priestoru

        translate([door1at,-1,doorBase])
            cube([doorWidth+2*spo,cabTick+2,doorHight+2*spo]);  // vyrez lavych prednych dveri
        translate([door2at,-1,doorBase])
            cube([doorWidth+2*spo,cabTick+2,doorHight+2*spo]);  // vyrez pravych prednych dveri

        translate([door1at,cabDepth-cabTick-1,doorBase])
            cube([doorWidth+2*spo,cabTick+2,doorHight+2*spo]);  // vyrez lavych zadnych dveri
        translate([door2at,cabDepth-cabTick-1,doorBase])
            cube([doorWidth+2*spo,cabTick+2,doorHight+2*spo]);  // vyrez pravych zadnych dveri
    }
        translate([cabWidth/2-cabTick/2,0,doorBase])  // spodna spojovacia prepazka
            cube([cabTick,cabDepth,doorBase]);
        translate([cabWidth/2-cabTick/2,0,cabHight/2-doorBase/2])  // prostredna spojovacia prepazka
            cube([cabTick,cabDepth,doorBase]);
        translate([cabWidth/2-cabTick/2,0,cabHight-doorBase-doorBase])  // spodna spojovacia prepazka
            cube([cabTick,cabDepth,doorBase]);

        translate([door1at-4,0,doorBase+doorHight*6/7])   // hodny lavy predny pant
            cabPant();
        translate([door1at-4,0,doorBase+doorHight*1/7])   // dolny lavy predny pant
            cabPant();
        translate([cabWidth-door1at,0,doorBase+doorHight*6/7])  // horny pravy predny pant
            cabPant();
        translate([cabWidth-door1at,0,doorBase+doorHight*1/7])  // dolny pravy predny pant
            cabPant();

        translate([door1at,cabDepth,doorBase+doorHight*6/7])   // hodny lavy zadny pant
            rotate([0,0,180]) cabPant();
        translate([door1at,cabDepth,doorBase+doorHight*1/7])   // dolny lavy zadny pant
            rotate([0,0,180]) cabPant();
        translate([cabWidth-door1at+4,cabDepth,doorBase+doorHight*6/7])  // horny pravy zadny pant
            rotate([0,0,180]) cabPant();
        translate([cabWidth-door1at+4,cabDepth,doorBase+doorHight*1/7])  // dolny pravy zadny pant
            rotate([0,0,180]) cabPant();
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

module modCabinet2() {
    color(colorCabinet)
    cabinetBody2();    //proctredny obal - steny skrinky

    color(colorRoof)   // vrchny vrchnacik/strecha
    translate([0,0,cabHight+roofPull])
    cabinetRoofTop();

    color(colorRoof)   // spodny vrchnacik/podlaha/strieska
    translate([0,0,-cabTick-roofPull])
    cabinetRoof();
    
}

module modCabinet4() {
    color(colorCabinet)
    cabinetBody4();    //proctredny obal - steny skrinky

    color(colorRoof)   // vrchny vrchnacik/strecha
    translate([0,0,cabHight+roofPull])
    cabinetRoofTop();

    color(colorRoof)   // spodny vrchnacik/podlaha/strieska
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
            //leftLock();
            uniLock();
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
            //rightLock();
            uniLock();
    }
}

/* [Previews] */
if(preview=="basic2") {
    translate([0,0,0])
        modCabinet2();


    translate([door1at,0-doorPull,doorBase])
        doorLeft();
    translate([door2at,0-doorPull,doorBase])
        doorRight();
}

if(preview=="basic4") {
    translate([0,0,0])
        modCabinet4();


    translate([door1at,0-doorPull,doorBase])
        doorLeft();
    translate([door2at,0-doorPull,doorBase])
        doorRight();

    translate([door2at+doorWidth,cabDepth+doorPull,doorBase])
        rotate([0,0,180]) doorLeft();
    translate([door1at+doorWidth,cabDepth+doorPull,doorBase])
        rotate([0,0,180]) doorRight();
}

if(preview=="hinges") {
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

}

if(preview=="plate2") {
    translate([0,0,0])
        cabinetRoof();
    translate([0,cabDepth+pad,0])
        cabinetRoof();
    translate([0,cabDepth*2+pad*2,0])
        cabinetBody2();
    translate([cabWidth+pad,0,cabTick])
        rotate([-90,0,0])
        doorLeft();
    translate([cabWidth+pad,doorHight+pad,cabTick])
        rotate([-90,0,0])
        doorRight();
}

if(preview=="plate4") {
    translate([0,0,0])
        cabinetRoof();
    translate([0,cabDepth+pad,0])
        cabinetRoof();
    translate([0,cabDepth*2+pad*2,0])
        cabinetBody4();
    translate([cabWidth+pad,0,cabTick]) //lave dvere
        rotate([-90,0,0])
        doorLeft();
    translate([cabWidth+pad,doorHight+pad,cabTick]) //prave dvere
        rotate([-90,0,0])
        doorRight();

    translate([cabWidth+pad+doorWidth+pad,0,cabTick])
        rotate([-90,0,0])
        doorLeft();
    translate([cabWidth+pad+doorWidth+pad,doorHight+pad,cabTick])
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
