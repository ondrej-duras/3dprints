// Wire Hinges - box - cabinet
// 20260510, Ondrej DURAS (dury) NOKIA
// dalsi experiment s pantami krabiciek ... telco cabinetov

/* [Preview] */

spi=0.1; // spacing (zmensenie) kolika
spo=0.1; // spacing (zvacsenie) dierky ...aby kolik a dierka do seba pasovali a nezadreli sa
spp=10;  // spacing on plate ... medzera medzi dvoma vedla seba leziacimi komponentami na vyrobnom plate 
$fn=100;
wire=1.0;        // drot je 1.0 Cu, alebo 0.6 Fe ... pri wire 1.0 je planovana diera 1.1mm, co je pre 0.6Fe uplne idealne
                 // drot sa pri manipulacii skrivi ... co z funkcneho hladiska zabranuje jeho vypadnutie z pantu
                 // ...ak by nahodou vypadaval, potom mozno zasunut dlhsi drot a na oboch koncoch ho jednoducho zahnut 
                 // alebo dlhsi po oboch koncoch zahnuty drot v pripadoch, ze ho niekedy planujeme vyberat

preview="cabBasic"; // [cabBasic,cabPlate,boxBasic,boxBody,boxCover,cabBody,cabDoors,cabShelfs,roCubeD,batery,hinges,doorLock,electric,electricPlate,boxPlate]

/* [Manipulations] */
// tento uhol sluzi na otvaranie/zatvaranie krabice, alebo zamku na dverach 
angle=30;        // [0:1:180] 
// lavy a pravy zamok na dverach
angleLockLeft=30;       // [0:1:90]
angleLockRight=30;       // [0:1:90]
// uhol otvorenia dveri 0-zatvorene, 180 uplne otvorene az co dovolia panty
// otvaranie lavy dveri cabinetu 0=zatvorene 
angleDoorLeft=30;    // [0:1:180]
// otvaranie pravych dveri
angleDoorRight=30;   // [0:1:180]

// uhol packy na istici FA1 0= neutralna poloha cca 35 vypnuty, cca -35 zapnuty, ale kvoli hrubke este nevedno
angleF1=0;  // [-35:1:35] 
angleF2=0;  // [-35:1:35] 
angleF3=0;  // [-35:1:35] 
// prudovy chranic - surge protector - FI
// prudovy istic - circuit breaker  - FA
// ochrana proti prepatiu - gap protection FV - lighting rod (bleskoistka), sparkle(iskriste),  Zvodic prepatia(surge arrester)
// tavna poistka - FU
// DIN lista - DIN bar 
xxF1=0; // [0:1:100]
yyF1=0; // [0:1:20]
zzF1=0; // [0.0:0.1:0.7]
/* [Dimenssions] */
boxWidth=50;  // standartna hlzka skatulky - vonkajsi rozmer
boxDepth=44.2;// standartna sirka skatulky - vonkajsi rozmer - vnutorny rozmer 40mm je i2/i3/i4 sirka line karty +2x0.1 (spo)
boxHight=30;  // standartna vyska skatulky - vonkajsi rozmer
boxTick=2.0;  // hrubka steny skatulky - o ktory sa zmensuje priesto vo vnutri oproti vonkajsku
boxHinges=5;  // celkovy pocet pantov na skatulke - pocet na skatulke + na vrchnaku

// cabWidth cabDepth cabHight su celkove vonkajsie rozmery cabinetu
cabWidth=98;  // bw:celkova sirka Cabinetu = 44x2 (dva 19" routre vedla seba) + 3x2 (3x hrubka steny) + 4x1 (4x uchyt police) |. .|. .|
cabDepth=50;  // bd:40mm nech je hlbka i4 linekarty + 2x2mm (hrubka zadnej steny a prednych dveri) + 6mm manipulacneho priestoru v predu
cabHight=70;  // bh:lebo medved ... mozno to este bude treba doladit ..na 70mm sa nefixovat
cabTick=2.0;  // bt:hrubka stien a polic cabinetu
cabHinges=7;  // bn:pocet pantov na jednych dverach: 1pant na 1cm pri vonkajsej hrubke pantu 2mm a diere 1.1 pre ocelovy drot 0.6 je fajn
cabHolder=1;  // NEPOUZITY - Shelf Holder Tick - hrubka drziaka policiek - rozmer od steny do stredu skrine - vecne je to cabTick/2 -NEPOUZIT !!
cabLocked=true; // ci dvere maju, alebo nemaju zamok

lockWidth=2;  // sirka/hrubka kluca - pohyblivej casti zamku vo zvislej polohe = cabTick, cize by mal mat hrubku steny skrinky
lockDepth=4;  // hlbka kluca= hrubka dveri (cabTick=2mm) plus vyska precnievania nad opvrchom dveri (1-2mm)+wire/2 =polomer kruhu otocenia
lockHight=10; // vyska obdlznikoveho vyrezu pre kluc - kluc je v skutocnosti vyssi kvoli hrotom pre zadrzanie o prekazky (dnu i von)
lockTooth=7;  // vyska zuba, ktory sa vo vnutri cabinetu zachyti o dosku
lockHoles=2;  // vzdialenost dier od okraja bariery / od dveri

batWidth=9.0; // sirka baterie - celkovy rozmer / nic cez tento rozmer neprecnieva
batDepth=30;  // hlbha baterie - celkovy rozmer
batHight=15;  // vyska baterie - celkovy rozmer
batConto=2.0; // vonkajsi priemer kontaktu baterie, zaroved protinarazove zaoblenie hran baterie 
batConti=0.8; // diera v kontakte baterie pre vodic /0.6 ocelovy drot, zaroven hrbla priecok /dlhe riery musia byt 1.1, kretke mozno stacia 0.8
batFontS=4.0; // velkost fontu pre pisanie po baterii vratane znamienka plus a minus

dinBWidth=46;  // sirka DIN listy : polSkrinka - 2x stena - 2x spo ... alebo 19"(=44mm) + 2mm
dinBHight=2.0; // vyska DIN listy - je vlastne hrubka steny ... pouzivana ako bezna jednotka
dinBDepth=4.0; // hlbka DIN listy - mala by byt aspon polovicou vysky (teda aspon 1mm), ale inak je nepodstatne ...skor uchopitelna do ruky
dinFWidth=4.0; // sirka jedneho istica 1 fazoveho
dinFDepth=8.0; // celkova hlbka istica ... teoreticky nepodstatne ... na uchyt na istu treba jednu hrubku steny (2mm) a kruh 4mm+
dinFHight=6.0; // nech vyska istica je rovnaka ako hlbka


/* [Colors] */
colorBoxBody="#2020a0";  // farba skatulky
colorBoxCover="#a02020"; // farba deklika

colorCabBody="#2020a0";   // farba stien cabinetu
colorCabDoor="#a02020";   // farba dveri cabinetu
colorCabShelf="#20a020";  // farba polic a prepazok
colorCabHolder="#a0a020"; // farba drziakov polic 

colorBatBody="#c0c0c0";   // farba tela baterky
colorBatHand="#707070";   // farba drzadiel na bateriach
colorBatPlus="#a02020";   // farba znamienka plus
colorBatMinu="#2020a0";   // farba znamienka minus
colorBatU12V="#20a020";   // farba napisu 12V na baterii
colorBatElec="#101010";   // farba elektrod

colorDoorLock="#403020";   // farba pohyblivej casti zamku na dverach - kluca
colorDinBar="#909090";     // farba DIN listy ... teoreticky strieborna/matne siva/hlinikova
colorDinBreaker="#b0b0b0"; // farba tela istica
colorDinDriver="#b02020";  // farba packy istica

module hHinge(h=5,do=2.0,di=1.0) {  // dlzka pantu, vonkajsi priemer, primed diery pantu
// horizontalny pant - pre box/krabicu
// zakladna polona je taka, pri ktorej by sa drot pantu viedol vodorovne s osou X
// referencny bod pantu je predny lavy dolny roh.
    difference() {
    union() {
        translate([0,0,0])      // uchytna podstave tela pantu
            cube([h,do,do/2]);
        translate([0,do/2,do/2]) // valec pantu vonkajsi priemer
           rotate([0,90,0])
           cylinder(h=h-spi,d=do);
    } //uni
        translate([-1,do/2,do/2]) // diera pantu
           rotate([0,90,0])
           cylinder(h=h+2,d=di+spo);
    } // diff
}

module vHinge(h=5,do=2.0,di=1.0) {
// vertikalny pant ... taky isty ako hHinge, len aby netrebalo spekulovat s jeho otacanim, tak urobeny na vertikal
// h=dlzka pantu, do= vonkajsi priemer pantu (polomer valca, hrana hranola, hrubka steny boxu/cabinetu), di=priemer diery pre drot
// osvedcene parametre: h=10, do=2, di=1.0 (co je +spi (0.1) = 1.1mm - vhodne pre ocelovy drot 0.6mm)
// referencny bod: vlavo vpredu dole pod panto ... vlastne mimo pantu, pretoze je v rohu hranola vymedzujuceho rozmer pantu
    difference() {
    union() {
        translate([0,do/2,0])     // pokvader objemu
            cube([do,do/2,h]);
        translate([do/2,do/2,0])  // valec objemu
            cylinder(h=h-spi,d=do);
    } //uni objem pantu
        translate([do/2,do/2,-1])
            cylinder(h=h+2,d=di+spo);
    } //diff diera
}

module roCubeD(w=10,d=30,h=15,r=1) {
    union() {
    difference() {
        cube([w,d,h]); // hlavny kvader, z ktoreho rezeme
        
        translate([-1,-1,-1])   //lave predne orezanie - vertikalne obriezky
            cube([r+1,r+1,h+2]);
        translate([w-r,-1,-1])  // prave predne orezanie
            cube([r+1,r+1,h+2]);
        translate([-1,d-r,-1])  // lave zadne orezanie
            cube([r+1,r+1,h+2]);
        translate([w-r,d-r,-1])
            cube([r+1,r+1,h+2]);

        translate([-1,-1,-1])   // lave spodne orezanie - horizontalne obriezky
            cube([r+1,d+2,r+1]);
        translate([w-r,-1,-1])  // prave spodne orezanie 
            cube([r+1,d+2,r+1]);
        translate([-1,-1,-1])   // predne spodne obrezanie
            cube([w+2,r+1,r+1]);
        translate([-1,d-r,-1])  // zadne spodne obrezanie
            cube([w+2,r+1,r+1]);
           
    } // diff
        translate([r,r,r])   //lave predne orezanie - vertikalne obriezky
            cylinder(h=h-r,r=r);
        translate([w-r,r,r])  // prave predne orezanie
            cylinder(h=h-r,r=r);
        translate([r,d-r,r])  // lave zadne orezanie
            cylinder(h=h-r,r=r);
        translate([w-r,d-r,r])
            cylinder(h=h-r,r=r);

        translate([r,r,r])   // lave spodne valcove zaoblenie - horizontalne obriezky
            rotate([-90,0,0])
            cylinder(h=d-2*r,r=r);
        translate([w-r,r,r])  // prave spodne valcove zaoblenie 
            rotate([-90,0,0])
            cylinder(h=d-2*r,r=r);
        translate([r,r,r])   // predne spodne valcove zaoblenie
            rotate([0,90,0])
            cylinder(h=w-2*r,r=r);
        translate([r,d-r,r])  // zadne spodne valcove zaoblenie
            rotate([0,90,0])
            cylinder(h=w-2*r,r=r);

        translate([r,r,r])  // lave predne gulove zaoblenie
            sphere(r=r);
        translate([w-r,r,r]) // prave predne gulove zzoblenie
            sphere(r=r);
        translate([r,d-r,r]) // lave zadne gulove zaoblenie
            sphere(r=r);
        translate([w-r,d-r,r]) // prave zadne gulove zaoblenie
            sphere(r=r);
        
    } // union
}

module batery(bw=batWidth,bd=batDepth,bh=batHight,bo=batConto,bi=batConti,bf=batFontS) {
    union() {
    difference() {
        color(colorBatBody) // hlavny kvader baterie
        translate([0,0,0]) 
        //cube([bw,bd,bh]); // toto neskor zmenit za roudedBox
        roCubeD(w=bw,d=bd,h=bh,r=bi); // toto neskor zmenit za roudedBox

        color(colorBatBody)
        translate([bo,-1,bh-2*bo])
        cube([bw-2*bo,2*bo+1,2*bo+1]);  // predny vyrez na uchyt

        color(colorBatBody) 
        translate([bo,bd-2*bo,bh-2*bo]) 
        cube([bw-2*bo,2*bo+1,2*bo+1]); //zadny vyrez na uchyt

        color(colorBatBody)
        translate([-1,2*bo,bh-bo])
        cube([bw+2,bd-4*bo,bo+1]);  //vrchny vyrez na elektrody

        color(colorBatU12V)
        translate([bo,(bo-bi)/3,bh/4])
        rotate([90,0,0])
        linear_extrude((bo-bi)/3+1,convexity=4)
        text("12V",size=(bw-2*bo)/3,font="Arial Black"); //napis na baterii

    } //diff
        color(colorBatBody) {
        translate([0,2*bo,bh-bo])
        cube([bw,bi,bo]);       // predna priecka proti popaleniu / proti kontaktu ruky s elektrodami
        
        translate([bw/2-bi/2,2*bo,bh-bo])
        cube([bi,3*bo,bo]);    // lista medzi elektrodami

        translate([0,bd-2*bo-bi,bh-bo])
        cube([bw,bi,bo]);      // zadna priecka
        }

        color(colorBatHand) {
        translate([bo,bo/2,bh-bo/2])
        rotate([0,90,0])
        cylinder(h=bw-2*bo,d=bo); // predny uchyt - valcek za ktory sa baterka chyti do ruky

        translate([bo,bd-bo/2,bh-bo/2])
        rotate([0,90,0])
        cylinder(h=bw-2*bo,d=bo);  // zadny uchyt
        }

        color(colorBatElec) {
        difference() {   // lava elektroda - minus
            translate([bw/4,bo*4,bh-bo])
            cylinder(h=bo,d=bo);
            translate([bw/4,bo*3,bh-bo/2])
            rotate([-90,0,0])
            cylinder(h=2*bo,d=bi);
        }
        difference() {   // prava elektroda - plus
            translate([3*bw/4,bo*4,bh-bo])
            cylinder(h=bo,d=bo);
            translate([3*bw/4,bo*3,bh-bo/2])
            rotate([-90,0,0])
            cylinder(h=2*bo,d=bi);
        }
        } //elec

        translate([bw/4-bo/2,bo*5,bh-bo])
        color(colorBatPlus)    // znamienko + za kladnou elektrodou, pre jej oznacenie
        linear_extrude((bo-bi)/3)
        text("+",size=bo*2,font="arial");
        
        translate([bw/2,bo*5,bh-bo])
        color(colorBatMinu)    // znamienko + za kladnou elektrodou, pre jej oznacenie
        linear_extrude((bo-bi)/3)
        text("-",size=bo*3,font="arial");
        
    } //uni
}

module placeBatery(pos=0) {
    sp=((cabWidth-4*cabTick-3*cabTick)/2-4*batWidth)/5;  // medzera medzi baterkami = sirka polpriestoru v cabinete - sirka baterky /5
    //sp=0.9;
    echo(sp,"medzera medzi baterkami");
    y1=cabDepth-cabTick-batDepth-10;
    z1=cabTick+0.001;
    z2=13*cabTick+0.001;
    x1=cabWidth/2+2*cabTick+sp; echo(x1,"=x1");
    x2=x1+batWidth+sp;
    x3=x2+batWidth+sp;
    x4=x3+batWidth+sp;
    if(pos==1) { translate([x1,y1,z2]) batery(); }
    if(pos==2) { translate([x2,y1,z2]) batery(); }
    if(pos==3) { translate([x3,y1,z2]) batery(); }
    if(pos==4) { translate([x4,y1,z2]) batery(); }
    if(pos==5) { translate([x1,y1,z1]) batery(); }
    if(pos==6) { translate([x2,y1,z1]) batery(); }
    if(pos==7) { translate([x3,y1,z1]) batery(); }
    if(pos==8) { translate([x4,y1,z1]) batery(); }
}

module doorLock(dlw=lockWidth,dld=lockDepth,dlh=lockHight,dlt=lockTooth) {
// pohybliva suciastka zamku na dverach - skratene sa inde spomina ako "kluc zamku na dverach", alebo "kluc"
// s nepohyblivou castou zamku na dverach sa prepaja ocelovym drotom, najlepsie o priemere 0,6mm
// zakladna poloha je identicka s polohou vyrobnou, teda po leziacky pozdlzne s/za osou X
// do "basic" polohy sa umiestnuje pomocou placeDoorLock
// v celom texte sa predpoklada rovnaky rozmer zamku a dveram sa dava iba atribut lock=cabLocked, preto globalky miesto parametrov
// referencny bod je v strede kruhu otacania okolo drotu
    color(colorDoorLock)
    linear_extrude(dlw) {
        difference() {
        union() {
            circle(r=dld);
            polygon([[0,0],[0,lockDepth],[lockHight,lockDepth],[0,-lockDepth],[-lockTooth,-lockDepth]],[[0,1,2,0],[0,3,4,0]]);
        } //union
            circle(d=wire+spo);
        } // diff
    } // 2D lin_ex to 3D

}

module placeDoorLock(angle=angle,dlw=lockWidth,dld=lockDepth,dlh=lockHight,dlt=lockTooth) {
    rotate([-1*angle,0,0])  // 0=dvere zamknute 90=dvere odomknute
    rotate([90,90,-90])
    doorLock(dlw,dld,dlh,dlt);
}

module boxBody(bw=boxWidth,bd=boxDepth,bh=boxHight,bt=boxTick,bn=boxHinges) {
// bw-boxWidth, bd-boxDepth, bh-boxHight, bt-boxTick, bn-number of hinges
// zakladna poloha boxu je dnom na spodku a pantami k osi X
// referencny bod ja vlavo dole vpredu v zakladnej polohe rohovy bod
// bw,bd,bh - definuju vonkajsi rozmer boxu
    color(colorBoxBody)
    union() {
    difference() {
    translate([0,0,0])     // vonkajsi box, z ktoreho rezeme
        cube([bw,bd,bh-bt]); // pozor - od dvadra odpocitavame krubku dekla
    translate([bt,bt,bt])
        cube([bw-2*bt,bd-2*bt,bh-bt]);
    } //diff
    for(i=[0:(bw/bn)*2:bw-0.1]) {
        translate([i,0,bh-bt])
            hHinge(h=bw/bn,do=bt,di=wire); // medzery medzi fragmentami pantu si riesi pant
    } //i
    } //uni

}

module boxCover(bw=boxWidth,bd=boxDepth,bh=boxHight,bt=boxTick,bn=boxHinges) {
// zakladna poloha je lezmo s pantami vpredu na ose X
// referencny bod je za uplnom zaciatku dole pod lavym pantom
    color(colorBoxCover)
    union() {
    translate([0,bt,0])      //  doska dekla
        cube([bw,bd-bt,bt]);

    for(i=[bw/bn:(bw/bn)*2:bw-0.1]) { // prirabka pantov
        translate([i,bt,0])
        rotate([90,0,0])
        hHinge(h=bw/bn,do=bt,di=wire);  // medzery medzi fragmentami pantu si riesi pant
    } //i
    } // uni

}

module cabBody_empty(bw=cabWidth,bd=cabDepth,bh=cabHight,bt=cabTick,bn=cabHinges) {
// pevna cast cabinetu bez dveri, prepazok aj bez polic
// zakladna poloha je podstavou na podlahe X-Y a dverami vpredu
// v zakladnej polohe ak su dvere zatvorene, tak ani panty nepresahuju cez celnu rovinu X-Z
// referencny bod je na podlahe pod lavym pantom vpredu ...vlastne mimo cabinet.
// vo vyrobnej polohe bude treba cabinet otocit zadnou stenu na podlahu [-90,0,0] a zdihnut o hlbku cabinetu
    color(colorCabBody)
    union() {
    difference() { // vonkajsie steny cabinetu
        translate([0,bt,0])      // zakladny kvader, posunuty o vysku pantov (teda o hrubku steny)
            cube([bw,bd-bt,bh]); // aj zmenseny o panty/dvere
        translate([bt,0,bt])     // vyrez vnutorneho priestoru cabinetu
            cube([bw-2*bt,bd-bt,bh-2*bt]);
    } // diff zakladneho vnutorneho priestoru
    for(i=[0:2*bh/bn:bh-0.001]) { //panty
        translate([0,0,i])      //lavy pant
            vHinge(h=bh/bn,do=bt,di=wire);
        translate([bw-bt,0,i])  //pravy pant
            vHinge(h=bh/bn,do=bt,di=wire);
    } // cyklus pantov
    } // uni skrinky
}

module cabBody(bw=cabWidth,bd=cabDepth,bh=cabHight,bt=cabTick,bn=cabHinges) {
// pevna cast cabinetu bez dveri, prepazok aj bez polic
// zakladna poloha je podstavou na podlahe X-Y a dverami vpredu
// v zakladnej polohe ak su dvere zatvorene, tak ani panty nepresahuju cez celnu rovinu X-Z
// referencny bod je na podlahe pod lavym pantom vpredu ...vlastne mimo cabinet.
// vo vyrobnej polohe bude treba cabinet otocit zadnou stenu na podlahu [-90,0,0] a zdihnut o hlbku cabinetu
    union() {
    color(colorCabBody)
    difference() { // vonkajsie steny cabinetu
        translate([0,bt,0])      // zakladny kvader, posunuty o vysku pantov (teda o hrubku steny)
            cube([bw,bd-bt,bh]); // aj zmenseny o panty/dvere
        translate([bt,0,bt])     // vyrez vnutorneho priestoru cabinetu
            cube([bw-2*bt,bd-bt,bh-2*bt]);
    } // diff zakladneho vnutorneho priestoru
    color(colorCabBody)
    for(i=[0:2*bh/bn:bh-0.001]) { //panty
        translate([0,0,i])      //lavy pant
            vHinge(h=bh/bn,do=bt,di=wire);
        translate([bw-bt,0,i])  //pravy pant
            vHinge(h=bh/bn,do=bt,di=wire);
    } // cyklus pantov
    color(colorCabHolder)
    for(i=[bt:2*bt:bh-bt-0.001]) {
        translate([bt/2,bt+0.001,i])   // lava strana
            cube([bt,bd-bt-0.002,bt-spo]);
        translate([bw-3*bt/2,bt+0.001,i])  //prava strana
            cube([bt,bd-bt-0.002,bt-spo]);
    } // drziaky polic po oboch stranach
    color(colorCabHolder) { // vertikalne drziaky prepazky
        translate([bw/2-bt-bt,bt+0.001,bt/2]) // lavy dolny
            cube([bt-spo,bd-bt-0.002,bt]);
        translate([bw/2+bt,bt+0.001,bt/2]) // pravy dolny
            cube([bt-spo,bd-bt-0.002,bt]);
        translate([bw/2-bt-bt,bt+0.001,bh-3*bt/2]) // lavy horny
            cube([bt-spo,bd-bt-0.002,bt]);
        translate([bw/2+bt,bt+0.001,bh-3*bt/2]) // pravy horny
            cube([bt-spo,bd-bt-0.002,bt]);
    } // vertikalne drziaky strednej prepazky
    } // uni skrinky
}

module cabBarier(bw=cabWidth,bd=cabDepth,bh=cabHight,bt=cabTick,bn=cabHinges) { // prepazka v cabinete
// umiestnuje sa iba na jednu poziciu ... budis rieseno funkciou placeCabBarier()
// referencny bod je dole vpredu vlavo na zemi - je na urovni dveri cabinetu, teda mimo dosku samotnej prepazky
// posun referencneho bodu je prisposobeny drziakom policiek, aby boli rovnako ako u skrinky
    color(colorCabShelf)
    translate([bt/2,bt,bt])
        difference() {
        cube([bt,bd-bt-0.002,bh-2*bt-2*spi]); // hlavna doska bariery
        for(i=[1.5*bt:2*bt:bh-2*bt-3*spi]) { // dierky pre drotenu zachytu kluca zamku na dverach
            translate([bt/2-2.5*bt,lockHoles,i])
            rotate([0,90,0])
            cylinder(h=5*bt,d=wire+spi);
        } //for
        } //diff
    color(colorCabHolder)    //drziaky na police
    for(i=[bt:2*bt:bh-bt-0.001]) {
        translate([0+spi,bt+0.001,i])   // lava strana
            cube([bt,bd-bt-0.002,bt-spo]);
        translate([bt,bt+0.001,i])   // lava strana
            cube([bt-spi,bd-bt-0.002,bt-spo]);
    } // drziaky polic po oboch stranach prepazky
}
module placeCabBarier(bw=cabWidth,bd=cabDepth,bh=cabHight,bt=cabTick,bn=cabHinges) { // umiestnenie prepazky do cabinetu
    translate([bw/2-bt,0,0])
        cabBarier(bw,bd,bh,bt,bn);
}

module cabShelf(bw=cabWidth,bd=cabDepth,bh=cabHight,bt=cabTick,bn=cabHinges)  { // polica do cabinetu
// jej zakladna poloha je vodorovna, identicka s vyrobnou
// referencny bod je vpredu vlavo dole, na urovni povrchu dveri ... teda mimo dosky
    xt=bt/4; // 1/4 hrubky steny cabinetu - referencny rozmer pre velkost a umiestnenie upinacej ryhy (mozno uchytit istice)
    // upinacia ryha by mala stacit na jednej strane police a iba na vrchu, ale ... ktora strana je vrchna ??? :-)
    bbd=bd*8/10-2*bt-2*spi; // hlbka police
    bbw=bw/2-3*bt/2-2*spi;  // sirka police

    color(colorCabShelf)
    translate([0,bt,0])
    difference() {
        cube([bbw,bbd,bt-2*spi]); // zakladna doska police
        translate([-1,xt,bt-xt])  // predna horna ryha
            cube([bbw+2,xt,xt+1]);
        translate([-1,bbd-2*xt,bt-xt]) // zadna horna ryha
            cube([bbw+2,xt,xt+1]);
        translate([-1,xt,-1])          // predna spodna ryha
            cube([bbw+2,xt,xt+1]);
        translate([-1,bbd-2*xt,-1]) // zadna spodna ryha
            cube([bbw+2,xt,xt+1]);
    } //diff
}

module placeCabShelf(po=0,bw=cabWidth,bd=cabDepth,bh=cabHight,bt=cabTick,bn=cabHinges) { // polica umiestnena do cabinetu na poziciu 1/2/3/4
// vsetko sa zachovava
// po - je pozicia umiestnenia do cabinetu
    x1=bt+spi/2;
    x2=bw/2+bt/2+spi/2;
    z1=6*2*cabTick;
    z2=12*2*cabTick;
    y1=bd*1/10;

    if(po==1) {
        color(colorCabShelf)
            translate([x1,y1,z2])
            cabShelf(bw,bd,bh,bt,bn);
    }
    if(po==2) {
        color(colorCabShelf)
            translate([x2,y1,z2])
            cabShelf(bw,bd,bh,bt,bn);
    }
    if(po==3) {
        color(colorCabShelf)
            translate([x1,y1,z1])
            cabShelf(bw,bd,bh,bt,bn);
    }
    if(po==4) {
        color(colorCabShelf)
            translate([x2,y1,z1])
            cabShelf(bw,bd,bh,bt,bn);
    }
}

module cabDoorLeft(bw=cabWidth,bd=cabDepth,bh=cabHight,bt=cabTick,bn=cabHinges,lock=cabLocked) {
// lave dvere, na lavej strane majuce panty
// zakladna poloha je spodnou hranou leziace na ose X
// referencny bod je vlavo dole vpredu, rovnako na pevnej casti cabinetu
// otvaranie a zatvaranie dveri uhlom ... zabezpecit osobitnym modulo openCabDoorLeft s jednym pridanym parametrom (angle)
// tento modul obsahuje len pevnu casti dveri ... bez pohyblivej, teda bez zamku na dverach
// ak je lock=false, tak sa vyrez ani ostatne pevne casti zamku nezobrazuju
    color(colorCabDoor)
    union() {
    if(lock) {
        difference() {
            translate([bt,0,0])  // hlavna doska dveri s vyrezom pre zamok
            cube([bw/2-bt,bt,bh]);

            translate([bw/2-3*lockWidth-spo,-1,bh/2-lockHight/2-spo]) // vyrez
            cube([lockWidth+2*spo,bt+2,lockHight+lockDepth/2+2*spo]);
        }
    } else {
        translate([bt,0,0])  // hlavna doska dveri ak ich robime bez vyrezov
        cube([bw/2-bt,bt,bh]);
    } // hlavna doska dveri
    for(i=[bh/bn:2*bh/bn:bh-0.001]) { // jednotlive panty
        translate([0,bt,i])     // Y=bt je korekcia po rotacii
        rotate([0,0,-90])
        vHinge(h=bh/bn,do=bt,di=wire);
    } //i
    if(lock) {  // pevna cast zamku na lavych dverach
        difference() {
        translate([bw/2-4*lockWidth-spo,bt,bh/2])   // zakladny hranol v zadu na dverach, do ktoreho ideme rezat
        cube([3*lockWidth,3*wire,lockHight/2]);
        
        translate([bw/2-4*lockWidth-spo-1,bt+wire/2,bh/2+lockHight/2-lockDepth/2]) // valcovy vyrez diery pre drot, ktory umozni pohyb zamku
        rotate([0,90,0])
        cylinder(h=3*lockWidth+2,d=wire+spi);

        translate([bw/2-3*lockWidth-spo,-lockDepth,bh/2-lockHight/2-spo])  // vyrezanie strednej medzery pre pohyblivu cast zamku
        cube([lockWidth,3*lockDepth,lockHight+2*spo]);                     // toto vyrezanie kopiruje dieru v zakladnej doske dveri
        }
    }
    } // uni teleso dveri
}

module openCabDoorLeft(angle=0,bw=cabWidth,bd=cabDepth,bh=cabHight,bt=cabTick,bn=cabHinges,lock=cabLocked,ba=angleLockLeft) {
// lave dvere s otocenim
// zachovava povodny referencny bod
// akurat parametrom angle zabezpecuje otvorenie dveri
// cize dvere sa posunu aby os otocenie bola vstrede diery pantu na zemi
// nasledne sa dvere otocia ololo vertikaly - osy Z
// a potom sa urobi spatny posun do vychodzieho referencneho bodu
    translate([bt/2,bt/2,0])
    rotate([0,0,0-angle])
    translate([-bt/2,-bt/2,0]) {
        cabDoorLeft(bw,bd,bh,bt,bn);
        if(lock==true) {  // pohybliva cast zamku/kluc ... ak je definovana
            translate([bw/2-2*lockWidth,bt+wire/2,bh/2+lockHight/2-lockDepth/2]) 
            placeDoorLock(ba);
        }
    }
}

module cabDoorRight(bw=cabWidth,bd=cabDepth,bh=cabHight,bt=cabTick,bn=cabHinges,lock=cabLocked) {
// prave dvere, na prave stane maju panty
// referencny bod je v pravom dolnom prednom rohu hranola cabinetu, alebo aj dveri, na zemi pod spodnym pantom ...
// pre otvaranie/otacanie dveri treba vytvorit osobitnu funkciu openCabDoorRight, doplnenu o uhol otocenia dveri
// dvere sa do cabinetu umiestnuju na poziciu [bw,0,0].
    color(colorCabDoor)
    union() {
    if(lock) {
        difference() {
            translate([-bw/2,0,0]) // zakladna doska dveri s vyrezom pre zamok
            cube([bw/2-bt,bt,bh]);

            translate([-bw/2+2*lockWidth-spo,-1,bh/2-lockHight/2-spo])
            cube([lockWidth+2*spo,bt+2,lockHight+lockDepth/2+2*spo]);
        }
    } else {
        translate([-bw/2,0,0])     // zakladna doska dveri ak robi dvere bez zamku (bez vyrezu)
        cube([bw/2-bt,bt,bh]);
    }
    for(i=[bh/bn:2*bh/bn:bh-0.001]) {
        translate([0,0,i])
        rotate([0,0,90])
        vHinge(h=bh/bn,do=bt,di=wire);
    } //i
    if(lock) {
        difference() {
        translate([-bw/2+1*lockWidth-spo,bt,bh/2])
        cube([3*lockWidth,3*wire,lockHight/2]);
        
        translate([-bw/2+1*lockWidth-spo-1,bt+wire/2,bh/2+lockHight/2-lockDepth/2])
        rotate([0,90,0])
        cylinder(h=3*lockWidth+2,d=wire+spi);

        translate([-bw/2+2*lockWidth-spo,-lockDepth,bh/2-lockHight/2-spo])
        cube([lockWidth,3*lockDepth,lockHight+2*spo]);
        }
    }
    } // uni teleso dveri
}

module openCabDoorRight(angle=0,bw=cabWidth,bd=cabDepth,bh=cabHight,bt=cabTick,bn=cabHinges,lock=cabLocked,ba=angleLockRight) {
// prave dvere s otocenim
// zachovavaju povodny referencny bod
// iba sa posunu, aby otacanie sa dialo okolo osi Z a po otoceni sa vykona spatna korecia, aby dvere drzali v pantoch
    translate([-bt/2,bt/2,0])
    rotate([0,0,angle])
    translate([bt/2,-bt/2,0]) {
        cabDoorRight(bw,bd,bh,bt,bn);
        if(lock==true) {
            translate([-bw/2+3*lockWidth,bt+wire/2,bh/2+lockHight/2-lockDepth/2])
            placeDoorLock(ba);
        }
    }
}

module dinBar() {
// DIN lista na sirku 19" ... teda 44mm + uchyty.
// bude umiestnena na spodok do lavej casti cabinetu
// referencny bod je vlavo, dole vpredu ...kazdy rozmer je az tu zmenseny o SPI, takze bod je malilinko mimo predmet
    xd=dinBHight;   // vyska DIN listy
    xt=dinBHight/4; // stvrtina vysky DIN listy ... pre vyrobenie zachytneho zarezu

    color(colorDinBar)
    rotate([0,90,0])
    linear_extrude(dinBWidth-2*spi)
    polygon([[0,0],[-xd,0],[-xd,xt],[-xd+xt,xt],[-xd+xt,2*xt],[-xd,2*xt],[-xd,dinBDepth],[0,dinBDepth]],
            [[0,1,2,3,4,5,6,7,0]]);

}



module dinBreakerBody() {
// prudovy istic - circuit breaker - FA
// jeho sirka je jednotkova dinFWidth
// referencny bod je vlavo dole vpredu v rohu krabicky ...paka istica precnieva
// parametrom je iba uhol sklopenia packy istica ... ostatne sa berie z globalok
// tu je zakladna poloha lezmo na lavom boku, podstavou na ose X
// pracovna poloha je ovsem normalne vo zvislej polohe
// vyrobna poloha je zachytnymi zubami na podlozke / packou hore
// packa sa robi separatne a pohyblivy spoj sa robi drotom
    dx=dinFHight-2; // priemer kruhu packy istica
    wx=dinFWidth/2; // sirka packy istica
    tx=cabTick/4;   // referencny rozmer pre uchytny zarez na DIN liste

    color(colorDinBreaker)
    difference() {
    union() {
        cube([dinFWidth,dinFDepth,dinFHight]); // zakladny hranol v k ktorom je vyrez na kruhovu packu
        translate([-0,dinFDepth/3,-dinFHight/4])  // zadna pridavna cast hranolu na uchytavacie diery a dieru pre drot
            cube([dinFWidth,dinFDepth/3*2,dinFHight/4*6]);
    }
    translate([dinFWidth/4,dx/2,dinFHight/2])  // velky polkruhovy vyrez na packu 
        rotate([0,90,0])
        cylinder(h=wx+2*spo,d=dx+spo);
    translate([dinFWidth/4,-1,1])  // velky polkruhovy vyrez na packu - hranate dorovnanie 
        cube([wx+2*spo,dx/2+1,dx]);

    //translate([-1,dx/2,dinFHight/2])          // okruhla dierka na drot (staci but tato okruhla, alebo hranata nizsie)
    //    rotate([0,90,0])
    //    cylinder(h=dinFWidth+2,d=wire+2*spi);

    translate([-1,dx/2-(wire/2+spo),dinFHight/2-2*wire]) // hranata dierka na drot, ktory z oboch stran zahneme, aby nevypadol
        cube([dinFWidth+2,wire+2*spo,3*wire]);

    translate([dinFWidth/2,dinFDepth/8*5,-1-dinFHight/4]) // vertikalna diera na drot ... na fazovy vodic
        cylinder(h=dinFHight/4*6+2,d=wire+spo);

    translate([dinFWidth/2,-1,dinFHight/8*9])  // vrchna dierka na uchytnu skrutku, ktora pridrziava fazovy vodic
        rotate([-90,0,0])
        cylinder(h=dinFDepth/8*5,d=wire*5/8);

    translate([dinFWidth/2,-1,-dinFHight/8*1])  // spodna dierka na uchytnu skrutku, ktora pridrziava fazovy vodic
        rotate([-90,0,0])
        cylinder(h=dinFDepth/8*5,d=wire*5/8);
   
    qx=(dinFHight)/2;          // horizontalny stred istica
    qd=(dinBHight+tx+2*spo)/2; // polovica hrubky DIN listy ... pre vyrez, cize pripocitavame 1*tx aby bolo mozne istic zalozit
    translate([-1,dinFDepth-2*tx,0])
        rotate([0,90,0])
        linear_extrude(dinFWidth+2,convexity=2)
        polygon([[-qx+qd,2*tx+0.001],      // zadny dolny bod
                 [-qx+qd,0],               // predny dolny bod
                 [-qx-qd,0],               // predny horny bod
                 [-qx-qd,tx+spo],          // horny predny bod hrotu (rohovy v pravom uhle)
                 [-qx-qd+tx,tx+spo],       // spodny bod hrotu (ostry)
                 [-qx-qd,2*tx+0.001]],     // zadny horny bod (horny zadny bod hrotu)
                 [[0,1,2,3,4,5]]); // vyrez, ktorym sa istic uchytava na DIN listu ... 0,0 je spodok a ide sa do -X

    } //diff
    
}

module dinBreakerKey(angle=angleF1) {
// pohybliva cast istica - kluc
// referencny bod ma tam, kde pevna cast istica (Body)
// referencny bod je teda vpredu vlavo dole v rohu Body.
    dx=dinFHight-2; // priemer kruhu packy istica
    wx=dinFWidth/2; // sirka packy istica

    translate([dinFWidth/4+spi+spo,dx/2,dinFHight/2])  // kruh s packou ... pohybliva cast istica 
        rotate([0,90,0])
        rotate([0,0,angle])
        color(colorDinDriver)
        difference() {
        union() {
            cylinder(h=wx-2*spi,d=dx+spo);  // velky kruh
            translate([-0.5,-dx,0])         // packa
            cube([1,dx,wx-2*spi]);
        } //uni
            translate([0,0,-1])
            cylinder(h=wx+2,d=wire+2*spi);    // diera pre drot v kruhu pohyblivej casti
        } //diff
}

module placeDinBreaker(angle=angleF1) {
    // place meni referencny bod. 
    // referencny bod je pri umiestnovani lavy dolny zadny bod vyrezu pre upevnenie na DIN listu
    tx=cabTick/4;   // referencny rozmer pre uchytny zarez na DIN liste
    qx=(dinFHight)/2;          // horizontalny stred istica
    qd=(dinBHight+tx+2*spo)/2; // polovica hrubky DIN listy ... pre vyrez, cize pripocitavame 1*tx aby bolo mozne istic zalozit
    translate([0,-dinFDepth,-qx+qd]) {
        dinBreakerBody();
        dinBreakerKey(angle);
    }
}

module manuf1DinBreaker() {
// umiestni casti istica na plate tak, aby ich bolo mozne vyrobit
// dinFWidth dinFDepth dinFHight
// delo istica je chrbatom polozene na podlozke
    wx=dinFWidth/2; // sirka packy istica
    translate([0,0,dinFHight*4/3]) 
        rotate([-90,0,0])
        dinBreakerBody();
    translate([1*dinFWidth,0,1.5*wx]) 
        rotate([0,90,0])
        dinBreakerKey(0);
}

module manuf2DinBreaker() {
// umiestni casti istica na plate tak, aby ich bolo mozne vyrobit
// dinFWidth dinFDepth dinFHight
// telo istica lezi na podlozke na boku
    wx=dinFWidth/2; // sirka packy istica
    translate([dinFWidth,0,dinFWidth]) 
        rotate([-90,90,0])
        dinBreakerBody();
    translate([1*dinFWidth,0,1.5*wx]) 
        rotate([0,90,0])
        dinBreakerKey(0);
}

/* [Previews] */
if(preview=="cabBasic") {
    //color(colorCabBody)
    translate([0,0,0])
    cabBody();
    //color(colorCabDoor)
    openCabDoorLeft(angleDoorLeft);
    //color(colorCabDoor)
    translate([cabWidth,0,0])
    openCabDoorRight(angleDoorRight);
    placeCabBarier();
    placeCabShelf(po=1);
    placeCabShelf(po=2);
    placeCabShelf(po=3);
    placeCabShelf(po=4);

    placeBatery(1);
    placeBatery(2);
    placeBatery(3);
    placeBatery(4);
    placeBatery(5);
    placeBatery(6);
    placeBatery(7);
    placeBatery(8);

    translate([cabTick,cabTick*6,cabTick*4])
        dinBar();

    fx=dinFWidth+spo;
    translate([cabTick+xxF1+cabTick/2+spo,cabTick*6-yyF1+(dinBHight/2),cabTick*4-zzF1]) {
        translate([0*fx,0,0]) placeDinBreaker(angleF1);
        translate([1*fx,0,0]) placeDinBreaker(angleF2);
        translate([2*fx,0,0]) placeDinBreaker(angleF3);
    }
}
if(preview=="cabPlate") {
    rotate([-90,0,0])     // skrinka
    translate([0,-cabDepth,0])
    cabBody(); // skrinka

    translate([0,2*cabHight+spp,cabTick])
    rotate([90,0,0])
    cabDoorLeft();        // lave dvere

    translate([cabWidth+spp,2*cabHight+spp,cabTick])
    rotate([90,0,0])
    cabDoorRight();       // prave dvere

    x31=0;
    translate([x31,2*cabHight+2*spp,2*cabTick])
    rotate([0,90,0])
    cabBarier();          // prepazka
    x32=x31+cabHight-2*cabTick+spp;

    translate([x32,2*cabHight+2*spp,2*cabTick])
    cabShelf();          // police 4x
    x33=x32+cabWidth/2-3*cabTick/2+spp; 

    translate([x33,2*cabHight+2*spp,2*cabTick])
    cabShelf();
    x34=x33+cabWidth/2-3*cabTick/2+spp; 

    translate([x34,2*cabHight+2*spp,2*cabTick])
    cabShelf();
    x35=x34+cabWidth/2-3*cabTick/2+spp; 

    translate([x35,2*cabHight+2*spp,2*cabTick])
    cabShelf();

    x21=cabWidth+2*spp;           // vsetky baterie
    x22=x21+batWidth+spp;
    x23=x22+batWidth+spp;
    x24=x23+batWidth+spp;
    x25=x24+batWidth+spp;
    x26=x25+batWidth+spp;
    x27=x26+batWidth+spp;
    x28=x27+batWidth+spp;
    y21=2*cabHight+spp-batDepth;
    translate([x21,y21,0]) batery();
    translate([x22,y21,0]) batery();
    translate([x23,y21,0]) batery();
    translate([x24,y21,0]) batery();
    translate([x25,y21,0]) batery();
    translate([x26,y21,0]) batery();
    translate([x27,y21,0]) batery();
    translate([x28,y21,0]) batery();

    y22=y21-lockHight; // pohyblive kluce
    translate([x21,y22,0]) doorLock();
    y23=y22-lockHight;
    translate([x21,y23,0]) doorLock();
    y24=y23-lockHight;
    translate([x21,y24,0]) doorLock();

    translate([x22,y22,0]) dinBar();
    translate([x22,y23,0]) dinBar();
    translate([x22,y24,0]) dinBar();

    for(i=[0:1:4]) {
        translate([x25+i*4*dinFWidth,y22,0]) manuf1DinBreaker(); // FA na stojato
        translate([x25+i*4*dinFWidth,y23,0]) manuf2DinBreaker(); // FA na lezato
    }
}

if(preview=="cabShelfs") { // len police a prepazky z vnutra cabinetu
    //color(colorCabDoor)
    openCabDoorLeft(angleDoorLeft);
    //color(colorCabDoor)
    translate([cabWidth,0,0])
    openCabDoorRight(angleDoorRight);
    placeCabBarier();
    placeCabShelf(po=1);
    placeCabShelf(po=2);
    placeCabShelf(po=3);
    placeCabShelf(po=4);

    placeBatery(1);
    placeBatery(2);
    placeBatery(3);
    placeBatery(4);
    placeBatery(5);
    placeBatery(6);
    placeBatery(7);
    placeBatery(8);
}
if(preview=="boxBasic") {    // zakladna pozicia zlozenej bednicky/krabicky...
    //color(colorBoxBody)   // umoznuje odklapanie a zaklapanie deklika na krabicke
    translate([0,0,0])
    boxBody();
    
    //color(colorBoxCover)
    translate([0,0,boxHight-boxTick])
    translate([0,+boxTick/2,+boxTick/2]) // spatna korekcia vrchnaku po otoceni s nulou na povodnom mieste v zakladnej pozicii
    rotate([angle,0,0])                  // stredom pre otacanie je stred podstavy valca pantu, osa otacanie je po vyske pantu
    translate([0,-boxTick/2,-boxTick/2]) // dopredna korekcia vrchnaku na os otacania
    boxCover();

}
if(preview=="boxPlate") {
    //color(colorBoxBody)    // telo krabice
    translate([0,0,0])
    boxBody(boxWidth,boxDepth,boxHight,boxTick,boxHinges);

    //color(colorBoxCover)   // vrchnak na krabicu
    translate([boxWidth+spp,0,0])
    boxCover(boxWidth,boxDepth,boxHight,boxTick,boxHinges);

}
if(preview=="hinges") {     // len jeden pant v zakladnej polohe
    color(colorBoxBody)
        hHinge();
    color(colorBoxBody)
        translate([boxTick+spp,0,0])
        vHinge();
}
if(preview=="roCubeD") {
    color(colorBoxBody)
        roCubeD(w=10,d=30,h=15,r=1);
}
if(preview=="batery") {
    translate([0,0,0])
        batery();
}
if(preview=="doorLock") {
    translate([0,0,0])
        doorLock();
    translate([20,0,10])
        placeDoorLock(angle);
}
if(preview=="electric") {
    dinBar();
    tx=dinBHight/4;
    translate([0*(dinFWidth+spo)+xxF1,2*tx-yyF1,-zzF1])   // pracovne istice FA1, FA2, FA3
        placeDinBreaker(angleF1);
    translate([1*(dinFWidth+spo)+xxF1,2*tx-yyF1,-zzF1])
        placeDinBreaker(angleF2);
    translate([2*(dinFWidth+spo)+xxF1,2*tx-yyF1,-zzF1])
        placeDinBreaker(angleF3);

    translate([50,0,10])
        placeDinBreaker();  // cely istic zlozeny v pracovnej polohe
    translate([60,0,10])
        dinBreakerKey();    // len pohybliva cast
    translate([70,0,10])
        dinBreakerBody();   // len pevna cast

    translate([90,0,0])     // vyrobna poloha vsetkych dielov istica
        manuf1DinBreaker();
    translate([110,0,0])     // vyrobna poloha vsetkych dielov istica
        manuf2DinBreaker();
}

if(preview=="electricPlate") {
    x25=spp; y22=2*dinFHight+spp; y23=spp; y21=3*spp;
    for(i=[0:1:4]) {
        translate([x25,y21+i*(dinBDepth+5),0]) dinBar();
    }
    for(i=[0:1:4]) {
        translate([x25+i*4*dinFWidth,y22,0]) manuf1DinBreaker(); // FA na stojato
        translate([x25+i*4*dinFWidth,y23,0]) manuf2DinBreaker(); // FA na lezato
    }
}
if(preview=="boxBody") {   // len krabica bez vrchnaku
    //color(colorBoxBody)
    translate([0,0,0])
        boxBody();
}
if(preview=="boxCover") {  // len vrchnak
    //color(colorBoxCover)
    translate([0,0,0])
        boxCover();

}
if(preview=="cabBody") { // len pevna cast skrinky dokonca aj bez policiek a prepazok
    //color(colorCabBody)
    cabBody();
}
if(preview=="cabDoors") { // lave aj prave dvere
    //color(colorCabDoor)
    openCabDoorLeft(angleLeft);
    //color(colorCabDoor)
    translate([cabWidth,0,0])
    openCabDoorRight(angleRight);
}
