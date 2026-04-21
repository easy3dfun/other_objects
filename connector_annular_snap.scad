// Parameters
bulb_radius = 5;
shaft_radius = 4.9;
shaft_height = 10;
tolerance = 0.2; // Extra space for the female part to fit

module connector_annular_snap() {
    union() {
        // The Shaft
        cylinder(r = shaft_radius, h = shaft_height);
        // The Bulb (The "Punch" head)
        translate([0, 0, shaft_height])
        scale([1,1,2]) sphere(r = bulb_radius);
    }
}
