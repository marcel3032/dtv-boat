use <boat-top-back.scad>;

sirka = 8;
dlzka = 45;
vyska = 7.5;
$fn = 30;
uhol2 = -15;

CubePoints = [
  [ dlzka/12,          0,       0 ],  //0
  [ dlzka/3+2,           0,       0 ],  //1
  [ dlzka/2-2, sirka/2+2, vyska/3 ],  //2
  [ dlzka/18,  sirka/2+2, vyska/3 ],  //3
  [  0,                0,   vyska ],  //4
  [ dlzka,             0,   vyska ],  //5
  [ dlzka/2+2,     sirka,   vyska ],  //6
  [  0,            sirka,   vyska ],  //7
];
  
CubeFaces = [
  [0,1,2,3],
  [6,2,5],[5,2,1],
  [6,7,3,2],
  [7,6,5,4], //vrch
  [7,4,0,3], //zadna cast
  [4,5,1,0],  //spoj
];

for (face=[0:1:len(CubeFaces)-1]) {
    echo("face: ", face, CubeFaces[face], len(CubeFaces[face]));
    for(point=[0:1:len(CubeFaces[face])-1]){
        echo(CubePoints[CubeFaces[face][point]]);
    }
}

//color("red") translate([1.135,0,0]) circle(d=0.95);

hrubka_oplastenie = 0.3;
hrubka_priecky = 0.35;
sirka_priecky = 20;
vyska_priecky = 10;
dlzka_priecky = 50;
rozostup = 4.5;

/*
projection(){
    scale([1,,1])
    difference(){
        cube([77,50,1]);
        translate([10,15,0])cube([40,20,1]);
    }
}
*/

//translate([10,0,-hrubka_oplastenie])

// scale([9.9,9.4,10]) translate([0,-sirka,0])cube([2, sirka*2, vyska]);

/*d = 12;
//projection() 
    scale([9.9,9.4,10]){
        difference(){
            //trup();
            //translate([20,0,0])cylinder(20,d=d);
            //translate([30/2-d+2,0,0])cube([30,d,30], center=true);
        }
    }
*/

//rotate([0,0,180])translate([-74/2-7-5,0,vyska*10-2.8]) back_cover_base();

rotate([0,90,0]) trup();

scale([10,10,10]){
    //priecky(true);
    //priecne_priecky();
    //translate([1,0,0])
    //priecky(false);
}
//priecky(true);
//priecne_priecky();
//translate([1,0,0])
//priecky(false);

scale([10,10,10]) priecky_to_cut();
//servo_priecka();
//komponenty();

module priecky_to_cut() {
    projection(cut=true)
    {
        union(){
            translate([-8,20,(-rozostup+hrubka_priecky/2)*(sirka-2*hrubka_oplastenie)/sirka])
                rotate([90,0,0])
                    priecky(false);
            translate([-8,30,(+rozostup-hrubka_priecky/2)*(sirka-2*hrubka_oplastenie)/sirka])
                rotate([90,0,0])
                    priecky(false);
        }
    }
    projection(cut=true)
    {
        uhol = atan2(dlzka/12*((dlzka-2*hrubka_oplastenie)/dlzka),vyska*((vyska-2*hrubka_oplastenie)/vyska));
        union(){
            translate([0,0,-0.001-dlzka/12+hrubka_priecky])
                rotate([0,-90+uhol,0])
                    priecky(true);
            translate([10,0,-0.001-dlzka/12])
                rotate([0,-90+uhol,0])
                    priecky(true);
            translate([19,0,(-10-0.001-1*hrubka_priecky)*(dlzka-2*hrubka_oplastenie)/dlzka])
                rotate([0,-90-uhol2+1,0])
                    priecky(true);
            translate([28,0,(-10-0.001-2*hrubka_priecky)*(dlzka-2*hrubka_oplastenie)/dlzka])
                rotate([0,-90-uhol2+1,0])
                    priecky(true);
            translate([40,0,(-20-0.001)*(dlzka-2*hrubka_oplastenie)/dlzka])
                rotate([0,-90,0])
                    priecky(true);
            translate([50,0,(-30-0.001)*(dlzka-2*hrubka_oplastenie)/dlzka])
                rotate([0,-90,0])
                    priecky(true);
        }
    }
}

module servo_priecka(){
    translate([4.0,0,4.75])
        cube([4.5, (sirka-2*hrubka_oplastenie)/sirka*rozostup*2-2*hrubka_priecky, hrubka_priecky], center=true);
}

module priecky(vrchne){
    scale([(dlzka-2*hrubka_oplastenie)/dlzka,(sirka-2*hrubka_oplastenie)/sirka,(vyska-2*hrubka_oplastenie)/vyska]) 
    {
        if(vrchne){
            intersection() {
                trup();
                difference(){
                    priecne_priecky();
                    intersection(){
                        pozdlzne_priecky();
                        vrch();
                    }
                }
            }
        }

        if(!vrchne){
            intersection() {
                trup();
                difference(){
                    pozdlzne_priecky();
                    intersection(){
                        priecne_priecky();
                        difference(){
                            trup();
                            vrch();
                        }
                    }
                }
            }
        }
    }
}

module trup(){
    a = 0;
    union() {
        rotate([a,0,0])
            polyhedron( CubePoints, CubeFaces );
        mirror([0,1,0])
            rotate([a,0,0])
                polyhedron( CubePoints, CubeFaces );
    }
}

module vrch(){
    color("violet"){
        rotate([0,-4,0])
            translate([-5,-sirka_priecky/2,4])
                cube([dlzka_priecky,sirka_priecky,vyska_priecky]);
    }
}

module odlahcovaci_otvor(){    
    hull(){
        r = 3.1;
        translate([8,0,vyska+3])
            rotate([0,90,0])
                cylinder(5,r,r);
        translate([8,0,vyska+1])
            rotate([0,90,0])
                cylinder(5,r,r);
    }
    hull(){
        angle = 78;
        r = 3.1;
        translate([15,0,vyska+3])
            rotate([0,angle,0])
                cylinder(40,r,r);
        translate([15,0,vyska-2.7])
            rotate([0,angle,0])
                cylinder(40,r,r);
    }
}

module servo3kg(){
    color("white"){
        translate([1,0,1.5])
            cylinder(h=2, d=1, center=true);
    }
    color("grey"){
        cube([4.1, 2.0, 3.6], center=true);
        translate([0,0,2.68/2])
            cube([5.4, 2.0, 0.3], center=true);
    }
}

module komponenty(){
    motor_z = 2.1;
    // telo motora
    translate([10.4+hrubka_priecky,0,motor_z])
        rotate([0,90+uhol2,0])
            cylinder(5.5,d=3.6);
    // okolo osky
    translate([9,0,motor_z-0.4])
        rotate([0,90+uhol2,0])
            cylinder(5.5,d=1.45);
    
    // srouby
    translate([9,1.25,motor_z-0.4])
        rotate([0,90+uhol2,0])
            cylinder(5.5,d=0.3);
    translate([9,-1.25,motor_z-0.4])
        rotate([0,90+uhol2,0])
            cylinder(5.5,d=0.3);
    
    translate([0,0,0.0])
        rotate([0,79.5,0])
            cylinder(9,d=1.035);
    
    translate([4.6,-1,3.7])
        rotate([0,0,90])
            servo3kg();
}

module priecne_priecky(){
    difference() 
    {
        translate([0,0, vyska_priecky/2-1]){
            color("blue"){
                uhol = atan2(dlzka/12,vyska);
                translate([dlzka/12/2+0.01,0,0])
                    rotate([0,-uhol,0])
                        cube([hrubka_priecky,sirka_priecky,vyska_priecky], center=true);
                translate([dlzka/12/2+0.01+hrubka_priecky,0,0])
                    rotate([0,-uhol,0])
                        cube([hrubka_priecky,sirka_priecky,vyska_priecky], center=true);
                translate([10-hrubka_priecky,0,0])
                    rotate([0,uhol2,0])
                        cube([hrubka_priecky,sirka_priecky,vyska_priecky], center=true);
                translate([10,0,0])
                    rotate([0,uhol2,0])
                        cube([hrubka_priecky,sirka_priecky,vyska_priecky], center=true);
                translate([20,0,0])
                    cube([hrubka_priecky,sirka_priecky,vyska_priecky], center=true);
                translate([30,0,0])
                    cube([hrubka_priecky,sirka_priecky,vyska_priecky], center=true);
            }
        }
        odlahcovaci_otvor();
        komponenty();
    }
}

module pozdlzne_priecky() {
    //translate([0,0, vyska_priecky/2-1])
    {
        color("red"){
            uhol = atan2(dlzka/12,vyska);
            translate([hrubka_priecky+vyska_priecky*1.5/2+dlzka/12,-rozostup,-vyska_priecky*1.5])
                rotate([0,-uhol,0])
                    cube([dlzka_priecky,hrubka_priecky,vyska_priecky*3], center=false);
            
            translate([hrubka_priecky+vyska_priecky*1.5/2+dlzka/12,+rozostup-hrubka_priecky,-vyska_priecky*1.5])
                rotate([0,-uhol,0])
                    cube([dlzka_priecky,hrubka_priecky,vyska_priecky*3], center=false);
        }
    }
}

