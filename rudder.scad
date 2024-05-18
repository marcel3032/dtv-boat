$fn = 30;

arm_length = 65;
arm_base_width = 25;
arm_base_height = 35;

arm_end_width = 9;
arm_end_height = 30;

ship_back_angle = 26.5;

axis_diameter = 3.4;
axis_offset = 3;
axis_length = 40;
axis_over = 5;

axis_cap_height = 8;
axis_cap_width = 6;

cotter_diameter = 1.6;

plate_thickness = 2;
plate_screw_diameter = 3.3;
plate_padding = 2;
plate_margin = 2;

rudder_height = 50;
rudder_width = 6;
rudder_length = 30;

rudder_end_width = 3;
rudder_end_length = 15;

servo_lever_width = 40;

// priestor medzi arm a rudder
ra_z = 0.5;
ra_x = 0.5;

// hrubka toho pliesku na bowdeny
x = 1.5;

e = 0.0001;

arm_scale_width = arm_end_width / arm_base_width;
arm_scale_height = arm_end_height / arm_base_height;
arm_base_rotated_height = arm_base_height/sin(90-ship_back_angle);

plate_width = 2*plate_screw_diameter + 2*plate_padding + 2*plate_margin + arm_base_width;
plate_height = 2*plate_screw_diameter + 2*plate_padding + 2*plate_margin + arm_base_rotated_height;

alpha = atan(rudder_length/(rudder_width/2));
axis_center_x = tan(alpha/2) * (rudder_width/2);

rudder_scale_width = rudder_end_width / rudder_width;
rudder_scale_length = rudder_end_length / rudder_length;

water_pipe_offset=17.5;

module arm() {
    difference() {
        rotate([0, 90, 0])
        linear_extrude(height=arm_length, scale=[arm_scale_height, arm_scale_width])
        translate([0, -arm_base_width/2, 0])
        square([arm_base_height, arm_base_width]);
        
        translate([0, 0, -arm_base_height])
        rotate([0, ship_back_angle, 0])
        translate([-arm_base_height, -arm_base_width/2, 0])
        cube([arm_base_height, arm_base_width, arm_base_height*2]);
        
        axis();
        
        rotate([0, 90, 0])
        translate([arm_end_height/4-ra_z, -arm_base_width/2, arm_length-arm_end_width/2-ra_x])
        cube([arm_end_height/2+2*ra_z, arm_base_width+2*ra_x, arm_base_width+2*ra_x]);
    }
    
    difference() {
        rotate([0, 180, 0])
        translate([-arm_length, 0, -arm_end_width/2])
        cylinder(h=arm_base_height, r=arm_end_width/2);
        
        rotate([0, 90, 0])
        translate([arm_end_height/4-ra_z, -arm_base_width/2, arm_length-arm_end_width/2])
        cube([arm_end_height/2+2*ra_z, arm_base_width, arm_base_width]);
        
        rotate([0, 0, 0])
        translate([arm_end_height/4-ra_z, -arm_base_width/2, arm_length-arm_end_width/2])
        cube([arm_end_height/2+2*ra_z, arm_base_width, arm_base_width]);
        
        rotate([0, 90, 0])
        translate([0, -arm_base_width/2, arm_length-arm_end_width/2])
        rotate([0, -90, 0])
        cube([arm_end_height/2+2*ra_z, arm_base_width, arm_base_width]);
        
        rotate([0, 90, 0])
        translate([arm_end_height, -arm_base_width/2, arm_length-arm_end_width/2])
        cube([arm_end_height/2+2*ra_z, arm_base_width, arm_base_width]);
        
        axis();
    }
    
    difference() {
        translate([arm_length, 0, 0])
        cylinder(h=axis_cap_height, r=axis_cap_width/2);
        
        axis();
        
        translate([arm_length-axis_cap_width, 0, e+axis_cap_height/2])
        rotate([0, 90, 0])
        cylinder(h=axis_cap_width*2+e, r=cotter_diameter/2);
    }
}

module rudder(){
    difference() {
        translate([arm_length, 0, -arm_end_height/4])
        rotate([0, 180, 0])
        cylinder(h=arm_end_height/2, r=arm_end_width/2);
        
        axis();
    }
    
    difference() {
        rotate([0, 90, 0])
        translate([arm_end_height/4, -(arm_end_width)/2, arm_length])
        cube([arm_end_height/2, arm_end_width, rudder_length]);
        
        translate([arm_length, 0, 0])
        rotate([0, 180, 0])
        cylinder(h=arm_end_height, r=arm_end_width/2);
    }
   
    rotate([0, 90, 0])
    translate([arm_end_height/2, -(arm_end_width)/2, arm_length+arm_end_width/2+ra_x])
    cube([arm_end_height/2, arm_end_width, rudder_length-arm_end_width/2-ra_x]);
    
    rotate([180, 0, 0])
    translate([arm_length+arm_end_width/2+ra_x, 0, arm_end_height])
    linear_extrude(height=rudder_height, scale=0.7)
    translate([0, -(arm_end_width)/2, 0])
    polygon(points=[[0, arm_end_width/2], [rudder_length-arm_end_width/2-ra_x, arm_end_width-1], [rudder_length-arm_end_width/2-ra_x, 1]]);
    
    //color("red")
    rotate([0, 90, 0])
    translate([arm_end_height/4, -(arm_end_width)/2, arm_length+arm_end_width/2+ra_x]) {
        cube([x, arm_end_width, rudder_length-arm_end_width/2-ra_x]);
        
        difference(){
            hull() {
            //ten velky, stredna translate hodnota sa ma menit
            color("red")
            rotate([0, 90, 0])
            translate([-arm_end_width/2, -(servo_lever_width/2-arm_end_width/2), 0])
            cylinder(h=x, r=arm_end_width/2);
            
            color("red")
            translate([0, -e, 0])
            cube([x, e, e]);
            
            color("red")
            rotate([0, 90, 0])
            translate([-(rudder_length-arm_end_width/2-ra_x), 0, 0])
            cylinder(h=x, r=e);
            }
            
            for(i=[servo_lever_width/2-arm_end_width/2 : -5 : 5]) {
                color("red")
                rotate([0, 90, 0])
                translate([-arm_end_width/2, -i, -x/2])
                cylinder(h=x*2, d=1.8);
            }
        }
        
        difference() {
            hull() {
            color("red")
            rotate([0, 90, 0])
            translate([-arm_end_width/2, (servo_lever_width/2+arm_end_width/2), 0])
            cylinder(h=x, r=arm_end_width/2);
            
            color("red")
            translate([0, e, 0])
            cube([x, e, e]);
            
            color("red")
            rotate([0, 90, 0])
            translate([-(rudder_length-arm_end_width/2-ra_x), arm_end_width, 0])
            cylinder(h=x, r=e);
            }
            
            for(i=[servo_lever_width/2-arm_end_width/2+arm_end_width : -5 : 12]) {
                color("red")
                rotate([0, 90, 0])
                translate([-arm_end_width/2, i, -x/2])
                cylinder(h=x*2, d=1.8);
            }
        }
        
        difference() {
            union() {

                pipe_d = 5;

                color("red")
                translate([-10, arm_end_width/2, water_pipe_offset])
                rotate([0, 90, 0])
                cylinder(h=10, d=5);
                
                color("red")
                translate([70-arm_end_height/4, arm_end_width/2, 0])
                cylinder(h=water_pipe_offset-arm_end_width, d=pipe_d);
                
                color("red")
                translate([0, arm_end_width/2, water_pipe_offset])
                rotate([0, 90, 0])
                cylinder(h=70-arm_end_height/4-arm_end_width, d=pipe_d);
                
                color("blue")
                translate([70-arm_end_height/4-arm_end_width, arm_end_width/2, water_pipe_offset-arm_end_width])
                rotate([90, 0, 0])
                rotate_extrude(angle=90)
                translate([arm_end_width, 0, 0])
                circle(d=pipe_d);
            }
            
            
        }
    }
       
}

module plate() {
    translate([0, 0, -arm_base_height])
    rotate([0, ship_back_angle, 0])
    translate([-plate_thickness, -plate_width/2, -plate_padding-plate_screw_diameter-plate_margin]) {
        difference() {
            cube([plate_thickness, plate_width, plate_height]);
            
            rotate([0, 90, 0])
            translate([-plate_margin-plate_screw_diameter/2, plate_margin+plate_screw_diameter/2, -plate_thickness/2])
            cylinder(h=plate_thickness*2, r=plate_screw_diameter/2);
            
            rotate([0, 90, 0])
            translate([-plate_margin-plate_screw_diameter/2, plate_padding+plate_margin*2+plate_screw_diameter*1.5+arm_base_width, -plate_thickness/2])
            cylinder(h=plate_thickness*2, r=plate_screw_diameter/2);
            
            offsetX = arm_base_rotated_height + plate_margin + 1.5*plate_screw_diameter + 2*plate_padding;
            
            rotate([0, 90, 0])
            translate([-offsetX, plate_margin+plate_screw_diameter/2, -plate_thickness/2])
            cylinder(h=plate_thickness*2, r=plate_screw_diameter/2);
            
            rotate([0, 90, 0])
            translate([-offsetX, plate_padding+plate_margin*2+plate_screw_diameter*1.5+arm_base_width, -plate_thickness/2])
            cylinder(h=plate_thickness*2, r=plate_screw_diameter/2);
        }
    }
}

module axis() {
    translate([arm_length, 0, axis_length])
    rotate([180, 0, 0])
    cylinder(h=axis_length*2, r=axis_diameter/2);
}

//axis();


difference()
{
    rudder();
    rotate([0, 90, 0])
    translate([arm_end_height/4, -(arm_end_width)/2, arm_length+arm_end_width/2+ra_x])
    union() {
        pipe_d = 3.5;
        color("red")
        translate([70-arm_end_height/4, arm_end_width/2, -10*e+0])
        cylinder(h=100*e+water_pipe_offset-arm_end_width, d=pipe_d);
        
        color("red")
        translate([-15, arm_end_width/2, water_pipe_offset])
        rotate([0, 90, 0])
        cylinder(h=85+10*e-arm_end_height/4-arm_end_width, d=pipe_d);
        
        color("blue")
        translate([70-arm_end_height/4-arm_end_width, arm_end_width/2, water_pipe_offset-arm_end_width])
        rotate([90, 0, 0])
        rotate_extrude(angle=90)
        translate([arm_end_width, 0, 0])
        circle(d=pipe_d);
    }
}

arm();
plate();