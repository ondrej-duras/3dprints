// testovacia stolicka
// ma otestovat vlastnosti tlaciarne
// konkretne:
//   - nepodrzanu plochu - sedaciu plochu
//   - tenku kolmu plochu - dosku operadla
//   - tenke nozky stolicky aj operadla

// do videa sa to prekonvertuje prikazom
// ffmpeg -r 30 -i frame%%05d.png -c:v libx264 -vf scale=320x200 out.mp4
// -r 30  ... 30 FPS
// -c:v libx264 ... codec:video H264
// -vf scale=320x200  ...rozmer VideoFramu v pixeloch 10sec video cca 200kB

// configuracia
setup="basic"; // [basic, film, slicer]
slicer=0;      // [0:45]

module stolicka() {
// rozmery 20x20x37
    color("red") {
      translate([5,5,0])    cylinder(h=20,d=2);
      translate([15,5,0])   cylinder(h=20,d=2);
      translate([15,15,0])  cylinder(h=20,d=2);
      translate([5,15,0])   cylinder(h=20,d=2);
      translate([10,10,20]) cylinder(h=2,d=20);
      translate([5,2.5,22])   cylinder(h=15,d=2);
      translate([15,2.5,22])  cylinder(h=15,d=2);
      translate([2,2,27])   cube([16,2,10]);
    }
}

module podlozka(size) {
    translate([0,0,0]) 
    color("white")
    cube([size,size,2]);
    
    for(i=[0:10:size-1]) color("blue") {
        translate([i,0,2]) cube([0.5,5,0.5]); 
        translate([i+5,0,2]) cube([0.5,2.5,0.5]);
    };
    for(i=[0:10:size-1]) color("blue") {
        translate([size-5,i,2]) cube([5,0.5,0.5]);
        translate([size-2.5,i+5,2]) cube([2.5,0.5,0.5]);
    };
    t_font  = "arial";
    t_text1 = "TEST";
    t_text2 = "TLAČE";
    color("green") {
        translate([25,29,2]) 
        rotate([0,0,180])
        linear_extrude(1)
        text(t_text1,size=7,font=t_font);
 
        translate([2,21,2])
        rotate([0,0,270])
        linear_extrude(1)
        text(t_text2,size=4,font=t_font);
        }
}


// vyrobny podklad
if(setup=="basic") {
    podlozka(30);
    translate([5,5,2]) stolicka();
}
if(setup=="slicer") {
    difference() { 
        union() {
            podlozka(30);
            translate([5,5,2]) stolicka();
    
        }
        translate([0,0,slicer])
            cube([30,30,100-slicer]);
    }
}
if(setup=="film") {
    // animovana visualizacia
    echo("a tu bude nieco zlozitejsie");

    rotate([0,0,$t*360]) translate([-15,-15,0]) {
        podlozka(30);
        translate([5,5,2]) stolicka();
    }
}

