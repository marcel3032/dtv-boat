use <boat.scad>;

depth = 74;
boat_width = 110;
oversize = 7;
thickness = 2.5;
pipe_distance = 10;
pipe_d = 5.75;
screw_d = 3.5;
lock_side_offset = 5;

size = 4;
lock_width = 12;
lock_length = 5;

camlock_d=12;

big_eps = 0.5;

$fn=50;

d = 12;

translate([0,0,thickness]) oversized_top();
linear_extrude(thickness) 2d_front();
intersection(){
    translate([175,0,-thickness/2]) cube([20,oversize*2,thickness], center=true);
    translate([0,0,-thickness]) oversized_top();
}
translate([-5,0,thickness/2])cube([10, boat_width, thickness], center=true);

module oversized_top(){
    linear_extrude(thickness) scale([(175+oversize)/175, (boat_width+2*oversize)/boat_width, 1]) 2d_front();
}

module 2d_front(){
    translate([-depth,0,-1]){
        projection(){
            difference(){
                scale([9.9,9.166,10]){
                    difference(){
                        union(){
                            translate([20,0,0])cylinder(20,d=d);
                            translate([30/2-d+2,0,0])cube([30,d,30], center=true);
                        }
                        translate([-30,-15,-15.5])cube([30,31,31]);
                    }
                }
                translate([depth/2-0.1,0,-thickness/2])cube([depth,boat_width*2,310],center=true);
            }
        }
    }
}