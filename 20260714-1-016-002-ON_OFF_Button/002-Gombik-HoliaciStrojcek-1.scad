// Gombik z Holiaceho Strojceka
// 20260707, Ondrej DURAS (dury) NOKIA

/* [Config] */
preview="basic"; // [basic,plate]
$fn=70;  // [10:10:100]
spi=0.1; // odstup kolika
spo=0.1; // odstup diery
spp=5.0; // odstup medzi suciastkami na vyrobnej doske
nox=4;   // pocet gombikov v smere X
noy=5;   // pocet gombikov v smere Y

// hrana stvorca
butWidth=13.3;
// vyska kolickov
butHight=7.3;  
// zaoblenie hran stvorca
butRound=4.5;  
// hrana stredoveho kriza
butCross=3.0;
// hrubka hrany stredoveho kriza
butCrosI=1.0;
// hrubka materialu tlacitka
butTickB=2.0;
// hrubka postrannych istiacich kolickov smerom do vnutra stvorca
butTickI=1.5;
// polomer valceka zachytu na istiacich kolickoch, musi byt mesi ako butTickI
butTickX=1.0;
// hrubka postrannych kolickov po hrane tlacitka
butTickH=4.0;
colorButtonX="#b0b050"; // farba materialu gombika
colorButtonY="#50b0b0"; // farba materialu gombika


module hcButton(bw=butWidth,bh=butHight,br=butRound,bcs=butCross,bci=butCrosI,btb=butTickB,bti=butTickI,btx=butTickX,bth=butTickH) {
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

module preview(preview=preview) {
    if(preview=="basic") { hcButton(); }
    if(preview=="plate") {
        for(y=[0:1:noy-1]) for(x=[0:1:nox-1]) { 
            translate([x*(butWidth+spp),y*(butWidth+spp),0]) hcButton(); 
        }
    }
}

/* [Preview] */
preview();

// --- end ---
      
