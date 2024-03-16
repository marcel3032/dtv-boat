use <list-comprehension-demos/sweep.scad>
use <scad-utils/transformations.scad>
use <scad-utils/shapes.scad>
use <naca-foil.scad>

module prop_blade(radius, pitch, m, p, t, pathstep = 0.05, foil_points = 50, el_a=20, el_b=12) {
    angle = [for (i=[0:pathstep:radius]) -atan2(pitch, (2*3.14159*i))];
    function func5(x) = angle[round(x/pathstep)];

    a=radius;
    b=radius*el_b/el_a;
    function ellipse(x) = sqrt(pow(b,2)-(pow(x,2)*pow(b,2))/(pow(a,2)));
    function size(x) = (x<a/2) ? ellipse(2*x-a) : ellipse(2*x-a);
    function leading_edge(x) = -size(x)/2+sqrt(sqrt(x))/2;

    shape_points = naca_coordinates(m/100, p/10, t/100, foil_points);

    path_transforms6 = concat([for (i=[0:pathstep:radius]) translation([leading_edge(i),0,i]) * scaling([size(i),size(i),i]) * rotation([0,0,func5(i)])]);
        
    sweep(shape_points, path_transforms6);
}
prop_blade(radius=10, pitch=2, m=2, p=4, t=12);