/* 
   Parametric Interlocking Wristband
   Print-in-place, flexible chain 
*/

$fn = 32;

// --- Parameters ---

// Number of links in the wristband (12-14 is usually good for adults)
num_links = 12;

// Base Dimensions
flat_length = 10;
width = 16;
thickness = 2;

// Arm Dimensions
arm_length = 12;
angle = 45;

// Joint Dimensions
rail_width = 3.5;           // Width of the loop sides
pillar_width = 5;           // Width of the center stick (leaves 2mm clearance on each side)
arrow_max_width = 14;       // Width of the catch to prevent it from pulling out
arrow_length = 4;           // Length of the arrowhead triangle
loop_crossbar_length = 3;   // The bar that closes the loop

// Overlap for strength at the joint where arm meets the flat base
inset = 1;

// --- Math & Positioning ---
right_pivot = flat_length/2 - inset;
left_pivot = -flat_length/2 + inset;

// The exact distance required so the 45-degree arms cross perfectly in their center
pitch = (right_pivot - left_pivot) + arm_length * cos(angle);


// --- Assembly ---
// Generate the fully interlocked print-in-place chain
for (i = [0 : num_links - 1]) {
    translate([i * pitch, 0, 0])
        link();
}


// --- Modules ---
module link() {
    // 1. Flat Base Plate
    translate([-flat_length/2, -width/2, 0])
        cube([flat_length, width, thickness]);

    // 2. Right Arm (Female Loop) - Extends Up and Right
    translate([right_pivot, 0, 0])
        rotate([0, -angle, 0]) {
            // Front Rail
            translate([0, width/2 - rail_width, 0])
                cube([arm_length, rail_width, thickness]);
            // Back Rail
            translate([0, -width/2, 0])
                cube([arm_length, rail_width, thickness]);
            // Top Closing Crossbar
            translate([arm_length - loop_crossbar_length, -width/2, 0])
                cube([loop_crossbar_length, width, thickness]);
        }

    // 3. Left Arm (Male Arrowhead) - Extends Up and Left
    // Drawn facing left (-X), then rotated UP (+45)
    translate([left_pivot, 0, 0])
        rotate([0, angle, 0]) {
            difference() {
                union() {
                    // Central Pillar
                    translate([-arm_length, -pillar_width/2, 0])
                        cube([arm_length, pillar_width, thickness]);
                    
                    // Arrowhead Catch (Chamfered so it prints easily without supports)
                    hull() {
                        translate([-arm_length, -arrow_max_width/2, 0])
                            cube([0.01, arrow_max_width, thickness]);
                        translate([-arm_length + arrow_length, -pillar_width/2, 0])
                            cube([0.01, pillar_width, thickness]);
                    }
                }
                
                // Compression slit (Allows the user to snap the ends together to close the wristband)
                slit_width = 1;
                slit_length = arrow_length + 3;
                translate([-arm_length - 1, -slit_width/2, -1])
                    cube([slit_length + 1, slit_width, thickness + 2]);
            }
        }
}
