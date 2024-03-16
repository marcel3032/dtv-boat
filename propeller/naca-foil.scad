function four_digits_naca_camber(x,m,p) = (x<=p) ? m/pow(p,2)*(2*p*x - pow(x,2)) : m/pow(1-p, 2)*((1-2*p)+2*p*x-pow(x,2));

function symetrical_naca_half_thickness(x,t) = 5*t*(0.2969*sqrt(x) - 0.1260*x - 0.3516*pow(x,2) + 0.2843*pow(x,3) - 0.1015*pow(x,4));

function naca_top_coordinates(m,p,t,n) = [ for (x=[0:1/(n-1):1]) [x, four_digits_naca_camber(x,m,p)+symetrical_naca_half_thickness(x,t)]];

function naca_bottom_coordinates(m,p,t,n) = [ for (x=[1:-1/(n-1):0]) [x,  four_digits_naca_camber(x,m,p)-symetrical_naca_half_thickness(x,t)]];

function naca_coordinates(m,p,t,n) = concat(naca_top_coordinates(m,p,t,n), naca_bottom_coordinates(m,p,t,n));

module naca_airfoil(chord,m,p,t,n) {
    points = naca_coordinates(m,p,t,n);
    scale([chord,chord,1])
        polygon(points);
}

chord = 10;
m = 2;
p = 4;
naca_thickness = 12;
foil_points = 50;

naca_airfoil(chord, m/100, p/10, naca_thickness/100, foil_points);