// Example usage:
// connector_diamond_bar(type = "male");

module connector_diamond_bar(type = "male") {
    // Parameters
    width = 10;
    height = 10;
    length = 100;
    barb_flare = 2;
    start_scale = 0.5;
    
    // Gap parameters for compression
    gap_width = 1.5; 
    gap_depth = 30; // How far the slices go into the bar

    // Calculations for 45 degree angles
    ramp_up_length = (width + barb_flare - width * start_scale) / 2;
    ramp_down_length = barb_flare / 2;
    total_barb_length = ramp_up_length + ramp_down_length;

    difference() {
        // The main object
        union() {
            // 1. Leading Ramp
            hull() {
                translate([0, (width - width * start_scale) / 2, (height - height * start_scale) / 2])
                    cube([0.1, width * start_scale, height * start_scale]);
                translate([ramp_up_length, -barb_flare / 2, -barb_flare / 2])
                    cube([0.1, width + barb_flare, height + barb_flare]);
            }
            // 2. Back Ramp
            hull() {
                translate([ramp_up_length, -barb_flare / 2, -barb_flare / 2])
                    cube([0.1, width + barb_flare, height + barb_flare]);
                translate([total_barb_length, 0, 0])
                    cube([0.1, width, height]);
            }
            // 3. Main Bar
            translate([total_barb_length, 0, 0])
                cube([length - total_barb_length, width, height]);
        }

        // The "Male" Compression Slices
        if (type == "male") {
            // Horizontal slice
            translate([-1, (width - gap_width) / 2, -1])
                cube([gap_depth + 1, gap_width, height + 2 + barb_flare]);
            
            // Vertical slice
            translate([-1, -1, (height - gap_width) / 2])
                cube([gap_depth + 1, width + 2 + barb_flare, gap_width]);
        }
    }
}
