$fn = 160;

// Parameters
shaft_d = 6;        // main shaft diameter
shaft_l = 20;       // shaft length
tip_l = 8;          // tapered tip length
bulb_d = 6.5;         // bulb (locking head) diameter
bulb_l = 6;         // bulb length

module connector() {
    union() {

        // Main shaft
        cylinder(d = shaft_d, h = shaft_l);



        // Bulb (snap feature)
        translate([0, 0, shaft_l - bulb_l/2])
            hull() {
                translate([0, 0, -bulb_l/2])
                    sphere(d = shaft_d);
                translate([0, 0, bulb_l/2])
                    sphere(d = bulb_d);
            }
    }
}

connector();
