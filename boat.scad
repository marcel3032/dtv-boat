sirka = 8;
dlzka = 45;
vyska = 7;

CubePoints = [
  [  0,                0,           0 ],  //0
  [ dlzka/3,           0,           0 ],  //1
  [ dlzka/2-2, sirka/2+2, vyska/3+0.5 ],  //2
  [  0,        sirka/2+2, vyska/3+0.5 ],  //3
  [  0,                0,       vyska ],  //4
  [ dlzka,             0,       vyska ],  //5
  [ dlzka/2+2,     sirka,       vyska ],  //6
  [  0,            sirka,       vyska ],  //7
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

hrubka_priecky = 0.31;
sirka_priecky = 20;
vyska_priecky = 10;
dlzka_priecky = 50;
rozostup = 4;

trup();

if(false){
    projection(cut=true)
    {
        union(){
            translate([-8,20,-rozostup+hrubka_priecky/2])
                rotate([90,0,0])
                    priecky(false);
            translate([-8,30,+rozostup-hrubka_priecky/2])
                rotate([90,0,0])
                    priecky(false);
        }
    }

    projection(cut=true)
    {
        union(){
            translate([0,0,-0.001])
                rotate([0,-90,0])
                    priecky(true);
            translate([10,0,-hrubka_priecky-0.001])
                rotate([0,-90,0])
                    priecky(true);
            translate([20,0,-10-0.001])
                rotate([0,-90,0])
                    priecky(true);
            translate([30,0,-20-0.001])
                rotate([0,-90,0])
                    priecky(true);
            translate([40,0,-30-0.001])
                rotate([0,-90,0])
                    priecky(true);
        }
    }
}

module priecky(vrchne){
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
        angle = 82;
        r = 3.1;
        translate([5,0,vyska+2])
            rotate([0,angle,0])
                cylinder(40,r,r);
        translate([5,0,vyska-2])
            rotate([0,angle,0])
                cylinder(40,r,r);
    }
}

module priecne_priecky(){
    difference() 
    {
        translate([0,0, vyska_priecky/2-1]){
            color("blue"){
                translate([hrubka_priecky/2+0.001,0,0])
                    cube([hrubka_priecky,sirka_priecky,vyska_priecky], center=true);
                translate([hrubka_priecky+hrubka_priecky/2+0.001,0,0])
                    cube([hrubka_priecky,sirka_priecky,vyska_priecky], center=true);
                translate([10,0,0])
                    cube([hrubka_priecky,sirka_priecky,vyska_priecky], center=true);
                translate([20,0,0])
                    cube([hrubka_priecky,sirka_priecky,vyska_priecky], center=true);
                translate([30,0,0])
                    cube([hrubka_priecky,sirka_priecky,vyska_priecky], center=true);
            }
        }
        odlahcovaci_otvor();
    }
}

module pozdlzne_priecky() {
    translate([0,0, vyska_priecky/2-1]){
        color("red"){
            translate([hrubka_priecky,-rozostup,-vyska_priecky/2])
                cube([dlzka_priecky,hrubka_priecky,vyska_priecky], center=false);
            
            translate([hrubka_priecky,+rozostup-hrubka_priecky,-vyska_priecky/2])
                cube([dlzka_priecky,hrubka_priecky,vyska_priecky], center=false);
        }
    }
}

