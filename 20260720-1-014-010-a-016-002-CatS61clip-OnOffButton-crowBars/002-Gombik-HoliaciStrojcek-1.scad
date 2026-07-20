// Gombik z Holiaceho Strojceka
// 20260707, Ondrej DURAS (dury) NOKIA

/* [Config] */
preview="basic"; // [basic,plate]
$fn=70;  // [10:10:100]
spi=0.1; // odstup kolika
spo=0.1; // odstup diery
spp=5.0; // odstup medzi suciastkami na vyrobnej doske
nox=2;   // pocet gombikov v smere X
noy=4;   // pocet gombikov v smere Y

// hrana stvorca
butWidth=13.3;
// vyska gombika od podlozky po stred stredoveho kriza. okrajove kolicky su este o polovicu hrubky kolicka (polomer valca) vyssie
butHight=7.3;  
// zaoblenie hran stvorca
butRound=4.5;  
// hrana stredoveho kriza
butCross=3.0;
// hrubka hrany stredoveho kriza
butCrosI=1.0;
// hrubka materialu zakladnej dosky tlacitka
butTickB=2.0;
// hrubka postrannych istiacich kolickov smerom do vnutra stvorca
butTickI=1.0; // 1.5 bolo hrube
// polomer valceka zachytu na istiacich kolickoch, musi byt mesi ako butTickI
butTickX=1.0;
// hrubka postrannych kolickov po hrane tlacitka
butTickH=3.0;  // 4.0 bolo hrube
colorButtonX="#b0b050"; // farba materialu gombika
colorButtonY="#50b0b0"; // farba materialu gombika


module hcButton_OFFv1(bw=butWidth,bh=butHight,br=butRound,bcs=butCross,bci=butCrosI,btb=butTickB,bti=butTickI,btx=butTickX,bth=butTickH) {
    b1=bw-br;
    r1=br+1;
    difference() {
    color(colorButtonX) 
    union() {
        linear_extrude(butTickB) {
        union() {
        difference() {
            square(bw);
            translate([-1,-1]) square(r1); // lavy predny vyrez pre zaoblenie
            translate([b1,-1]) square(r1); // pravy predny
            translate([-1,b1]) square(r1); // lavy zadny
            translate([b1,b1]) square(r1); // pravy zadny
        } // diff
            translate([br,br]) circle(r=br); // lave predne zaoblenie
            translate([b1,br]) circle(r=br); // prave predne
            translate([br,b1]) circle(r=br); // lave zadne
            translate([b1,b1]) circle(r=br); // prave zadne
       
 
        } // union
        } // extr
        translate([0,bw/2-bth/2,0])      cube([bti,bth,bh]);  // lava palicka
        translate([bw-bti,bw/2-bth/2,0]) cube([bti,bth,bh]);  // prava palicka
        translate([0,bw/2-bth/2,bh-btx]) rotate([-90,0,0]) cylinder(h=bth,r=btx);  // zachyt na lavej palicke      
        translate([bw,bw/2-bth/2,bh-btx]) rotate([-90,0,0]) cylinder(h=bth,r=btx); // zachyt na pravej palicke

        translate([bw/2-bcs/2,bw/2-bci/2,0]) cube([bcs,bci,bh]);
        translate([bw/2-bci/2,bw/2-bcs/2,0]) cube([bci,bcs,bh]);
    }  // uniV
        for(i=[1:1:3]) {
          color(colorButtonY)  translate([bw/4*i-btb/2,bw/6,-0.001]) cube([btb,bw/3*2,btb/2+0.001]);
        }
    } // diffV
}     

module hcButton(bw=butWidth,bh=butHight,br=butRound,bcs=butCross,bci=butCrosI,btb=butTickB,bti=butTickI,btx=butTickX,bth=butTickH) {

// POCITANIE : "PRUZNY VYREZ"
// ak B je polovica sirky vyrezu a D je hlbka prepadu vyrezu, potom 
// C je polomer valca, ktory treba od kvadra odrezat, aby na nom vznikol pruzny vyrez
// C=(B*B-D*D)/2D+D ... vypocet polomeru valca
// A - vzdialenost stredu valca od (zatial) rovnej hrany kvadra do ktorej sa vyrezava "pruzny vyrez"
// A = C-D (polomer valca - hlbka vyhlbenia)
// alebo pocitajme najprv vzdialenost valca od kvadra A=(BB-DD)/2D
// a potom jeho polomer ako C=A+D

// v kontexte gombika pre holiaci strojcek:
// D=butTickI/2 ... bti/2 ,teda polovica hrubky palicky/istiaceho kolicka ...teda cca 0.75mm
// B=2*butHight/6 ... bh/3
// A=(bh/3*bh/3-bti/2*bti/2)/2*bti/2 = (bh*bh/6-bti*bti/4)/bti = (bh*bh/6/bti)-(bti/4)
// C = A + D = A + bti/2

    b1=bw-br; // konstanty pre vypocitanie zaoblenia
    r1=br+1;
    //aa=bh*bh/bti/6-bti/4; // vzdialenost valca pre pruzny vyrez
    sf=bti/2;             // hlbka pruzneho vyrezu, ale zaroven posun(shift) od okraja gombika
    aa=bh*bh/sf/3-sf/2;   // vzdialenost valca pruzneho vyrezu po zjednoduseni vypoctu
    cc=aa+bti/2;          // polomer valca pruzneho vyrezu

    difference() {
    color(colorButtonX) 
    union() {
        linear_extrude(butTickB) {
        union() {
        difference() {
            square(bw);
            translate([-1,-1]) square(r1); // lavy predny vyrez pre zaoblenie
            translate([b1,-1]) square(r1); // pravy predny
            translate([-1,b1]) square(r1); // lavy zadny
            translate([b1,b1]) square(r1); // pravy zadny
        } // diff
            translate([br,br]) circle(r=br); // lave predne zaoblenie
            translate([b1,br]) circle(r=br); // prave predne
            translate([br,b1]) circle(r=br); // lave zadne
            translate([b1,b1]) circle(r=br); // prave zadne
       
 
        } // union
        } // extr
        translate([sf,bw/2-bth/2,0])      cube([bti,bth,bh]);  // lava palicka
        translate([bw-bti-sf,bw/2-bth/2,0]) cube([bti,bth,bh]);  // prava palicka
        rxx=btx*2/3; // polomer zachytneho valca na konci kolicka
        translate([sf,bw/2-bth/2,bh]) rotate([-90,0,0]) cylinder(h=bth,r=btx);  // zachyt na lavej palicke      
        translate([bw-sf,bw/2-bth/2,bh]) rotate([-90,0,0]) cylinder(h=bth,r=btx); // zachyt na pravej palicke

        translate([sf+bti,bw/2,btb]) rotate([0,45,0]) cube([btb/2,bth,btb/2], center=true);  //opora lavej palicky
        translate([bw-bti-sf,bw/2,btb])  rotate([0,45,0]) cube([btb/2,bth,btb/2], center=true);  //opora pravej palicky

        translate([bw/2-bcs/2,bw/2-bci/2,0]) cube([bcs,bci,bh]); //stredovy kriz - hrana zlava do prava
        translate([bw/2-bci/2,bw/2-bcs/2,0]) cube([bci,bcs,bh]); // stredovy kriz - hrana zpredu do zadu
    }  // uniV
        for(i=[1:1:3]) {  // tri vyhlbenia pre vytiahnutie tlacitka v pripade, ze ho bude treba vymenit
          color(colorButtonY)  translate([bw/4*i-btb/2,bw/6,-0.001]) cube([btb,bw/3*2,btb/2+0.001]);
        }
    } // diffV
}     

module baseButton(bw=butWidth,bh=butHight,br=butRound,bcs=butCross,bci=butCrosI,btb=butTickB,bti=butTickI,btx=butTickX,bth=butTickH) {
// horizontalna cast gombika, do ktorej sa potom "zapichne ta vertikalna
// zakladna aj vyrobna poloha gombika su identicke ... skutocna pracovna poloha je otocena o Y-180'. 

    b1=bw-br; // konstanty pre vypocitanie zaoblenia
    r1=br+1;
    //aa=bh*bh/bti/6-bti/4; // vzdialenost valca pre pruzny vyrez
    sf=bti/2;             // hlbka pruzneho vyrezu, ale zaroven posun(shift) od okraja gombika
    aa=bh*bh/sf/3-sf/2;   // vzdialenost valca pruzneho vyrezu po zjednoduseni vypoctu
    cc=aa+bti/2;          // polomer valca pruzneho vyrezu

    difference() {
        color(colorButtonX)
        linear_extrude(butTickB) {
        union() {
        difference() {
            square(bw);
            translate([-1,-1]) square(r1); // lavy predny vyrez pre zaoblenie
            translate([b1,-1]) square(r1); // pravy predny
            translate([-1,b1]) square(r1); // lavy zadny
            translate([b1,b1]) square(r1); // pravy zadny
        } // diff
            translate([br,br]) circle(r=br); // lave predne zaoblenie
            translate([b1,br]) circle(r=br); // prave predne
            translate([br,b1]) circle(r=br); // lave zadne
            translate([b1,b1]) circle(r=br); // prave zadne
       
 
        } // union
        } // extr
    translate([sf-spo,bw/2-bth/2-spo,btb/2]) cube([bw-2*sf+2*spo,bth+2*spo,btb/2+1]); // siroby vyrez na vrchu (prac. na spodku) pre stickButton
    translate([sf,bw/3-bti/2,-1]) cube([bw-2*sf,bti,bti+1]);   // predny vyrez pre vytiahnutie kliestami
    translate([sf,bw*2/3-bti/2,-1]) cube([bw-2*sf,bti,bti+1]); // zadny  vyrez pre vytiahnutie kliestami
    
    } //diff 
}     

/* [POCITANIE PRUZNEHO VYREZU] */
// ak B je polovica sirky vyrezu a D je hlbka prepadu vyrezu, potom 
// C je polomer valca, ktory treba od kvadra odrezat, aby na nom vznikol pruzny vyrez
// C=(B*B-D*D)/2D+D ... vypocet polomeru valca
// A - vzdialenost stredu valca od (zatial) rovnej hrany kvadra do ktorej sa vyrezava "pruzny vyrez"
// A = C-D (polomer valca - hlbka vyhlbenia)
// alebo pocitajme najprv vzdialenost valca od kvadra A=(BB-DD)/2D
// a potom jeho polomer ako C=A+D

// v kontexte gombika pre holiaci strojcek:
// D=butTickI/2 ... bti/2 ,teda polovica hrubky palicky/istiaceho kolicka ...teda cca 0.75mm
// B=2*butHight/6 ... bh/3
// A=(bh/3*bh/3-bti/2*bti/2)/2*bti/2 = (bh*bh/6-bti*bti/4)/bti = (bh*bh/6/bti)-(bti/4)
// C = A + D = A + bti/2
module stickButton(bw=butWidth,bh=butHight,br=butRound,bcs=butCross,bci=butCrosI,btb=butTickB,bti=butTickI,btx=butTickX,bth=butTickH) {
// vertikalna cast gombika do holiaceho strojceka
// mala by byt priblizne v tvare greckeho pismena PI, pricom
// v zakladnej polohe je vrchnou strieskou opreta o osu X
// referencny bod je v leziacej zakladnej / vyrobnej polohe vpredu vlavo dole
// v pracovnej polohe - vertikalnej sa vklada do spodnej casti horizontalnej casti gombika
    b1=bw-br; // konstanty pre vypocitanie zaoblenia
    r1=br+1;
    //aa=bh*bh/bti/6-bti/4; // vzdialenost valca pre pruzny vyrez
    sf=bti/2;             // hlbka pruzneho vyrezu, ale zaroven posun(shift) od okraja gombika
    //aa=bh*bh/sf/3-sf/2;   // vzdialenost valca pruzneho vyrezu po zjednoduseni vypoctu
    //cc=aa+bti/2;          // polomer valca pruzneho vyrezu

    bb=bh*2/3;  // polovica sirky vyrezu
    dd=bti*2/5; // hlbka vyrezu
    cc=(bb*bb-dd*dd)/2*dd+dd;
    aa=cc-dd;

    color(colorButtonY)
    linear_extrude(bth-2*spi,convexity=5) { union() {
        translate([sf+spi,0]) square([bw-2*(sf+spi),btb/2]); // zakladna "strieska" pismena PI
        difference() {
        translate([sf+spi,0]) square([bti,bh]); // lava palicka pismena PI
            translate([sf+spi+bti+aa,bh/2]) circle(r=cc); // pruzny vyrez
        }
        difference() {
        translate([bw-sf-bti-spi,0]) square([bti,bh]); // prava palicka
            translate([bw-sf-bti-spi-aa,bh/2]) circle(r=cc); // pruzny vyrez
        }
        translate([bw/2-bti/2,0]) square([bti,bh]); // stredna palicka
        translate([sf+spi,bh]) circle(r=bti);
        translate([bw-sf-spi,bh]) circle(r=bti);
    }}
}     

module deployButton(bw=butWidth,bh=butHight,br=butRound,bcs=butCross,bci=butCrosI,btb=butTickB,bti=butTickI,btx=butTickX,bth=butTickH) {
    baseButton();
    translate([0,bw/2+bth/2,btb/2]) rotate([90,0,0]) stickButton();
}

module onPlateButton(bw=butWidth,bh=butHight,br=butRound,bcs=butCross,bci=butCrosI,btb=butTickB,bti=butTickI,btx=butTickX,bth=butTickH) {
    baseButton();
    translate([bw+spp,0,0]) stickButton();
}

module preview(preview=preview) {
    if(preview=="basic_2") { hcButton(); }
    if(preview=="plate_2") {
        for(y=[0:1:noy-1]) for(x=[0:1:nox-1]) { 
            translate([x*(butWidth+spp),y*(butWidth+spp),0]) hcButton(); 
        }
    }
    if(preview=="basic") { deployButton(); translate([0,butWidth+spp,0]) hcButton(); }
    if(preview=="plate") { 
        for(y=[0:1:noy-1]) for(x=[0:1:nox-1]) { 
            translate([x*2*(butWidth+spp),y*(butWidth+spp),0]) 
            //hcButton(); 
            onPlateButton(); }
        }
}

/* [Preview] */
preview();

// --- end ---
      
