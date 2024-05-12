$fn=25;
big_e = 0.3;

h=11;
h2=6;
d=10;
d2=d+4;
d_cube=2*h;
thickness = 2.5;
pin_d = 3;
pin_offset = h-2*thickness-pin_d;

//camlock();
camlock_housing();

/*
difference(){
    rotate([0,0,0])color("red")camlock();
    translate([-15,-15,0])cube(30);
}
//translate([10,0,0,])
color("green"){
    difference(){
        translate([0,0,big_e*1.5])camlock_housing();
        //translate([-10,-30,-15])cube(30);
    }
}

*/
module camlock(){
    difference(){
        union(){
            cylinder(h=h, d=d, center=true);
            //translate([0,0,h/2+h2/2])cylinder(h=h2, d=d2, center=true);
            translate([0,0,h/2])linear_extrude(height=h2, scale=[1.5, 0.7])circle(d=d2);
        }
        translate([-pin_d/2,-d_cube/2,-h/2+pin_offset])cube([d_cube,d_cube,pin_d]);
        translate([-d_cube/2,-pin_d/2,-d_cube-h/2+pin_offset+pin_d])cube(d_cube);
    }
}

module camlock_housing(){
    h_cylinder = h-2*thickness+big_e*2;
    h_cube = h_cylinder; //+pin_d/2;
    difference(){
        translate([0,0,-h_cube/2])cube([d2,d2,h_cube], center=true);
        translate([0,0,-h_cylinder/2])cylinder(d=d+big_e,h=h_cylinder+big_e, center=true);
    }
    translate([0,0,-pin_d/2+big_e/2])cube([pin_d-big_e, d+2*big_e, pin_d-big_e], center=true);
}