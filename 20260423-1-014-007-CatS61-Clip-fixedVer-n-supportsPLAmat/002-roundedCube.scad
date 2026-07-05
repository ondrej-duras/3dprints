// roundedCube
// 20260416, Ondrej DURAS (dury) NOKIA
/* [Configuration] */
preview="basic"; // [basic,plate]
$fn=100;

/* [Dimensions] */
// polomer zaoblenia
cubeRadius=2.0;      // [0.5:0.5:10]
// sirka slidu
cubeWidth=20;        // [10:1:50]
// hlbka/dlzka slidu
cubeDepth=30;        // [10:1:100]
// vyska/hrubka slidu 
cubeHight=10;        // [0.5:1:20]

/* [Colors] */
colorSlide="#507040";

module roundedCubeHight(w=cubeWidth,d=cubeDepth,h=cubeHight,r=cubeRadius) {
    union() {
        difference() {
            cube([w,d,h],center=false);  //zakladny kvader, ktory sa ide orezavat
            translate([-1,-1,-1])
                cube([r+1,r+1,h+2]);    // vyrez vlavo vpredu
            translate([w-r,-1,-1])            
                cube([r+1,r+1,h+2]);    // vyrez vpravo vpredu
            translate([-1,d-r,-1])
                cube([r+1,r+1,h+2]);   // vyrez vlavo vzadu
            translate([w-r,d-r,-1])
                cube([r+1,r+1,h+2]);   // vyrez vpravo vzadu
        }
            translate([r,r,0])
                cylinder(h=h,r=r);    // cylinder zaoblenia vlavo vpredu
            translate([w-r,r,0])            
                cylinder(h=h,r=r);    // cylinder zaoblenia vpravo vpredu
            translate([r,d-r,0])
                cylinder(h=h,r=r);   // cylinder zaoblenia vlavo vzadu
            translate([w-r,d-r,0])
                cylinder(h=h,r=r);   // cylinder zaoblenia vpravo vzadu
    }

}

module roundedCubeDepth(w=cubeWidth,d=cubeDepth,h=cubeHight,r=cubeRadius) {
    union() {
        difference() {
        cube([w,d,h]);
        translate([-1,-1,-1])
            cube([r+1,d+2,r+1]);  // vyrez vlavo dole
        translate([w-r,-1,-1])
            cube([r+1,d+2,r+1]);  // vyrez vpravo dole
        translate([-1,-1,h-r])
            cube([r+1,d+2,r+1]);  // vyrez vlavo hore
        translate([w-r,-1,h-r])
            cube([r+1,d+2,r+1]);  // vyrez vlavo hore
        }
        translate([r,0,r])
            rotate([-90,0,0])
            cylinder(h=d,r=r);  // zaoblujuce vyplnenie  vlavo dole
        translate([w-r,0,r])
            rotate([-90,0,0])
            cylinder(h=d,r=r);  // zaoblujuce vyplnenie  vpravo dole
        translate([r,0,h-r])
            rotate([-90,0,0])
            cylinder(h=d,r=r);  // zaoblujuce vyplnenie  vlavo hore
        translate([w-r,0,h-r])
            rotate([-90,0,0])
            cylinder(h=d,r=r);  // zaoblujuce vyplnenie  vpravo hore
    }
}

module roundedCubeWidth(w=cubeWidth,d=cubeDepth,h=cubeHight,r=cubeRadius) {
    union() {
        difference() {
        cube([w,d,h]);
        translate([-1,-1,-1])
            cube([w+2,r+1,r+1]);  // vyrez vpredu dole
        translate([-1,-1,h-r])
            cube([w+2,r+1,r+1]);  // vyrez vpredu hore
        translate([-1,d-r,-1])
            cube([w+2,r+1,r+1]);  // vyrez vzadu dole
        translate([-1,d-r,h-r])
            cube([w+2,r+1,r+1]);  // vyrez vzadu hore
        }
    }
        translate([0,r,r])  // vyrez vpredu dole
            rotate([0,90,0])
            cylinder(h=w,r=r);
        translate([0,r,h-r])  // vyrez vpredu hore
            rotate([0,90,0])
            cylinder(h=w,r=r);
        translate([0,d-r,r])  // vyrez vzadu dole
            rotate([0,90,0])
            cylinder(h=w,r=r);
        translate([0,d-r,h-r])  // vyrez vzadu hore
            rotate([0,90,0])
            cylinder(h=w,r=r);
}
module roundedCubeWDH(w=cubeWidth,d=cubeDepth,h=cubeHight,r=cubeRadius) {
    union() {
        difference() {
        cube([w,d,h]);
        translate([-1,-1,-1])
            cube([r+1,r+1,h+2]);  // H vyrez vlavo vpredu
        translate([w-r,-1,-1])           
            cube([r+1,r+1,h+2]);  // H vyrez vpravo vpredu
        translate([-1,d-r,-1])
            cube([r+1,r+1,h+2]);  // H vyrez vlavo vzadu
        translate([w-r,d-r,-1])
            cube([r+1,r+1,h+2]);  // H vyrez vpravo vzadu
        
        translate([-1,-1,-1])
            cube([r+1,d+2,r+1]);  // D vyrez vlavo dole
        translate([w-r,-1,-1])
            cube([r+1,d+2,r+1]);  // D vyrez vpravo dole
        translate([-1,-1,h-r])
            cube([r+1,d+2,r+1]);  // D vyrez vlavo hore
        translate([w-r,-1,h-r])
            cube([r+1,d+2,r+1]);  // D vyrez vlavo hore

        translate([-1,-1,-1])
            cube([w+2,r+1,r+1]);  // W vyrez vpredu dole
        translate([-1,-1,h-r])
            cube([w+2,r+1,r+1]);  // W vyrez vpredu hore
        translate([-1,d-r,-1])
            cube([w+2,r+1,r+1]);  // W vyrez vzadu dole
        translate([-1,d-r,h-r])
            cube([w+2,r+1,r+1]);  // W vyrez vzadu hore
        } // difference
    } // union
        translate([r,r,r])
            cylinder(h=h-2*r,r=r);  // H cylinder zaoblenia vlavo vpredu
        translate([w-r,r,r])            
            cylinder(h=h-2*r,r=r);  // H cylinder zaoblenia vpravo vpredu
        translate([r,d-r,r])
            cylinder(h=h-2*r,r=r);  // H cylinder zaoblenia vlavo vzadu
        translate([w-r,d-r,r])
            cylinder(h=h-2*r,r=r);  // H cylinder zaoblenia vpravo vzadu

        translate([r,r,r])
            rotate([-90,0,0])
            cylinder(h=d-2*r,r=r);  // D zaoblujuce vyplnenie  vlavo dole
        translate([w-r,r,r])
            rotate([-90,0,0])
            cylinder(h=d-2*r,r=r);  // D zaoblujuce vyplnenie  vpravo dole
        translate([r,r,h-r])
            rotate([-90,0,0])
            cylinder(h=d-2*r,r=r);  // D zaoblujuce vyplnenie  vlavo hore
        translate([w-r,r,h-r])
            rotate([-90,0,0])
            cylinder(h=d-2*r,r=r);  // D zaoblujuce vyplnenie  vpravo hore

        translate([r,r,r])          // W vyrez vpredu dole
            rotate([0,90,0])
            cylinder(h=w-2*r,r=r);
        translate([r,r,h-r])        // W vyrez vpredu hore
            rotate([0,90,0])
            cylinder(h=w-2*r,r=r);
        translate([r,d-r,r])        // W vyrez vzadu dole
            rotate([0,90,0])
            cylinder(h=w-2*r,r=r);
        translate([r,d-r,h-r])      // W vyrez vzadu hore
            rotate([0,90,0])
            cylinder(h=w-2*r,r=r);

        translate([r,r,r])
            sphere(r=r);            // rohova gula vlavo dole vpredu
        translate([w-r,r,r])
            sphere(r=r);            // rohova gula vpravo dole vpredu
        translate([r,r,h-r])
            sphere(r=r);            // rohova gula vlavo hore vpredu
        translate([w-r,r,h-r])
            sphere(r=r);            // rohova gula vpravo hore vpredu

        translate([r,d-r,r])
            sphere(r=r);            // rohova gula vlavo dole vzadu
        translate([w-r,d-r,r])
            sphere(r=r);            // rohova gula vpravo dole vzadu
        translate([r,d-r,h-r])
            sphere(r=r);            // rohova gula vlavo hore vzadu
        translate([w-r,d-r,h-r])
            sphere(r=r);            // rohova gula vpravo hore vzadu
}
/* [Preview] */
if(preview=="basic") {
    color(colorSlide)   // 6 fragments
    translate([0.0*cubeWidth,0,0])
    cube([cubeWidth,cubeDepth,cubeHight]);

    color(colorSlide) // 406 fragments
    translate([1.5*cubeWidth,0,0])
    roundedCubeHight();

    color(colorSlide)  // 406 fragments
    translate([3.0*cubeWidth,0,0])
    roundedCubeDepth();

    color(colorSlide)  // 406 fragments
    translate([4.5*cubeWidth,0,0])
    roundedCubeWidth();

    color(colorSlide)  // 2806 fragments
    translate([6.0*cubeWidth,0,0])
    roundedCubeWDH();
}
