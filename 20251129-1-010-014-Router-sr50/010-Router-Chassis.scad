// the Main Chassis of Router
//$vpt = [4, 3, 15]; ... ViewPortTranslate
//$vpr = [60, 0, 35]; ... ViewPortRotate
//$vpd = 180; ............ ViewPortDistance
//$t ..................... time in range [0..1]


preview=true;  // iba na schovanie sekcie "preview"
setup="design_tray_fan"; // [design_tray_linecards, design_tray_fan, design_tray_psu, design_fan, design_psu, design_filters, design_cards, present_delabored, models, print]

// ### CONFIGURATION ################################################ {{{ 1
// hight of each llineCard is 4mm
// width of each lineCard is 40mm
// depth of each lineCard is 50mm
//
// Space for lineCards
//xx
//x-
//xx
//x- ...bottom one
//xxxxxxxxxxxxxxxxxxxxxxxxxx

// thickness of walls 2mm - 0.2for separation gap

lineCardWidth=40;  // sirka dosky lineKarty
lineCardDepth=50;  // hlbka dosky lineKarty
lineCardHight=8;  // vyska celnej listy lineKarty
lineCardTick=1.5;  // hrubka dosky lineKarty
spacing=0.2;       // skara medzi trecimi plochami
border=2.0;        // hrubka steny v Chassis
holder=2.0;        // strana svtorcoveho profilu na drzanie kariet
griddia=0.5;       // hrubka drotu ochrannej mriezky
inder=holder-2*spacing; // vnutorny rozmer holdera

color_grey="#808080";   // siva zakladna farba
color_red="#500000";    // cervena - casti namahane tlakom z hora
color_black="#000040";  // cierna  - casti namahane tlakom zo spodu
color_blue="#2020A0";   // modra pre extrudovane texty (prenasane do tlace)
color_fan="#a01010";    // farba ventilatora ... tu cervena
color_psu="#008080";    // farba modulu napajania
color_filter="#20c0c0"; // farba filtrov
color_nokia="#2020c0";  // farba napisu NOKIA
color_plate="#408080";  // farba filtroveho platu
color_shield="#808080"; // farba zaslepky slotu pre lineCartu
color_label="#802010";  // farba blahozelania

fanWidth=lineCardWidth/2; // ==filterWidth ==psuWidth ...pouziva sa iba fan*
fanHight=lineCardWidth/2; // ==filterHight ==psuHight -//-
fanDepth=lineCardDepth/2; // ==filterDepth ==psuDepth -//-

psuTrayDepth=lineCardDepth+border+fanDepth+border;
psuTrayWidth=lineCardWidth+2*border;
psuTrayHight=fanHight+2*border;

psu=1; slots=1; // len demo ... slot a psu su parametre modulov. Nepouzivat !
th1=psuTrayHight*psu+slots*lineCardHight+2*border;
xlk=(lineCardWidth+2*border)/2-(fanWidth/2); //lava kolajnica (dolna/horna) aj psu fan filter
xpk=(lineCardWidth+2*border)/2+(fanWidth/2); //prava kolajnica (dolna/horna) aj psu fan filter

modelsDistance=100; // rozostup medzi modelmi

module nokia() { 
   // polygon(points=[[0,0],[0,20],[20,20],[20,0]],paths=[[0,1,2,3]]);
   // N
   translate([0,0])
   polygon([[0,0],[0,20],[17,4],[17,0],[3,13],[3,0]],
          [[0,1,2,3,4,5]]);
   // O
   translate([30,10]) difference() {
       circle(r=10);
       circle(r=7);
   }
   // K
   translate([43,0]) polygon(
   [[0,10],[12,20],[16,20],[4,10],[16,0],[12,0]],
   [[0,1,2,3,4,5]]
   );
   // I
   translate([62,0]) square([3,20]);
   // A
   translate([68,0]) polygon(
   [[0,0],[5,8],[17,8],[10,17],[12,20],[26,0],[22,0],
   [19,5],[7,5],[4,0]],
   [[0,1,2,3,4,5,6,7,8,9]]
   );
} // module

module chassisCardTray(slots=7,fans=2,psu=1,label=true) {
    union() { 
    color(color_grey) { difference()  {
        // vonkajsia kocka - vonkajsi rozmer chassis
        translate([0,0,0]) 
          cube([lineCardWidth+(2*border),
                lineCardDepth+border,
                slots*lineCardHight+(2*border)]
              );
        // vnutorna kocka - vyrez - vnutorny rozmer chassis
        translate([border-spacing,0-1,border-spacing]) 
          cube([lineCardWidth+(2*spacing),
                lineCardDepth+spacing+1,
                slots*lineCardHight+(2*spacing)]
              );
        
        // vetracie diery nad lineKartami
        x1=((lineCardWidth/2)+border)*2/3;
        w1=lineCardWidth/3;
        h1=holder;
        for(z=[0:1:slots-1]) {
            z1=(z*lineCardHight)+lineCardTick+(2*spacing)+border+holder;
            translate([x1,lineCardDepth-1,z1])
              cube([w1,border*5,h1]);
        } //vetracie diery
        
        // "vyhryzy" pre spojovacie hranoly
        y3=lineCardDepth+border;
        x3a=border*3;
        x3b=lineCardWidth-border;
        z3=((lineCardHight*slots)+(2*border))/2;
        if(holder > border) {
            translate([x3a,y3,z3]) // lavy 
                cube([holder,border,slots*border*2],center=true);
            translate([x3b,y3,z3]) // pravy
                cube([holder,border,slots*border*2],center=true);
        } else {
            translate([x3a,y3,z3]) // lavy, ten isty ked...
                cube([holder,holder,slots*border*2],center=true);
            translate([x3b,y3,z3]) // pravy, ten isty ked ...
                cube([holder,holder,slots*border*2],center=true);
        }
        translate([lineCardWidth/2+border,3*border,0]) //spodny predny
            cube([lineCardWidth-2*border,holder,holder],center=true);
        translate([lineCardWidth/2+border,lineCardDepth-2*border,0]) //spodny zadny
            cube([lineCardWidth-2*border,holder,holder],center=true);
    } } //difference //color grey
    
    // cyklus vytvorenia jednotlivych slotov a ocislovani
    union() { for(z=[0:1:slots-1]) { 
        z1=(z*lineCardHight)+lineCardTick+(2*spacing)+border;
        z2=(z*lineCardHight)+lineCardHight-holder+border;
        z3=(z*lineCardHight)+border;
        s1=str(z+1);

        color(color_black) {
        // horny drziak karty, lava cast
        translate([border-spacing,border,z1])
          cube([holder,lineCardDepth+spacing-border,holder]);
        // horny drziak karty, zadna cast
        translate([border-spacing,lineCardDepth+spacing-holder,z1])
          cube([lineCardWidth+(2*spacing),holder,holder]);
        // horny drziak karty, prava cast
        translate([border+lineCardWidth+spacing-holder,border,z1])
          cube([holder,lineCardDepth+spacing-border,holder]);
        } //color black
        
        color(color_red) {
        // dolny drziak karty, lava cast
        translate([border-spacing,border,z2])
          cube([holder,lineCardDepth+spacing-border,holder]);
        // dolny drziak karty, zadna cast
        translate([border-spacing,lineCardDepth+spacing-holder,z2])
          cube([lineCardWidth+(2*spacing),holder,holder]);
        // dolny drziak karty, prava cast
        translate([border+lineCardWidth+spacing-holder,border,z2])
          cube([holder,lineCardDepth+spacing-border,holder]);
        } //color red

        // ocislovanie slotu
        color(color_blue) {
        translate([0,10,z3]) rotate([90,0,-90])
          linear_extrude(1) text(s1, size=4, font="arial");
        }
        
        // label s Blahozelanim
        if(label==true && slots>=5) { color(color_label) {
            tz1=slots*lineCardHight+2*border;
            f1_size=15;
            f2_size=7;
            translate([psuTrayWidth,4*border,tz1-f1_size-2*border])
                rotate([90,0,90])
                linear_extrude(1)
                text("sr.50",size=f1_size,font="arial");
            translate([psuTrayWidth,4*border,tz1-f1_size-f2_size-5*border])
                rotate([90,0,90])
                linear_extrude(1)
                text("prototyp",size=f2_size,font="arial");
            translate([psuTrayWidth,4*border,tz1-f1_size-2*f2_size-6*border])
                rotate([90,0,90])
                linear_extrude(1)
                text("4Adrian",size=f2_size,font="arial");
            
        } }// color_label if
    } } // cardHolderLines // union
    } // union
}

module chassisAdhesiveBars(slots=7,fans=2,psu=1) {
   // vertikalne spojovacie hranolceky (medzi karty a ventilatory) 2ks
   if(holder > border) {
     color(color_grey) {
       translate([holder*1,0,0])
           cube([holder,slots*border*2,border],center=false);
       translate([holder*3,0,0])
           cube([holder,slots*border*2,border],center=false);
     }
   } else {
      color(color_grey) {
            translate([holder*1,0,0])
                cube([holder,slots*border*2,holder],center=false);
            translate([holder*3,0,0])
                cube([holder,slots*border*2,holder],center=false);
      }
   }
   // horizontalne spojovacie hranolceky (medzi vrchne a spodne Tray-e) 4ks
   color(color_grey) {
        for(i=[0:1:3]) {
            x1=holder*(5+i*2);
            translate([x1,0,0])
            cube([holder,lineCardWidth-2*border,holder]);
        }
   }   
}

module chassisEar(slots=7,fans=2,psu=1,side="left") { color(color_grey) {
    th1=psuTrayHight*psu+slots*lineCardHight+2*border;
    difference() {
        translate([0,0,0])
            cube([th1,3*border,4*border]);
        translate([-1,holder,holder])
            cube([th1+2,3*border,4*border]);
        for(x1=[1.5*border:3*border:th1-1.5*border]) {
            if(side=="left") {
            translate([x1,0,2.5*border])
                cube([border,border+2,border],center=true);
            }
            if(side=="right") {
            translate([th1-x1,0,2.5*border])
                cube([border,border+2,border],center=true);
            }
        }
    }
} } //color_grey module
module chassisFanTray(slots=7,fans=2,psu=1,logo=true) {
  union() {
    color(color_grey) { difference()  {
        // vonkajsia kocka - vonkajsi rozmer chassis
        translate([0,0,0]) 
          cube([lineCardWidth+(2*border),
                fanDepth+border,
                slots*lineCardHight+(2*border)]
              );
        // vnutorna kocka - vyrez - vnutorny rozmer chassis
        translate([border-spacing+(lineCardWidth/4),
                  (fanDepth/2),
                   border-spacing]
                 ) 
          cube([(lineCardWidth/2)+(2*spacing),
                (fanDepth/2)+spacing,
                slots*lineCardHight+(2*spacing)]
              );

        // vyrezy pre ventilatory
        for(z=[0+border:3*lineCardHight:lineCardHight*(slots-3)]){
            translate([border-spacing,0-1,z])
            cube([lineCardWidth+(2*spacing),fanDepth+1,fanHight]);
        }

        
        
        // vetracie diery nad lineKartami
        x1=((lineCardWidth/2)+border)*2/3;
        w1=lineCardWidth/3;
        h1=holder;
        for(z=[0:1:slots-1]) {
            z1=(z*lineCardHight)+lineCardTick+(2*spacing)+border+holder;
            translate([x1,fanDepth-1,z1])
              cube([w1,border*5,h1]);
        } //vetracie diery
        
        // "vyhryzy" pre spojovacie hranoly
        y3=fanDepth+border;
        x3a=border*3;
        x3b=lineCardWidth-border;
        z3=((lineCardHight*slots)+(2*border))/2;
        if(holder > border) {
            translate([x3a,y3,z3])
                cube([holder,border,slots*border*2],center=true);
            translate([x3b,y3,z3])
                cube([holder,border,slots*border*2],center=true);
        } else {
            translate([x3a,y3,z3])
                cube([holder,holder,slots*border*2],center=true);
            translate([x3b,y3,z3])
                cube([holder,holder,slots*border*2],center=true);
        }
        translate([lineCardWidth/2+border,3*border,0]) //spodny predny vyhryz
             cube([lineCardWidth-2*border,holder,holder],center=true);
        translate([lineCardWidth/2+border,fanDepth-2*border,0]) //spodny zadny vyhryz
             cube([lineCardWidth-2*border,holder,holder],center=true);
    } } //difference //color grey
    color(color_red) {
        for(z=[0+border:3*lineCardHight:lineCardHight*(slots-3)]) {
            translate([xlk,border*3,z-spacing]) //lava dolna kolajnica
                cube([inder,border*4,inder],center=true);
            translate([xpk,border*3,z-spacing]) //prava dolna kolajnica
                cube([inder,border*4,inder],center=true);
            translate([border,border*3,z+(fanHight+2*border)/2]) //lava stredna kolajnica
                cube([inder,border*4,inder],center=true);
            translate([border+lineCardWidth,border*3,z+(fanHight+2*border)/2]) //prava stredna
                cube([inder,border*4,inder],center=true);
            translate([xlk,border*3,z+fanHight+spacing]) //lava horna kolajnica
                cube([inder,border*4,inder],center=true);
            translate([xpk,border*3,z+fanHight+spacing]) //prava horna kolajnica
                cube([inder,border*4,inder],center=true);
        }
    } //color_red
    z1=slots*lineCardHight+2*border;
    if(logo==true) { color(color_nokia) {
        translate([psuTrayWidth,border,z1-10-5]) 
            rotate([90,0,90]) 
            linear_extrude(1)
            resize([fanDepth-2*border,,],[true,true,true]) 
            nokia();
    } } // if color_blue logo
  } //union             
} //module chassisFanTray


module chassisPsuTray(slots=7,fans=2,psu=1) {
  union() {
    color(color_grey) { difference() {
        translate([0,0,0]) 
            cube([psuTrayWidth,psuTrayDepth,psuTrayHight]);
        translate([border-spacing,0-1,border-spacing])
            cube([lineCardWidth+2*spacing,psuTrayDepth+2,fanHight+2*spacing]);

        // vyhryzy na spojenie s psuTray-a s cardTray-om.
        translate([lineCardWidth/2+border,3*border,psuTrayHight]) //horny predny
            cube([lineCardWidth-2*border,holder,holder],center=true);
        translate([lineCardWidth/2+border,lineCardDepth-2*border,psuTrayHight]) //horny zadny
            cube([lineCardWidth-2*border,holder,holder],center=true);

        // vyhryzy na spojenie s psuTray-a s fanTray-om.
         //horny predny vyhryz
        translate([lineCardWidth/2+border,psuTrayDepth-(3*border),psuTrayHight])
             cube([lineCardWidth-2*border,holder,holder],center=true);
         //horny zadny vyhryz
        translate([lineCardWidth/2+border,psuTrayDepth-(fanDepth-2*border),psuTrayHight])
             cube([lineCardWidth-2*border,holder,holder],center=true);

        // vyhryzy na spojenie psuTra-a s pripadnym dalsim psuTray-om dole
        translate([lineCardWidth/2+border,3*border,0]) // spodny predny
            cube([lineCardWidth-2*border,holder,holder],center=true);
        translate([lineCardWidth/2+border,lineCardDepth-2*border,0]) //spodny zadny
            cube([lineCardWidth-2*border,holder,holder],center=true);

        // vyhryzy na spojenie s psuTray-a s fanTray-om.
         //spodny predny vyhryz
        translate([lineCardWidth/2+border,psuTrayDepth-(3*border),0])
             cube([lineCardWidth-2*border,holder,holder],center=true);
         //spodny zadny vyhryz
        translate([lineCardWidth/2+border,psuTrayDepth-(fanDepth-2*border),0])
             cube([lineCardWidth-2*border,holder,holder],center=true);



    } } // difference color_grey
    color(color_red) {
        // lavy pridrzaci pas
        translate([border-spacing,psuTrayDepth/2,psuTrayHight/2])
            cube([inder,psuTrayDepth-2*border,inder], center=true);
        // pravy pridrzaci pas
        translate([lineCardWidth+border+spacing,psuTrayDepth/2,psuTrayHight/2])
            cube([inder,psuTrayDepth-2*border,inder], center=true);
        // spodny lavy pridrzaci pas
        translate([xlk,psuTrayDepth/2,border])
            cube([inder,psuTrayDepth-2*border,inder], center=true);
        // spodny pravy pridrzaci pas
        translate([xpk,psuTrayDepth/2,border])
            cube([inder,psuTrayDepth-2*border,inder], center=true);
        // horny lavy pridrzaci pas
        translate([xlk,psuTrayDepth/2,psuTrayHight-border])
            cube([inder,psuTrayDepth-2*border,inder], center=true);
        // horny pravy pridrzaci pas
        translate([xpk,psuTrayDepth/2,psuTrayHight-border])
            cube([inder,psuTrayDepth-2*border,inder], center=true);

    } //color_red
  } //union
}

module chassis(slots=7,fans=1,psu=1,logo=true,ears=true,label=true) {
th1=psuTrayHight*psu+slots*lineCardHight+2*border;
union() {
  for(z=[0:1:psu-1]) {
      translate([0,0,z*psuTrayHight]) 
          chassisPsuTray(slots,fans,psu);
  }
  translate([0,0,psu*psuTrayHight]) 
      chassisCardTray(slots,fans,psu);
  translate([psuTrayWidth,psuTrayDepth,psu*psuTrayHight]) 
      rotate([0,0,180])
      chassisFanTray(slots,fans,psu,logo);
  if(ears==true) {
     translate([0,0,0])
        rotate([0,-90,0])
        chassisEar(slots,fans,psu,side="left");
     translate([lineCardWidth+2*border,0,th1])
        rotate([0,90,0])
        chassisEar(slots,fans,psu,side="right");
  } // if ears
}  // union
} // module chassis
module fanBox() { color(color_fan) {
  fanSD=fanWidth-4*border; 
  if(fanWidth > fanHight) { fanSD=fanHight-4*border; }
  fanBD=fanSD+2*border;
  difference() {
  union() {
    difference() {
        // hlavna krabica ventilatora 
        translate([0,-2*holder,0])  // hlavna krabica, z ktorej ukrajujeme 
            cube([fanWidth,fanDepth+2*holder,fanHight]);
        translate([border,4*border,border]) // vnutorny kvadrovity vyrez - vnutorny priestor
            cube([fanWidth-2*border,fanDepth,fanHight-2*border]);
        translate([holder,-2.5*holder,-1]) // vyrezanie priestoru medzi uchytmi
            cube([fanWidth-2*holder,2.5*holder,fanHight+2]);
        translate([-1,-holder,2*holder])  //vyrezanie dier v uchytoch
            cube([fanWidth+2,holder,fanHight-4*holder]);
        translate([fanWidth/2,0,fanHight/2]) //vonkajsi kruhovy vyrez-maly
            rotate([90,0,0]) 
            cylinder(h=3*border,d=fanSD,center=true);
        translate([fanWidth/2,4*border,fanHight/2]) //vnutorny velky kruhovy vyrez-opretie
            rotate([90,0,0])                        //lopatiek vrtule
            cylinder(h=6*border,d=fanBD,center=true);
    } //difference
    translate([fanWidth/2,3*fanDepth/4,fanHight/2]) //vertikalny drziak statora - doska
        cube([holder,fanDepth/2,fanHight],center=true);
    translate([fanWidth/2,3*fanDepth/4,fanHight/2]) // horizontalny drziak statora - doska
        cube([fanWidth,fanDepth/2,holder],center=true);
    translate([fanWidth/2,3*fanDepth/4,fanHight/2]) //stator motora ventilatora
        rotate([90,0,0])
        cylinder(h=fanDepth/2,d=fanSD*2/3,center=true); 
    translate([fanWidth/2,fanDepth,fanHight/2])  // rotor motora ventilatora - kuzelovy
        rotate([90,0,0])
        cylinder(h=fanDepth,d1=fanSD*2/3,d2=fanSD*1/5,center=false);
    fr=11;  //menitelny pocet lopatiek vrtule ventilatora
    for(i=[0:360/fr:360]) {
         translate([fanWidth/2,border*3,fanHight/2])
            rotate([0,i,30])
             cube([holder,0.5,fanHight/2]);
    }
    gr=5; //pocet drotov ochrannej mriezky vratane prvej a poslednej
    xfirst=fanWidth/2-fanSD/2;
    xlast=fanWidth/2+fanSD/2;
    xshift=fanSD/(gr-1);
    for(x1=[xfirst:xshift:xlast]) {
        translate([x1,-griddia,fanHight/2])
          cube([griddia,griddia*2,fanSD],center=true);
    }
    zfirst=fanHight/2-fanSD/2;
    zlast=fanHight/2+fanSD/2;
    zshift=fanSD/(gr-1);
    for(z1=[zfirst:zshift:zlast]) {
        translate([fanWidth/2,-griddia,z1])
          cube([fanSD,griddia*2,griddia],center=true);
    }    
  } // union
    translate([fanWidth/2-(border/2),3*border,fanHight-(border/2)]) //horny kolajovy vyrez
       cube([holder,fanDepth,holder],center=false);
    translate([-(border/2),3*border,fanHight/2-(border/2)])  // lavy kolajovy vyres
       cube([holder,fanDepth,holder],center=false);
    translate([fanWidth-(border/2),3*border,fanHight/2-(border/2)])  //pravy kolajovy vyrez
       cube([holder,fanDepth,holder],center=false);
    translate([fanWidth/2-(border/2),3*border,-border/2]) //spodny kolajovy vyrez
       cube([holder,fanDepth,holder],center=false);
  } //difference-ext
} } // color_red module 

module psuBox(power="dc") { color(color_psu) {

  fanSD=fanWidth-4*border; 
  if(fanWidth > fanHight) { fanSD=fanHight-4*border; }
  fanBD=fanSD+2*border;
  difference() {
  union() {
    difference() {
        // hlavna krabica ventilatora 
        translate([0,-2*holder,0])  // hlavna krabica, z ktorej ukrajujeme 
            cube([fanWidth,fanDepth+2*holder,fanHight]);
//        translate([border,border,border]) // vnutorny kvadrovity vyrez - vnutorny priestor
//            cube([fanWidth-2*border,fanDepth,fanHight]);
        translate([2*holder,-holder,-1]) // vyrezanie diery uchytu
            cube([fanWidth-4*holder,holder,fanHight+2]);
        translate([-1,-2.5*holder,-2])  //vyrezanie priestoru pod uchytom
            cube([fanWidth+2,2.5*holder,fanHight-holder+1]);
//        translate([-1,fanDepth*3/4,fanHight/3]) // vyrezanie L pre konektor zdroja
//            cube([fanWidth+2,fanDepth,fanHight]);
        translate([fanWidth/2-2*border,fanDepth*4/5,-1])  //spodny vyrez pre vytorny konektor
            cube([border*4,fanDepth/3,border+1],center=false); // ...pre nozove kontakty
    } //difference
      // vonkajsie svorky
      translate([1*fanWidth/6,0,fanHight/5])  //lava svorka +
          rotate([90,0,0])
          cylinder(h=1.5*border,d=holder*1.3); 
      translate([2*fanWidth/6,0,fanHight/5])  //lava svorka -
          rotate([90,0,0])
          cylinder(h=1.5*border,d=holder*1.3);
      translate([4*fanWidth/6,0,fanHight/5])  //prava svorka +
          rotate([90,0,0])
          cylinder(h=1.5*border,d=holder*1.3);
      translate([5*fanWidth/6,0,fanHight/5])  // prava svorka -
          rotate([90,0,0])
          cylinder(h=1.5*border,d=holder*1.3);
      // napisy
      translate([border,0,fanHight*4/6])       // napis 48-60V
      //resize([fanWidth-2*border,,],[true,true,true])  
      rotate([90,0,0])
      linear_extrude(1) 
      text("DC48~60V",size=2.5,font="ariel");
      translate([border,0,fanHight*2/6])       // vyznacenie polarity na svorkach +- +-
      //resize([fanWidth-2*border,,],[true,true,true])  
      rotate([90,0,0]) 
      linear_extrude(1)
      text("+-  +-",size=5,font="ariel");
      // noze vnutorneho konektora
      translate([fanWidth/2-2*border+0.5*border,fanDepth*4/5,0])
          cube([griddia,fanDepth/5,border]);
      translate([fanWidth/2-2*border+1.0*border,fanDepth*4/5,0])
          cube([griddia,fanDepth/5,border]);

      translate([fanWidth/2+2*border-0.7*border,fanDepth*4/5,0])
          cube([griddia,fanDepth/5,border]);
      translate([fanWidth/2+2*border-1.2*border,fanDepth*4/5,0])
          cube([griddia,fanDepth/5,border]);

  } // union
    translate([fanWidth/2-(border/2),3*border,fanHight-(border/2)]) //horny kolajovy vyrez
       cube([holder,fanDepth,holder],center=false);
    translate([-(border/2),3*border,fanHight/2-(border/2)])   //lavy kolajovy vyrez
       cube([holder,fanDepth,holder],center=false);
    translate([fanWidth-(border/2),3*border,fanHight/2-(border/2)]) //pravy kolajovy
       cube([holder,fanDepth,holder],center=false);
    translate([fanWidth/2-(border/2),3*border,-border/2]) //dolny kolajovy vyrez
       cube([holder,fanDepth,holder],center=false);
  } //difference-ext
} } // color_psu module 

module filterBox(plates=3,logo=true) { color(color_filter) {
   union() {
   difference() {
       translate([0,-2*border,0])  // hlavny kvader z ktoreho rezeme
           cube([lineCardWidth,fanDepth+2*border,fanHight]);
       translate([border,border,border])  // vnutorny priestor filtroveho shelf-u
           cube([lineCardWidth-2*border,fanDepth,fanHight]);
       translate([border,-2.5*border,-1])
           cube([lineCardWidth-2*border,2.5*border,fanHight+2]);
       translate([-1,-border,2*border])
           cube([lineCardWidth+2,border,fanHight-4*border]);
       translate([2*border,-1,fanHight/3])
           cube([lineCardWidth-4*border,2*border,fanHight/3]);


    xlr=(lineCardWidth+2*border)/2-(fanWidth/2)-border; //lava kolajnica 
    xpr=(lineCardWidth+2*border)/2+(fanWidth/2)-border; //prava kolajnica

    translate([-(border/2),3*border,fanHight/2-(border/2)])   //lavy kolajovy vyrez
       cube([border,fanDepth,border],center=false);
    translate([2*fanWidth-(border/2),3*border,fanHight/2-(border/2)]) //pravy kolajovy
       cube([border,fanDepth,border],center=false);
    translate([xlr,3*border,-border/2]) //dolny kolajovy vyrez - lavy
       cube([border,fanDepth,border],center=false);
    translate([xpr,3*border,-border/2]) //dolny kolajovy vyrez - pravy
       cube([border,fanDepth,border],center=false);


   } //difference
   for(x1=[2*border+griddia:2*griddia:lineCardWidth-2*border]) { //predna mreza filtra
        translate([x1,0,fanHight/3])
            cube([griddia,border,fanHight/3]);
   } // predna mreza filtra

   // holdery jednotlivych platov filtra
   for(y1=[border+2*spacing:border+holder+2*spacing:plates*(border+holder+2*spacing)]) {
        difference() {
            translate([border,y1+border,border])
                cube([lineCardWidth-2*border,holder,fanHight-border]);
            translate([border+3*spacing,y1+border-0.5,border+3*spacing])
                cube([lineCardWidth-2*border-6*spacing,holder+1,fanHight]);
        }
   } // for holdery platov
   } // color_filter
   } //union
   if(logo==true) { color(color_nokia) {
   translate([2*border+lineCardWidth/6,-0.5,fanHight*(2/3+1/20)]) //napis NOKIA na filtri
        rotate([90,0,0])
        linear_extrude(1)
        resize([(lineCardWidth-4*border)*2/3,,],[true,true,true])
        nokia();
   } } // color_nokia if
} // module
module filterPlate() { color(color_plate) {
    union() {
    difference() {
    // hlavny ramec
    translate([0,0,0])
        cube([lineCardWidth-2*spacing,border-2*spacing,fanHight-2*spacing]);
    // vyrez pre medium filtra
    translate([border,-1,border])
        cube([lineCardWidth-2*border,border+2,fanHight-2*border]);
    // vyrezy pre nechty
    translate([border,-1,border/2-griddia/2]) // dolny predny
        cube([lineCardWidth-2*border,griddia+1,griddia]);
    translate([border,-1,fanHight-border/2-griddia/2])  // horny predny      
        cube([lineCardWidth-2*border,griddia+1,griddia]);
    translate([border,border-griddia,border/2-griddia/2]) // dolny zadny
        cube([lineCardWidth-2*border,griddia+1,griddia]);
    translate([border,border-griddia,fanHight-border/2-griddia/2]) // horny zadny     
        cube([lineCardWidth-2*border,griddia+1,griddia]);
         
    } //difference      
    for(x1=[border:griddia*2:lineCardWidth-border]) {
        translate([x1,border-griddia-2*spacing,border])
            cube([griddia,griddia,fanHight-2*border]);
    } // for x1
    for(z1=[border:griddia*2:fanHight-border]) {
        translate([border,border-griddia-2*spacing,z1]) 
            cube([lineCardWidth-2*border,griddia,griddia]);
    } // for z1
    } // union
} }// color_plate module filterPlate

module shieldCard() { color(color_shield) {
    union() {
        translate([0,0,0])  // spodna doska lineKarty
            cube([lineCardWidth,lineCardDepth,lineCardTick]);
        translate([0,0,0])  // predne celo lineKarty
            cube([lineCardWidth,border,lineCardHight]);
        translate([0,-2*holder,0])   // lavy pakovy uchyt karty
            cube([2*holder,2*holder,holder]);
        translate([0,-2*holder,0])
            cube([4*holder,holder,holder]);
        translate([lineCardWidth-2*holder,-2*holder,0]) //pravy pakovy uchyt karty
            cube([2*holder,2*holder,holder]);
        translate([lineCardWidth-4*holder,-2*holder,0])
            cube([4*holder,holder,holder]);
        translate([holder,0,lineCardHight/2])
            rotate([90,0,0])
            cylinder(h=holder,d=holder,center=true);
        translate([lineCardWidth-holder,0,lineCardHight/2])
            rotate([90,0,0])
            cylinder(h=holder,d=holder,center=true);
    }
} } // color_shield module
if(preview==true) { // sekcia "napozovania" jednotlivych komponent , if ma iba folduje
    if(setup=="design_tray_linecards") {
        translate([0,0,0])  chassisCardTray(7,2,1);
        translate([50,0,0]) chassisAdhesiveBars(7,2,1);
    } 

    if(setup=="design_tray_fan") {
        translate([44,52+50,0]) rotate([0,0,180]) chassisCardTray(7,2,1);
        translate([0,0,0]) chassisFanTray(7,2,1);
        translate([-20,-20,0]) rotate([0,0,180]) chassisFanTray(7,2,1);
    }

    if(setup=="design_tray_psu") {
        translate([0,0,0]) 
            chassisPsuTray(slots=7,fans=2,psu=1);
        translate([0,0,2*psuTrayHight]) 
            chassisCardTray(slots=7,fans=2,psu=1);
        translate([lineCardWidth+2*border,lineCardDepth+border+fanDepth+border,2*psuTrayHight])
            rotate([0,0,180]) 
            chassisFanTray(slots=7,fans=2,psu=1);
    }
    if(setup=="design_fan") {
        translate([-border+psuTrayWidth,1.5*fanDepth+psuTrayDepth,-border-psuTrayHight])
            rotate([0,0,,180])
            chassis(7,2,1,true);
        translate([0,0,0])
            fanBox();
        translate([fanWidth,2*fanDepth+psuTrayDepth,0])
            fanBox();
    }
    if(setup=="design_psu") {
        translate([-border+psuTrayWidth,1.5*fanDepth+psuTrayDepth,-border])
            rotate([0,0,180])
            chassis(7,2,1,true);
        translate([0,0,0])
            psuBox();
        translate([fanWidth,2*fanDepth+psuTrayDepth,0])
            psuBox();
    }
    if(setup=="design_filters") {
        translate([-border,1*psuTrayDepth,-border])
            chassis(7,2,1,true);
        translate([0,0,0])
            filterBox();
        translate([0,2.5*psuTrayDepth,0])
            filterBox();

        // filterPlaty vedla Tray-a
        translate([psuTrayWidth+3*border,border+0*(border+holder),border])
            filterPlate();
        translate([psuTrayWidth+3*border,border+1*(border+holder),border])
            filterPlate();
        translate([psuTrayWidth+3*border,border+2*(border+holder),border])
            filterPlate();

        //leziaci plat filtra
        translate([0,-1.5*fanHight,0])
            rotate([-90,0,0])
            filterPlate();

    }
    if(setup=="design_cards") {
        translate([-border,1*psuTrayDepth,-border-psuTrayHight])
            chassis(7,2,1,true);
        translate([0,0,0])
            shieldCard();
    }
    if(setup=="models"){
        w0=modelsDistance*0;  q0=w0+50;
        translate([w0,0,0])   chassis(15,5,3);
        translate([w0,0,0])   rotate([0,0,-90]) chassisAdhesiveBars(15,5,3);

        w1=modelsDistance*1;  q1=w1+50;
        translate([w1,0,0])   chassis(10,3,2);
        translate([w1,0,0])   rotate([0,0,-90]) chassisAdhesiveBars(10,3,2);

        w2=modelsDistance*2;  q2=w2+50;
        translate([w2,0,0])   chassis(7,2,1);
        translate([w2,0,0])   rotate([0,0,-90]) chassisAdhesiveBars(7,2,1);

        w3=modelsDistance*3;  q3=w3+50;
        translate([w3,0,0])   chassis(5,1,1);
        translate([w3,0,0])   rotate([0,0,-90]) chassisAdhesiveBars(5,1,1);

        w4=modelsDistance*4;  q4=w4+50;
        translate([w4,0,0])   chassis(3,1,1);
        translate([w4,0,0])   rotate([0,0,-90]) chassisAdhesiveBars(3,1,1);
    }
    if(setup=="present_delabored") {
     rotate([0,0,$t*360]) {
        translate([-border,1*psuTrayDepth,-border])  //chassis
            chassis(7,2,1,logo=true,ears=true,label=true);
        translate([0,2.5*psuTrayDepth,0])  // PSU vlavo
            rotate([0,0,180])
            psuBox();
        translate([lineCardWidth,2.5*psuTrayDepth,0]) //PSU vpravo
            rotate([0,0,180])
            psuBox();

         //FAN
        translate([0,2.5*psuTrayDepth,psuTrayHight+border])
            rotate([0,0,180]) // vlavo dole
            fanBox();
        translate([lineCardWidth,2.5*psuTrayDepth,psuTrayHight+border])
            rotate([0,0,180]) //vpravo dole
            fanBox();
        translate([0,2.5*psuTrayDepth,psuTrayHight+3*border+fanHight])
            rotate([0,0,180]) //vlavo hore
            fanBox();
        translate([lineCardWidth,2.5*psuTrayDepth,psuTrayHight+3*border+fanHight])
            rotate([0,0,180]) //vpravo hore
            fanBox();
        

        // filterTray
        translate([0,0,0])
            filterBox();

        // filterPlaty vedla Tray-a
        translate([psuTrayWidth+3*border,border+0*(border+holder),border])
            filterPlate();
        translate([psuTrayWidth+3*border,border+1*(border+holder),border])
            filterPlate();
        translate([psuTrayWidth+3*border,border+2*(border+holder),border])
            filterPlate();

        //leziaci plat filtra
        translate([0,-1.5*fanHight,0])
            rotate([-90,0,0])
            filterPlate();

        // karty 
        translate([0,0,psuTrayHight+border])
            shieldCard();  // zaslepka karty
        translate([-1*(lineCardWidth+border),0,psuTrayHight+border+1*lineCardHight])
            shieldCard();
        translate([-2*(lineCardWidth+border),0,psuTrayHight+border+2*lineCardHight])
            shieldCard();
        translate([-3*(lineCardWidth+border),0,psuTrayHight+border+3*lineCardHight])
            shieldCard();
      } //rotate
    } // if present_delabored
    if(setup=="print") {
        // tu bude priprava na vyrobu 
        // Vsetko ulozene pre 3D-tlaciaren vo vyrobnej polohe
        echo("3d-print");
        translate([0,0,lineCardDepth+border])
            rotate([-90,0,0])
            chassisCardTray(slots=7,fans=2,psu=1,label=true);
        translate([1.5*lineCardWidth,0,fanDepth+border])
            rotate([-90,0,0])
            chassisFanTray(slots=7,fans=2,psu=1,logo=true);
        translate([0,7*lineCardHight+2*border+20,0])
            chassisEar(slots=7,fans=2,psu=1,side="left");
        translate([0,7*lineCardHight+2*border+40,0])
            chassisEar(slots=7,fans=2,psu=1,side="right");
        translate([0,7*lineCardHight+2*border+60,0])
            chassisAdhesiveBars(slots=7,fans=2,psu=1);
        translate([3*lineCardWidth,0,fanDepth])
            rotate([-90,0,0])
            psuBox();
        translate([3*lineCardWidth+1.5*fanWidth,0,fanDepth])
            rotate([-90,0,0])
            psuBox();

        translate([3*lineCardWidth,fanHight*1.5,fanDepth])
            rotate([-90,0,0])
            fanBox();
        translate([3*lineCardWidth+1.5*fanWidth,fanHight*1.5,fanDepth])
            rotate([-90,0,0])
            fanBox();

        translate([3*lineCardWidth,fanHight*3,fanDepth])
            rotate([-90,0,0])
            fanBox();
        translate([3*lineCardWidth+1.5*fanWidth,fanHight*3,fanDepth])
            rotate([-90,0,0])
            fanBox();

        for(x1=[30:lineCardWidth+10:3*(10+lineCardWidth)+30]) {
            translate([x1,7*lineCardHight+2*border+60,0])
                shieldCard();
        }
        translate([3*(10+lineCardWidth)+30,0,0])
            shieldCard();
        translate([3*(10+lineCardWidth)+30,lineCardDepth+10,0])
            shieldCard();
        translate([4*(10+lineCardWidth)+30,0,0])
            shieldCard();
    }
} //preview==true  koniec sekcie "napozovania" jednotlivych komponent
