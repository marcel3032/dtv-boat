depth = 74;
boat_width = 110;
oversize = 7;
thickness = 2.8;
big_eps = 0.5;

$fn=250;

d = 12;

cube_d = 24.5-7.45-d/2;

translate([0,0,--(thickness+1)]){
    top_front();
    //translate([80,0,1])rotate([0,0,180])shield();
}

module shield(){
    difference(){
        linear_extrude(25, convexity=20, scale=[0.45,0.8])
            outline();
        translate([30,-60,-50]) rotate([0,-15,0]) cube([50,120,100]);
    }
}

module outline(){
    {
        difference(){
            polovica();
            translate([0.1,0,0])scale([0.9,0.97,1])polovica();
        }
    }
}


module polovica(){
    dlzka = 30;
    sirka = 30;
    hull(){
        translate([-dlzka,sirka,0])circle(20);
        translate([-dlzka,-sirka,0])circle(20);
        translate([dlzka,sirka,0])circle(20);
        translate([dlzka,-sirka,0])circle(20);
    }
}

module top_front(){
    translate([0,0,-thickness])linear_extrude(thickness) 2d_front();
    oversized_top();
    difference(){
        translate([-14,0,-thickness/2])cube([28,110,thickness], center=true);
        scale([1.01, 1.01, 1.1])translate([-20/2-10,0,-thickness/2+0.1])cube([22,32,thickness], center=true);
    }
}

module oversized_top(){
    translate([0,0,-0.01])linear_extrude(thickness) scale([(175+oversize)/175, (boat_width+2*oversize)/boat_width, 1]) 2d_front();
}

module 2d_front(){
    projection() 
    scale([9.9,9.165,10]){
        translate([-20+cube_d,0,-1]){
            union(){
                translate([20,0,0])cylinder(20,d=d);
                translate([-cube_d/2+20,0,0])cube([cube_d,d,30], center=true);
            }
        }
    }
}