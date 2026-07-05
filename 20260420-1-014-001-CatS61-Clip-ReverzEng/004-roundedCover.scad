// Rounded Cover a part of CatS61 Clip
/* [Preview] */
preview="basic"; // [basic,plate]
$fn=20;

/* [Colors] */
colorCover="#010150";


module roundedCoverUp(w,d,h,r1,r2) {  // sirka, hlbka/dlzka, vyska/hrubka, polomer velkeho zaoblenia, polomer malych hran
    union() {                         // tato verzia vyzera byt z pohladu vyplnenia priastoru dokonala ...ale zere resourcy
    difference() {
        cube([w,d,h]);
        translate([-1,d-r1,h-r1])
            cube([w+2,r1+1,r1+1]);      // vyrez pre velke zaoblenie (vzadu hore)
        translate([-1,-1,h-r2])
            cube([r2+1,d+2,r2+1]);  // lavy horny vyrez pre okrajove zaoblenie
        translate([w-r2,-1,h-r2])
            cube([r2+1,d+2,r2+1]);  // pravy horny vyrez pre okrajove zaoblenie
        translate([-1,d-r2,-1])
            cube([r2+1,r2+1,h+2]);  // vyrez pre zaoblenie vlavo vzadu
        translate([w-r2,d-r2,-1])
            cube([r2+1,r2+1,h+2]);  // vyrez pre zaoblenie vpravo vzadu
    } // diff
        translate([r2,d-r1,h-r1])
            rotate([0,90,0])
            cylinder(h=w-2*r2,r=r1); // velke zaoblenie vzadu hore
        translate([r2,0,h-r2])
            rotate([-90,0,0])       // lave horne zaoblenie
            cylinder(h=d-r1,r=r2);
        translate([w-r2,0,h-r2])
            rotate([-90,0,0])       // prave horne zaoblenie
            cylinder(h=d-r1,r=r2);
        translate([r2,d-r2,0])
            cylinder(h=h-r1,r=r2);  // lave zadne zaoblenie
        translate([w-r2,d-r2,0])
            cylinder(h=h-r1,r=r2);  // prave zadne zaoblenie


        translate([r2,d-r1,h-r1])   // velke zaoblenie v lavom hornom rohu
            rotate([0,-90,0])
            //rotate_extrude(angle=90,start=0,convexity=100)
            rotate_extrude(angle=90,convexity=20)
                translate([r1-r2,0,0])
                circle(r=r2);

        translate([w-r2,d-r1,h-r1])   // velke zaoblenie v lavom hornom rohu
            rotate([0,-90,0])
            //rotate_extrude(angle=90,start=0,convexity=100)
            rotate_extrude(angle=90,convexity=20)
                translate([r1-r2,0,0])
                circle(r=r2);

        translate([0,d-r1,h-r1])  // vyplnenie dier na velkom zaobleni z oboch stran pomocou valca
            rotate([0,90,0])
            cylinder(h=w,r=r1-r2);
    } // union
}


module roundedCoverDown(w,d,h,r1,r2) {  // zaoblena krytka otocena dnom dole v zakladnej polohe
                                        //sirka,hlbka/dlzka,vyska/hrubka,polomer velkeho zaoblenia vzadu,polomer malych zaobleni po stranach
                                        // z pohladu komponent zjednodusena ...ovsem nedokonala verzia
    union() {
    difference() {
        cube([w,d,h]);             // zakladny kvader
        translate([r2-0.1,d-r1,-1])
            cube([w-2*r2+0.2,r1+1,r1+1]);  //vyrez pre velke zaoblenie

        translate([-1,-1,-1])
            cube([r2+1,d+2,r2+1]);  // lavy dolny vyrez
        translate([w-r2,-1,-1])
            cube([r2+1,d+2,r2+1]); //pravy dolny vyrez
        translate([-1,d-r2,-1])
            cube([r2+1,r2+1,h+2]);  // lavy zadny vyrez 
        translate([w-r2,d-r2,-1])
            cube([r2+1,r2+1,h+2]);  // lavy zadny vyrez 
        
    } //diff
        translate([r2,0,r2])
            rotate([-90,0,0])
            cylinder(h=d-r1,r=r2);  // lave dolne zaoblenie
        translate([w-r2,0,r2])
            rotate([-90,0,0])
            cylinder(h=d-r1,r=r2);  // prave dolne zaoblenie
        translate([r2,d-r2,r1])
            cylinder(h=h-r1,r=r2);  // lave zadne zaoblenie
        translate([w-r2,d-r2,r1])
            cylinder(h=h-r1,r=r2);  // prave zadne zaoblenie
        translate([r2,d-r1,r1])
            rotate([0,90,0])
            cylinder(h=w-2*r2,r=r1);  // zadne dolne velke zaoblenie


        translate([r2,d-r1,r1])   // velke zaoblenie v lavom hornom rohu
            rotate([0,90,0])
            //rotate_extrude(angle=90,start=0,convexity=100)
            rotate_extrude(angle=90,convexity=20)
                translate([r1-r2,0,0])
                circle(r=r2);

        translate([w-r2,d-r1,r1])   // velke zaoblenie v lavom hornom rohu
            rotate([0,90,0])
            //rotate_extrude(angle=90,start=0,convexity=100)
            rotate_extrude(angle=90,convexity=20)
                translate([r1-r2,0,0])
                circle(r=r2);

    } //union
}
if(preview=="basic") {

    difference() {
        translate([0,0,0])
            roundedCoverDown(15,30,5,2,1);
        translate([1,-1,1])
            roundedCoverDown(13,30,5,2,1);
    }
}
