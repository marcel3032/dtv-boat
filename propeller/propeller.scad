use <blade.scad>

$fa = 1;
$fs = 0.4;
precision = 2;

blades = 4;
shaft_out_d = 7;
shaft_inn_d = 4;
center_len = 12;
center_slot_w = 3;
center_slot_d = 3;
radius=20;
pitch=12;
m=2;
p=4;
t=12;
eps=0.01;

difference() {
    union() {
        for (b=[0:1:blades]) {
            translate([0,1,0])
                rotate([0,b*360/blades,0])
                    prop_blade(radius=radius, pitch=pitch, m=m, p=p, t=t, pathstep=1/precision, foil_points = 20*precision);
        }

        translate([0,-center_len+4,0])
            rotate([0,90,90])
                cylinder(center_len-1,shaft_out_d/2,shaft_out_d/2);
    };
    
    translate([0,-center_len+4,0])
        rotate([0,90,90])
            cylinder(2*center_len+1,shaft_inn_d/2,shaft_inn_d/2, center=true);
    
    
    translate([0,-center_len+4+center_slot_d/2-eps,0])
        rotate([0,90,90])
            cube([shaft_out_d/2*2+1, center_slot_w, center_slot_d+eps], center=true);
}
