// Basic Box - boxPool and boxCover
// 2026-08-17, Ondrej DURAS (dury) Nokia Public Openware GNU/GPL
/* [Preview] */
// parametricka krabicka urcena na prenasanie veci vo vrecku
// dolezitou vlastnostou su jej zaoblenia po stranach, aby
// netrhala nohavice a nedrala sa o stehno.
// dve casti: 
// spodna cast - vanicka - boxPool
// vrchna cast - deklik  - boxCover
preview="basic"; // [basic,text,plate]
$fn=30;  // pocet fradmentov kruhu (30 pri manipulacii 100 pri renderovani)
spi=0.2; // odsadenie na vnutornej casti
spo=0.2; // odsadenie na vonkajsej casti
spp=5.0; // odsadenie na vyrobnej doske
// vzdialenost vrchnaka od vanicky
distance=0; // [0:1:100] 

/* [Dimensions] */
//w5d3h7t1cm
// AF-4200 w85.8 d54.3 h15(asi) 
// vyrez pre micro:a-USB connector v hornej casti 40mm full, 6mm diera, 40mm vypln
// zaoblenia s uchytne diery v rohoch: 5.0mm a 3.4mm ...ale co presne ???


// parametre krabicky idu v standartnom duchu : width,depth,hight,tick,round
// sirka krabicky - vonkajsi rozmer boxPool spodnej casti
boxWidth=90.0;  // [30:10:150]
// hlbka/dlzka krabicky - vonkajsi rozmer boxPool spodnej casti
boxDepth=58.0;  // [30:10:200] 
// vyska krabicky - vonkajsi rozmer boxPool spodnej casti
boxHight=15.0;   // [10:1:50]
// polomer zaoblenia vsetkych krabicky
boxRound=5.0;    // [0:0.1:20]
// hrubka materialu krabicky ...boxCover si ju musi pripocitat
boxTick=1.4;     // [0.5:0.1:5.0]
// hlbka vyrezu deklika - vzdialenost valca (pomer k vyske krabice)
boxCutOutHC=1.30;  // [0:0.05:1.5]
// hlbka vyrezu deklika - polomer valca  (pomer k sirke krabice)
boxCutOutDC=1.20;   // [0:0.05:1.5]  
// hlbka vyrezu vanicky - vzdialenost valca
boxCutOutHP=1.30;  // [0:0.05:1.5]
// hlbka vyrezu vanicky - polomer valca
boxCutOutDP=1.20;  // [0:0.05:1.5]

boxName="";       //Napis na dekliku aj vanicke
boxFont=10;       //Font Size
// Tabulka rozmerov
// 002 10x15x3-T2-R5  maxi (vacsia na plate 256x256x256 asi ani nevojde  205x150x30)
// 003 55x45x15-T1-R3 micro:bit

/* [Extruders] */
// Force Filament
FF=0; // [0:All,1:Grey,2:Red,3:Green,4:Blue]
FC=["#d0d0d0","#404040","#a04040","#40a040","#4040a0"]; // 0-vsetky filamenty, respektive ziadny...na vyrezavania, potom filamenty 1,2,3,4
F1=true; // [0:Disabled 1:Enabled]
F2=true; // [0:Disabled 1:Enabled]
F3=true; // [0:Disabled 1:Enabled]
F4=true; // [0:Disabled 1:Enabled]

/* [Colors] */
colorBoxPoolOut="#505050"; // vonkajsia farba vanicky
colorBoxPoolInt="#404040"; // vnutorna farba vanicky
colorBoxCoverOut="#505050";
colorBoxCoverInt="#404040";

/* [Text] */
mlFont="arial"; // font pre lablelovanie
mlExtrude=0.4;  // hlbka textu

//topText=[[1,0,8,"ahoj"],[2,8,10,"nazdar"],[3,18,14,"cau"],[2,32,10,"hello"]];
topText=[[1,0,8,"ahoj"],[2,8,8,"nazdar"],[3,16,8,"cau"],[4,24,8,"hello"]];
coverText=[
    [4,0,10,"NOKIA"],
    [2,12,5,"Assembler Learning Kit"],
    [3,19,5,"AF-4200   ATSAMD51"],
    [3,26,5,"Course-1:"],
    [3,33,5,"  Cortex-M0 GPIO I2C"]];
poolText=[
  [4,0,5,"Ondrej DURAS"],
  [1,7,4,"20260817-1"]
];

// 0=extruder
// 1=y-suradnica textu
// 2=vyska fontu
// 3=text
// finta = y-suradnica dalsieho riadku sa rovna suctu y-suradnice a vysky textu riadku pred nim.
// cize: 0+8 => 8 + 10 => 18 + 14 => 32 +10 => 42 ...
// Y-suradnica sa pocita ako v texte, teda [0,0] je vlavo hore, a narastajuci Y posuva text smerom dole

//> tu pokracovat v.2026...
// vynutorny rozmer krabice boxHight(15.0) - boxTick(1.4) - spi = 13.4mm totalna vyska pomocneho stlpika
DPIN=object(
    head_dia=6.0,  // priemer hlavicky kolika
    head_hig=2.0,  // hrubka hlavicky kolika
    neck_dia=3.2,  // vonkajsie priemer kolika
    hight=13.4     // celkova vyska zlozeneho kolika
);

module distPinMale(p=DPIN,plate=false) {
// distancny kolik pre AF-4200, aby sa nesuchal o steny krabicky, ked sa bude nosit vo vrecku
// sklada sa z dvoch casti "s kolikom"-male a "s dierkou"-female
// zaroven ... je zobrazovany v pracovnej polohe (plate=false)
// alebo vo vyrobnej polohe (plate=true)
// teda nema "zakladnu poloh"
// v pracovnej polohe je referencny bod v strede hlavicky na podlozke
// vo vyrobnej polohe je referencny bod vpredu vlavo
}

module distPinFemale(p=DPIN,plate=false) {

}

module mlText(txt=topText,extruder=0,hight=mlExtrude) {
// txt = pole ..viz topText pole poloziek [extruder,yy,fontSize,"text"]
// extruder==0 - vsetky extrudery - vyrezavanie textu, ktory sa nasledne zaplni
// extruder>0  - len dany extruder
// high = linearne extrudovanie ... musi byt separatne skrz kazde extrude, ina farby neplatia :-(
// referencny bod je lavy horny roh obdlznika textu
// referencny bod kazdeho riadku je jeho vrch, nie spodna zakladna ciara ... lebo viac riadkov :-)
    for(i=[0:1:len(txt)-1]) {
        if((extruder==0) || (extruder==txt[i][0])) {
            translate([0,0-txt[i][1]-txt[i][2]]) 
            color(FC[txt[i][0]]) 
            linear_extrude(hight)
            text(txt[i][3],size=txt[i][2],font=mlFont);
        } //if
        
    } //for riadok textu

}
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

module boxPool(bw=boxWidth,bd=boxDepth,bh=boxHight,bt=boxTick,br=boxRound,ci=colorBoxPoolInt,co=colorBoxPoolOut,txt=poolText) {
//module boxPool(bw=boxWidth,bd=boxDepth,bh=boxHight,bt=boxTick,br=boxRound,ci=colorBoxPoolInt,co=colorBoxPoolOut,tt=boxName,tf=boxFont)
    bw2=bw-bt-bt; // vnutorne rozmery vanicky/vyhlbenia
    bd2=bd-bt-bt;
    bh2=bh-bt;

    union() {
    difference() {
    if(F1) {
        color(FC[1])
            boxRoundBottom(bw,bd,bh,br); // vonkajsi obry vanicky
        color(FC[1])
            translate([bt,bt,bt])
            boxRoundBottom(bw2,bd2,bh,br); // vnutorny obrys vanicky
        color(FC[1])
            translate([bw/2,-1,bw/2+bh*boxCutOutHP])
            rotate([-90,0,0])
            cylinder(h=bd+2,d=bw*boxCutOutDP); // cylindricky vyrez pre vysuvanie/otvaranie krabicky
        //color(ci)
        //    translate([bt/4,br,br])
        //    rotate([0,-90,0])
        //    linear_extrude(1)
        //    text(tt,size=tf,font="arial"); // bodny zvysly napis ... len pre vysoke krabicky
       translate([bw-br,bd-br,mlExtrude-0.001]) rotate([0,180,0]) mlText(txt,0,mlExtrude+0.001); // mlText na krabicke - vyrezanie
    } else { cube([0,0,0]); } // F1
    } // diff
      //  translate([bw-br,bd-br,0]) rotate([0,180,0]) mlText(txt,FF,mlExtrude); // mlText na krabicke - farebna vypln
      if(F2) { translate([bw-br,bd-br,mlExtrude]) rotate([0,180,0]) mlText(txt,2,mlExtrude); } else { cube([0,0,0]); } // cerveny filament
      if(F3) { translate([bw-br,bd-br,mlExtrude]) rotate([0,180,0]) mlText(txt,3,mlExtrude); } else { cube([0,0,0]); } // zeleny filament
      if(F4) { translate([bw-br,bd-br,mlExtrude]) rotate([0,180,0]) mlText(txt,4,mlExtrude); } else { cube([0,0,0]); } // modry filament
    } //uni
}


module boxCover(bw=boxWidth,bd=boxDepth,bh=boxHight,bt=boxTick,br=boxRound,ci=colorBoxCoverInt,co=colorBoxCoverOut,txt=coverText) {
    bw1=bw+bt+bt+spo+spo;
    bd1=bd+bt+bt+spo+spo;
    bh1=bh;

    bw2=bw1-bt-bt; // vnutorne rozmery vanicky/vyhlbenia
    bd2=bd1-bt-bt;
    bh2=bh1-bt;

    union() {
    difference() {
    if(F1) {
        color(FC[1])
            boxRoundBottom(bw1,bd1,bh1,br);
        color(FC[1])
            translate([bt,bt,bt])
            boxRoundBottom(bw2,bd2,bh,br);
        color(FC[1])
            translate([bw1/2,-1,bw1/2+bh1*boxCutOutHC])
            rotate([-90,0,0])
            cylinder(h=bd1+2,d=bw1*boxCutOutDC);
       translate([bw-br,bd-br,mlExtrude-0.001]) rotate([0,180,0]) mlText(txt,0,mlExtrude+0.001); // mlText na krabicke
    } else { cube([0,0,0]); } // sivy filament
    } // diff
      // translate([bw-br,bd-br,mlExtrude]) rotate([0,180,0]) mlText(txt,FF,mlExtrude); // mlText na krabicke
      if(F2) { translate([bw-br,bd-br,mlExtrude]) rotate([0,180,0]) mlText(txt,2,mlExtrude); } else { cube([0,0,0]); } // cerveny filament
      if(F3) { translate([bw-br,bd-br,mlExtrude]) rotate([0,180,0]) mlText(txt,3,mlExtrude); } else { cube([0,0,0]); } // zeleny filament
      if(F4) { translate([bw-br,bd-br,mlExtrude]) rotate([0,180,0]) mlText(txt,4,mlExtrude); } else { cube([0,0,0]); } // modry filament
    }
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

    if(preview=="text") {
        translate([0,30])
        mlText(topText,FF,2.0);
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

