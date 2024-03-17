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

//intersection()
{
    a = 0;
    union() {
        rotate([a,0,0])
            polyhedron( CubePoints, CubeFaces );
        mirror([0,1,0])
            rotate([a,0,0])
                polyhedron( CubePoints, CubeFaces );
    }

    union(){
        hrubka_priecky = 0.5;
        sirka_priecky = 20;
        vyska_priecky = 10;
        dlzka_priecky = 50;
        rozostup = 4;
        translate([0,0, vyska_priecky/2-1]){
            color("blue"){
                cube([hrubka_priecky,sirka_priecky,vyska_priecky], center=true);
                translate([10,0,0])
                    cube([hrubka_priecky,sirka_priecky,vyska_priecky], center=true);
                translate([20,0,0])
                    cube([hrubka_priecky,sirka_priecky,vyska_priecky], center=true);
                translate([30,0,0])
                    cube([hrubka_priecky,sirka_priecky,vyska_priecky], center=true);
            }
            color("red"){
                translate([dlzka_priecky/2-4,-rozostup,0])
                    cube([dlzka_priecky,hrubka_priecky,vyska_priecky], center=true);
                translate([dlzka_priecky/2-4,+rozostup,0])
                    cube([dlzka_priecky,hrubka_priecky,vyska_priecky], center=true);                
            }
        }
    }
}