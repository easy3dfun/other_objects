foot_diameter = 30;
foot_height   = 10;
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
            translate([foot_diameter/2-foot_height/2, 0, 0])
                circle(r = foot_height/2);
        // fill the hole
        cylinder(r = foot_diameter/2-foot_height/2, h = foot_height, center = true);
    }
}

module hole() {
    color("red")
    translate([0, 0, -foot_height/2])
    cylinder(r = hole_diameter/2, h = foot_height, center = true);
}
