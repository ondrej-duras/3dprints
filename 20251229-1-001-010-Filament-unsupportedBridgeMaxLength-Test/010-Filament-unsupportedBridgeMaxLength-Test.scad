/* Brief */
// Test of the maximal length of unsupported bridge
// result longest bridge.
/* Config */
// volba pohladu
preview="plate";    // [plate]
// hrubka stlpikov a mosta
tick=2;             // [0.5:0.1:4]
// skok-Y testu dlzky mosta
steplen=10;         // [1:1:30]
// skok-X odstupu dvoch mostov vedla seba
steppos=5;
// minimalna dlzka mosta
minlen=20;          // [20:5:100]
// pocet mostov
steps=21;           // [1:1:21]
/* Colors */
colorBridge="#a0a0a0";

module unsupportedBridge(length=20,tick=2) {
    // length - the length of unsupported bridge
    // tick   - tickness of bridge
    hight = 10;
    color(colorBridge) union() {
        translate([0,0,0])              // predny stlpik -vychodzi - staticky
            cube([steppos+tick,tick,hight]);
        translate([0,tick+length,0])    // zadny stlpik -cielovy - dynamicky
            cube([steppos+tick,tick,hight]);
        translate([0,0,hight])          // bridge - spojnica oboch stlpikov - so svetlou dlzkou = length
            cube([tick,tick+length+tick,tick]);
        echo(str("length=",length));
    }
}

/* Preview */
if(preview=="plate") {
    for(i=[0:1:steps]) {
        translate([i*steppos,0,0])
        unsupportedBridge(minlen+i*steplen,tick);
    }
}

