// CrowBar - Pacidlo na odlepovanie objektov z platu
// 20260421, Ondrej DURAS (dury) NOKIA

/* [Preview] */
preview="plate";
$fn=100;

/* [Dimensions] */
cbArm=80.0;  // dlzka paky pacidla
cbTip=5.0;   // dlzka hrotu pacidla
cbRad=5.0;   // polomer zaoblenia pacidla
cbExt=5.0;   // sirka pacidla


/* [Colors] */
colorCrowBar="#105030"; // farba pacidla ... je nepodstatna

module crowBar(Arm=cbArm,Tip=cbTip,Rad=cbRad,Ext=cbExt) {
    linear_extrude(Ext) {
    union() {
        translate([0,0,0])      // Tip - polygon hrotu
            polygon([[0,0],[Tip,0],[Tip,Rad]],[[0,1,2]]);
        translate([Tip,Rad])    // Arm - rameno pacidla
            square([Rad,Arm]);
        difference() {          // zaoblena cast stvrtkruh/stcrtvalec
            translate([Tip,Rad])
                circle(r=Rad);  // zakladny kruh, z ktoreho rezeme stvorec a obdlznik
            translate([0,0])
                square([Tip,2*Rad]); // urezanie 2. a 3. kvadrantu kruhu
            translate([Tip,Rad])
                square([Rad,Rad]);   // urezanie 1. kvadrandu. Ostava iba 4.-ty kvadrant.
        } //diff
    } // union
    } //Ext
}

/* [PreviewIF] */
if(preview=="plate") {
    color(colorCrowBar)
    crowBar();
}
