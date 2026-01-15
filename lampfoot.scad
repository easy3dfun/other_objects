diameter = 30;
hole_diameter = 16;

difference() {
    foot();
    hole();
}

module foot() {
    // torus
    color([0.5, 0.5, 0.5])
    union() {
        rotate_extrude()
            translate([diameter/2, 0, 0])
                circle(r = diameter/2);
        // fill the hole
        cylinder(r = diameter/2, h = diameter, center = true);
    }
}

module hole() {
    color("red")
    translate([0, 0, -diameter/2])
    cylinder(r = hole_diameter/2, h = diameter/2, center = true);
}
