diameter = 30;

// torus
rotate_extrude(convexity = diameter)
    translate([diameter, 0, 0])
        circle(r = diameter/2);

// fill the hole
cylinder(r = diameter, h = diameter, center = true);
