$fa = 1;
$fs = 0.4;

function naca_half_thickness(x,t) = 5*t*(0.2969*sqrt(x) - 0.1260*x - 0.3516*pow(x,2) + 0.2843*pow(x,3) - 0.1015*pow(x,4));

function naca_top_coordinates(t,n) = [ for (x=[0:1/(n-1):1]) [x, naca_half_thickness(x,t)]];

function naca_bottom_coordinates(t,n) = [ for (x=[1:-1/(n-1):0]) [x, - naca_half_thickness(x,t)]];

function naca_coordinates(t,n) = concat(naca_top_coordinates(t,n), naca_bottom_coordinates(t,n));

module naca_airfoil(chord,t,n) {
    points = naca_coordinates(t,n);
    scale([chord,chord,1])
        polygon(points);
}

root_chord = 10;
naca_thickness = 15;
diameter = 20;
end_scale = 0.85;
foil_points = 300;

rotate([-90,0,90])
    translate([+2*root_chord/6,0,0])
        linear_extrude(height=diameter,twist=-20,scale=[end_scale,end_scale/2])
            translate([-5*root_chord/6,0,0])
                naca_airfoil(root_chord, naca_thickness/100, foil_points);

