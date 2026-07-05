
// do videa sa to prekonvertuje prikazom
// ffmpeg -r 30 -i frame%%05d.png -c:v libx264 -vf scale=320x200 out.mp4
// -r 30  ... 30 FPS
// -c:v libx264 ... codec:video H264
// -vf scale=320x200  ...rozmer VideoFramu v pixeloch 10sec video cca 200kB


module template(layer) {
    if (layer == "grey") { color("grey") {
        translate([0,0,0]) cube([8,8,2]);
    } }
    if (layer == "blue") { color("blue") {
        translate([10,0,0]) cube([8,8,2]);
    } }
    if (layer == "green") { color("green") {
        translate([20,0,0]) cube([8,8,2]);
    } }
    if (layer == "red") { color("red") {
        translate([30,0,0]) cube([8,8,2]);
    } }
}

// prax, ako template potom niekam aplikovat
//translate([0,0,0]) {
//    template("grey");
//    template("blue");
//    template("green");
//    template("red");
//}




module chassis(layer) {
    union() {
    if (layer == "grey") { color("grey") {
        translate([0,0,0])   cube([44,64,2]); //spodna
        translate([0,0,2])   cube([2,64,28]); //lava
        translate([42,0,2])  cube([2,64,28]); //prava
        translate([2,62,2])  cube([40,2,28]); //zadna
        translate([0,0,30])  cube([44,64,2]); //vrchna
        translate([2,0,4])   cube([2,62,2]);  //lavo-dole
        translate([40,0,4])  cube([2,62,2]);  //vpravo-dole
        translate([2,60,4])  cube([40,2,2]);

        translate([2,0,10])  cube([2,62,2]);  //lavo-stred-dole
        translate([40,0,10]) cube([2,62,2]);  //pravo-stred-dole
        translate([2,60,10]) cube([40,2,2]);
        translate([2,0,14])  cube([2,62,2]);  //lavo-stred-hore
        translate([40,0,14]) cube([2,62,2]);  //pravo-stred-hore
        translate([2,60,14]) cube([40,2,2]);

        translate([2,0,20])  cube([2,62,2]);  //lavo-hore-dole
        translate([40,0,20]) cube([2,62,2]);  //vpravo-hore-dole
        translate([2,60,20]) cube([40,2,2]);
        
        translate([2,0,24])  cube([2,62,2]);  //lavo-hore-hore
        translate([40,0,24]) cube([2,62,2]);  //vpravo-hore-hore
        translate([2,60,24]) cube([40,2,2]);

    } } 
    }
}

module lineCard(layer,tick=1.7,name1="1.7",name2="IOM") {
    union() {
    if (layer == "grey") { color("grey") {
        translate([0,0,0]) cube([40,61.5,tick]); //spodna doska
        translate([-2,-2,0]) cube([44,2,8]);    //predna lista
        translate([-2,-4,0]) cube([6,2,2]);     //lavy uchyt
        translate([-2,-6,0]) cube([8,2,2]);
        translate([36,-4,0]) cube([6,2,2]);     //pravy uchyt
        translate([34,-6,0]) cube([8,2,2]);
        translate([10,-4,1]) cube([5,10,3]);    //lave QSFP
        translate([25,-4,1]) cube([5,10,3]);    //lave QSFP
    } }
    if (layer == "red") { color("red") {
        t_font = "courier";
        t_size = 7;
        translate([5,50,tick])
        linear_extrude(2)
        text(name1,size=t_size,font=t_font);
        translate([17,40,tick])
        linear_extrude(2)
        text(name2,size=t_size,font=t_font);
        
    } }
    };
}

module fanModule(layer) {
    union() {
    if (layer == "grey") { color("grey") {
        difference() {
          union() {
            translate([0,0,0]) cube([20,20,2]);     //dolna doska
            translate([0,0,18]) cube([20,20,2]);    //horna doska
            translate([0,0,0]) cube([2,20,20]);     //lava bocnica 
            translate([18,0,0]) cube([2,20,20]);    //prava bocnica
            translate([9,10,0]) cube([2,10,20]);    //vertikalna drziak statora
            translate([0,10,9]) cube([20,10,2]);    //horizontalny drziak statora
          }
          translate([5,15,0])   cube([2,12,2],center = true); //zarazka vlavo dole
          translate([15,15,0])  cube([2,12,2],center=true);   //zarazka vpravo dole
          translate([5,15,20])  cube([2,12,2],center = true); //zarazka vlaho hore
          translate([15,15,20]) cube([2,12,2],center=true);   //zarazka vpravo hore
        }
        translate([10,15,10]) rotate([-90,0,0]) //stator
               cylinder(h=10,r=4,center=true);
        translate([10,5,10]) rotate([-90,0,0])  //rotor
               cylinder(h=10,r1=2,r2=3,center=true);
        // lopatky vrtule horla, prava, holna, lava
        translate([10,5,10]) rotate([0, 20,0]) rotate([0,0,30]) cube([3,2,10]);
        translate([10,5,10]) rotate([0,110,0]) rotate([0,0,30]) cube([3,2,10]);
        translate([10,5,10]) rotate([0,200,0]) rotate([0,0,30]) cube([3,2,10]);
        translate([10,5,10]) rotate([0,290,0]) rotate([0,0,30]) cube([3,2,10]);
        difference() {  // predny plach s priedochom
            translate([0,0,0]) 
               cube([20,2,20]);
            translate([10,0,10]) rotate([-90,0,0])
               cylinder(h=8,r=7,center=true);
        }
        difference() {  //uchyty
            union() {
                translate([ 0,-5,2]) cube([2,5,16]);  //lavy
                translate([18,-5,2]) cube([2,5,16]);  //pravy
            }
            translate([-5,-2,5]) cube([30,2,10]);  //vyrez v uchytoch
        }
        
    } }
    }
}


module fanChassis(layer) {
    union() {
    if (layer == "grey") { color("grey") {
        translate([0,0,0])   cube([44,24,2]); //spodna
        translate([0,0,2])   cube([2,24,20]); //lava
        translate([42,0,2])  cube([2,24,20]); //prava
        translate([2,22,2])  cube([40,2,20]); //zadna
        translate([0,0,22])  cube([44,24,2]); //vrchna
        
        translate([5,15,2])  cube([2,10,2],center=true);
        translate([15,15,2]) cube([2,10,2],center=true);
        translate([25,15,2]) cube([2,10,2],center=true);
        translate([35,15,2]) cube([2,10,2],center=true);

        translate([5,15,22])  cube([2,10,2],center=true);
        translate([15,15,22]) cube([2,10,2],center=true);
        translate([25,15,22]) cube([2,10,2],center=true);
        translate([35,15,22]) cube([2,10,2],center=true);

    } }
    }
}


$fs=1;
module main(layer) {
    translate([0,0,0])     chassis(layer);
    translate([50,0,0])    lineCard(layer,1.7,"1.7","IOM");
    translate([100,0,0])   lineCard(layer,1.5,"1.5","IOM");
    translate([150,0,0])   lineCard(layer,2.0,"2.0","IOM");

    translate([0,-50,0])   fanChassis(layer);
    translate([0,  -100,0]) fanModule(layer);    
    translate([50, -100,0]) fanModule(layer);    

    //translate([0,0,0]) lineCard(layer,1.5,"card1");
    //translate([0,0,0]) fanModule(layer);    
    
}


translate([0,0,0]) {
    main("grey");
    main("blue");
    main("green");
    main("red");
}

// film
//rotate([0,0,$t*360])
//translate([-100,0,0]) {
//    main("grey");
//    main("blue");
//    main("green");
//    main("red");
//}

