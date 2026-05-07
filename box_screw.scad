$fn = 80;

screw();

module screw() {
    shaft_diameter = 60;
    shaft_length   = 40;

    thread_thickness = 60; // How "fat" the snake is
    thread_protrusion = 3; // How far it sticks out from the shaft
    thread_pitch     = 25;

    head_diameter  = 72;
    head_height    = 10;

    inner_diameter = 58;
    inner_height = 40;

    screw_it();

    module screw_it() {
        difference() {
            inner_screw();
            translate([0, 0, bottom_thickness])
            cylinder(
                d = inner_diameter, 
                h = inner_height,
            );
        }
    }

    module inner_screw() {
        // Shaft core
        cylinder(d = shaft_diameter, h = shaft_length);

        // Helical thread
        linear_extrude(
            height = shaft_length,
            twist = -360 * shaft_length / thread_pitch,
            slices = 200
        )
        // Shift the circle so it sits halfway inside the shaft
        translate([(shaft_diameter / 2) + thread_protrusion - (thread_thickness / 2), 0, 0])
        circle(d = thread_thickness);

        // Screw head
        translate([0, 0, shaft_length])
        cylinder(d = head_diameter, h = head_height);
    }

}
