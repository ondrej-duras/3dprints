// Prichytka Stresnej Listy pre Skodu Feliciu 1994 - REMAKE
// 20260817, Ondrej DURAS NOKIA Public OpenSource
// Roof Rubber Strip Clip - Roof Clip 
// req. version 2026.04.26

/* [Preview] */
$fn=100;
spp=5;           // rozostup medzi objektami na vyrobnej doske
preview="basic"; // [basic,plateRC1,plateRCA]
slice=0.4;       //hrubka jednej vrstvy, gravir textu

/* [Template] */
   roofClip_Template=object(  //TEMPLATE - predloha 
    width=30.00,     // sirka / dlzka prichytky - dlhy rozmer
    depth=7.00,      // kratka sirka prichytky
    hight=3.00,      // vyska/hrubka prichytka
    diameter=5.00,   // priemer hlavicky o ktoru sa prichytka prichytava
    neck_dia=2.00,   // priemer stopky, ktora drzi hlavicku
    neck_hig=1.00,   // vyska stopky, ktora drzi hlavicku
    space=0.5,       // hrubka oddelovacieho rezu
    mid_space=1.1,   // hrubka prostredneho rezu
    cut_len=20.0,    // celkova dlzka dvoch vyrezov pre pruznu cast (prava+lava strana dohromady v milimetroch)
    spinWidth=5,     // sirka pruzneho vyrezu (valcovyte vyhlbenie kvoli pruznosti
    spinHight=1.5,   // hlbka pruzneho vyzeru (1/2 celkovej hrubky suciastky)
    spinShift=5,     // posunutie pruzneho vyrezu od okraja prichytky
    txt1="AB",       //lavy text
    txt2="RC",       //pravy text
    txtSize=3.0,
    color="#f0f090",
   );

rc1=object(roofClip_Template,txt1="XX");

/* [Plate] */

// jednotlive experimentalne typy prichytiek s rozlisovacim oznacenim vyrobneho typu v txt1
// prva cislica oznacuje sirku krku od 0=2mm po 4=4mm
// druhe pismeno oznacuje vysku krku (zmysel dava odstupnovanie po 0.2mm
rc00=object(roofClip_Template, txt1="10", txt2="20");
rc10=object(roofClip_Template, color="#f09090", neck_dia=2.5, txt1="10",txt2="25");
rc20=object(roofClip_Template, color="#90f090", neck_dia=3.0, txt1="10",txt2="30");
rc30=object(roofClip_Template, color="#9090f0", neck_dia=3.5, txt1="10",txt2="35");
rc40=object(roofClip_Template, color="#f090f0", neck_dia=4.0, txt1="10",txt2="40");

rc0A=object(roofClip_Template, neck_hig=0.8, txt1="08", txt2="20");
rc1A=object(roofClip_Template, neck_hig=0.8, color="#f09090", neck_dia=2.5, txt1="08",txt2="25");
rc2A=object(roofClip_Template, neck_hig=0.8, color="#90f090", neck_dia=3.0, txt1="08",txt2="30");
rc3A=object(roofClip_Template, neck_hig=0.8, color="#9090f0", neck_dia=3.5, txt1="08",txt2="35");
rc4A=object(roofClip_Template, neck_hig=0.8, color="#f090f0", neck_dia=4.0, txt1="08",txt2="40");

rc0B=object(roofClip_Template, neck_hig=0.6, txt1="06", txt2="20");
rc1B=object(roofClip_Template, neck_hig=0.6, color="#f09090", neck_dia=2.5, txt1="06",txt2="25");
rc2B=object(roofClip_Template, neck_hig=0.6, color="#90f090", neck_dia=3.0, txt1="06",txt2="30");
rc3B=object(roofClip_Template, neck_hig=0.6, color="#9090f0", neck_dia=3.5, txt1="06",txt2="35");
rc4B=object(roofClip_Template, neck_hig=0.6, color="#f090f0", neck_dia=4.0, txt1="06",txt2="40");

rc0C=object(roofClip_Template, neck_hig=0.4, txt1="04", txt2="20");
rc1C=object(roofClip_Template, neck_hig=0.4, color="#f09090", neck_dia=2.5, txt1="04",txt2="25");
rc2C=object(roofClip_Template, neck_hig=0.4, color="#90f090", neck_dia=3.0, txt1="04",txt2="30");
rc3C=object(roofClip_Template, neck_hig=0.4, color="#9090f0", neck_dia=3.5, txt1="04",txt2="35");
rc4C=object(roofClip_Template, neck_hig=0.4, color="#f090f0", neck_dia=4.0, txt1="04",txt2="40");


rc0X=object(roofClip_Template, neck_hig=1.2, txt1="12", txt2="20");
rc1X=object(roofClip_Template, neck_hig=1.2, color="#f09090", neck_dia=2.5, txt1="12",txt2="25");
rc2X=object(roofClip_Template, neck_hig=1.2, color="#90f090", neck_dia=3.0, txt1="12",txt2="30");
rc3X=object(roofClip_Template, neck_hig=1.2, color="#9090f0", neck_dia=3.5, txt1="12",txt2="35");
rc4X=object(roofClip_Template, neck_hig=1.2, color="#f090f0", neck_dia=4.0, txt1="12",txt2="40");

rc0Y=object(roofClip_Template, neck_hig=1.4, txt1="14", txt2="20");
rc1Y=object(roofClip_Template, neck_hig=1.4, color="#f09090", neck_dia=2.5, txt1="14",txt2="25");
rc2Y=object(roofClip_Template, neck_hig=1.4, color="#90f090", neck_dia=3.0, txt1="14",txt2="30");
rc3Y=object(roofClip_Template, neck_hig=1.4, color="#9090f0", neck_dia=3.5, txt1="14",txt2="35");
rc4Y=object(roofClip_Template, neck_hig=1.4, color="#f090f0", neck_dia=4.0, txt1="14",txt2="40");

rc0Z=object(roofClip_Template, neck_hig=1.6, txt1="16", txt2="20");
rc1Z=object(roofClip_Template, neck_hig=1.6, color="#f09090", neck_dia=2.5, txt1="16",txt2="25");
rc2Z=object(roofClip_Template, neck_hig=1.6, color="#90f090", neck_dia=3.0, txt1="16",txt2="30");
rc3Z=object(roofClip_Template, neck_hig=1.6, color="#9090f0", neck_dia=3.5, txt1="16",txt2="35");
rc4Z=object(roofClip_Template, neck_hig=1.6, color="#f090f0", neck_dia=4.0, txt1="16",txt2="40");


// zoznam prichytiek na vyrobny plate .. pre plateRCArray - experimentalny plate s roznymi verziami
rcl=[
[rc00,rc10,rc20,rc30,rc40],
[rc0A,rc1A,rc2A,rc3A,rc4A],
[rc0B,rc1B,rc2B,rc3B,rc4B],
[rc0C,rc1C,rc2C,rc3C,rc4C],
[rc0X,rc1X,rc2X,rc3X,rc4X],
[rc0Y,rc1Y,rc2Y,rc3Y,rc4Y],
[rc0Z,rc1Z,rc2Z,rc3Z,rc4Z],
];

// pocet prichytiek na sirku .. pre plateRoofClip - bude finalny plate s verziou, ktora bude najlepsia
nx=4;   // [1:1:7]
ny=10;  // [1:1:15]


/* [Lentilka] */

    // H = hight je vyska sosovky (os-Z v zakladnej polohe)
    // D = depth je hrubka sosovky (os-Y v zakladej polohe)
    // Q = vzdialenost stredu referensnej gule od povrchu sosovky v jej najhrubsom strede (os-Y v zakladnej polohe)
    // R = radius je polomer referencnej gule
    // sosovku vyrobime ako prenik dvoch rovnakych referencnych guli - funcia intersection()
    // H a D su ako parameter, zatialco X a R potrebujeme vypocitat
    // R = (D*D + H*H) / (4*D)
    // Q = R-D .... ci ???
    // manualik  OpenSCAD-u:
    // $fa = minimalny uhol pre jeden segment, default=12, to znamena, ze ktruh je potom z 360/12=30-ich segmentov
    // $fs = minimalna dlzka ciaroveho segmentu kruhu, default=2mm najmenej 0.01mm 
    //       (pre nas 3D print 0.4mm alebo 0.2mm. Ine hodnoty tu nedavaju zmysel) .. potom to zaokruhluje
    // $fn = pocet ciarovych segmentov kruhu, default=0 znamena ze sa beru v uvahu $fa a $fs,
    //       striktne sa neodporuca viacej ako 128 - lebo to zerie privela pamate
    //       zaroven pre riesenie vykonnostnych problemov je dobre pouzivat menej ako 50
    // R=(D*D + H*H) / (4*D); // vypocet polomeru referencnej gule
    // Q=R-D;                 // ona vzdialenost stredu gule od povrchu sosovky ... nepoucijeme to zatial
    // Y=R-(D/2);             // Y=suradnica stredu zadnej referencnej gule ; -Y=suradnica stredu prednej referencnej gule

function lentilka(H,D)=(D*D + H*H) / (4*D); // H-sirka vyrezu, D-hlbka valcoviteho vyrezu, vrati polomer valca


module roofClip(p=rc1) {
// prichytka stresnej listy
// referencny bod je uprostred suciastky na vyrobnej podlozke
    color(p.color)
    difference() {
    translate([-p.width/2,-p.depth/2,0])
    cube([p.width,p.depth,p.hight]);   // obdlznik prichytky z ktoreho sa ide vyrezavat

    xtick=(p.depth-p.diameter)/2; // vypocet hrubky lemovania
    translate([-p.cut_len/2,xtick-p.depth/2,-0.001])
        cube([p.cut_len,p.space,p.hight+0.002]); // predny vyrez

    translate([-p.cut_len/2,p.depth/2-xtick-p.space,-0.001])
        cube([p.cut_len,p.space,p.hight+0.002]); // zadny vyrez

    translate([-p.mid_space/2,xtick-p.depth/2,-0.001])
        cube([p.mid_space,p.depth-2*xtick,p.hight+0.002]); // stredny vyrez

    translate([0,0,p.neck_hig]) cylinder(h=p.hight,d=p.diameter); // valcovy vyrez pre hlavicku, ktora drzi prichytku na karoserii
    translate([0,0,-0.001]) cylinder(h=p.neck_hig+0.002,d1=p.diameter,d2=p.neck_dia); // vyrez pre krk, ktory drzi hlavicku

    R=lentilka(p.spinWidth,p.spinHight);    // polomer valca pre vyrezanie pruzneho vyrezu
    X1=-1*(p.width/2-p.spinShift-p.spinWidth/2); // X-suradnica laveho pruzneho vyrezu
    X2=p.width/2-p.spinShift-p.spinWidth/2;      // X-suradnica praveho pruzneho vyrezu
    Y=-1*(p.depth/2-xtick);                      // Y-suradnica oboch pruznych vyrezov
    Z=R+p.hight-p.spinHight;                     // Z-suradnica oboch pruznych vyrezov
    T=p.txtSize/10;                              // posunutie textov po oboch stranach od okraja suciastky

    echo("X1=",X1,"X2=",X2,"Y=",Y,"Z=",Z);
    translate([X1,Y,Z]) rotate([-90,0,0]) cylinder(h=p.depth-2*xtick,r=R); //lavy pruzny vyrez
    translate([X2,Y,Z]) rotate([-90,0,0]) cylinder(h=p.depth-2*xtick,r=R); //pravy pruzny vyrez
    translate([-p.width/2+T,p.depth/2-T,p.hight-slice]) // lavy napis
        rotate([0,0,-90]) linear_extrude(slice+1) 
        text(p.txt1,size=p.txtSize,font="arial");
    translate([p.width/2-T,-p.depth/2+T,p.hight-slice]) //pravy napis
        rotate([0,0,90])  linear_extrude(slice+1) 
        text(p.txt2,size=p.txtSize,font="arial");
    } //diff
}

module plateRoofClip(p=rc1,nx=5,ny=10) {
    for(yy=[0:p.depth+spp:(p.depth+spp)*ny-0.001]) { 
        for(xx=[0:p.width+spp:(p.width+spp)*nx-0.001]) { 
            translate([xx+p.width/2,yy+p.depth/2,0]) roofClip(p);
        }}
}

module plateRCArray(rcl=rcl,stepx=rc1.width+spp,stepy=rc1.depth+spp) {
    for(yi=[0:1:len(rcl)-1])
        for(xi=[0:1:len(rcl[yi])-1]) {
            p=rcl[yi][xi];
            xx=xi*stepx;
            yy=yi*stepy;
            translate([xx,yy,0]) roofClip(rcl[yi][xi]);
            
        }
}

module preview(preview=preview) {
    if(preview=="basic") {
        roofClip(rc1);
    }
    if(preview=="plateRC1") {
        plateRoofClip(p=rc1,nx=nx,ny=ny);
    }
    if(preview=="plateRCA") {
        plateRCArray();
    }


}
preview();

