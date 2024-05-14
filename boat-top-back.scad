depth = 74;
boat_width = 110;
oversize = 7;
thickness = 2.8;
pipe_distance = 10;
pipe_d = 5.75;
screw_d = 3.5;
lock_side_offset = 5;
overisze_front = 30;

size = 4;
lock_width = 12;
lock_length = 5;

camlock_d=12;

big_eps = 0.5;

$fn=50;

//rotate([0,180,0])
translate([0,0,4])
back_cover_base();

module back_cover_base(){
    difference() {
        union(){
            translate([0,0,-thickness/2])cube([depth,boat_width,thickness],center=true);
            color("#a88132")translate([oversize/2,0,thickness/2])cube([depth+oversize,boat_width+2*oversize,thickness],center=true);
            color("green")translate([-depth/2-overisze_front,-boat_width/2-oversize,0])cube([overisze_front,boat_width+2*oversize,thickness]);
            color("blue")translate([-depth/2-2/3*overisze_front,-30/2,-thickness])cube([2/3*overisze_front,30,thickness]);
        }
        translate([-depth/2-15,+pipe_distance/2,0]) rotate([0,0,0]) cylinder(h=thickness*10,d=pipe_d, center=true);
        translate([-depth/2-15,-pipe_distance/2,0]) rotate([0,0,0]) cylinder(h=thickness*10,d=pipe_d, center=true);
        
        translate([-depth/2+8,+(boat_width/2-camlock_d/2-1),0]) rotate([0,0,0]) cylinder(h=thickness*10,d=camlock_d, center=true);
        translate([-depth/2+8,-(boat_width/2-camlock_d/2-1),0]) rotate([0,0,0]) cylinder(h=thickness*10,d=camlock_d, center=true);
        /*
        translate([0,-boat_width/2+lock_side_offset,-thickness-size/2])
            color("red")lock_hole();
        translate([0,-(-boat_width/2+lock_side_offset),-thickness-size/2])
            lock_hole();
        */
    }
}

/*
module lock(){
        translate([0,lock_length+size,0]) rotate([0,90,0])
                cylinder(h=lock_width+size, d=size-big_eps, center=true);
        length = lock_length+lock_side_offset+10;
        translate([0,-length/2+lock_length+size,0])
            difference() {
                cube([lock_width-size-big_eps, length, size-big_eps], center=true);
                translate([0,-length/2-size+1,-size]) rotate([20,0,0])
                        cube(10, center=true);
                lock_hole();
            }
}

module lock_hole(){
        cylinder(h=thickness*10,d=screw_d, center=true);
}

module lock_holder(){
        translate([lock_width/2,lock_length,0])cube(size, center=true);
        translate([-lock_width/2,lock_length,0])cube(size, center=true);
        translate([0,2*size+lock_length,0])cube([lock_width+size,size,size], center=true);
}
*/