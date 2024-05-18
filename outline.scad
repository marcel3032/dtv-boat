$fn=250;

cube([100,2,2]);
/*
intersection(){
    outline();
    c = 500;
    translate([0,-c/2,0])cube([c,c,c], center=true);
}
module outline(){
    translate([0,50,0])
        difference(){
            out();
            in();
        }
}

module in(){
    d=112;
    translate([0,0,0])cylinder(h=2.1,d=d, center=true);
    w = 248-d/2;
    translate([0,-w/2,0])cube([d,w,2.1], center=true);
}

module out(){
    o = 4;
    d=112+o;
    translate([0,0,0])cylinder(h=2,d=d, center=true);
    w = 248-d/2+o;
    translate([0,-w/2,0])cube([d,w,2], center=true);
}*/