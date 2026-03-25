// Rendering settings for smoothness
$fn = 500;

// Variables (dimensions in mm)
outer_diameter = 150;
inner_diameter = 110;
height = 0.8;
cut_width = 1;

difference() {
    // Main ring body
    difference() {
        cylinder(d = outer_diameter, h = height, center = true);
        cylinder(d = inner_diameter, h = height + 1, center = true);
    }
    
    // The 1mm cut on one side
    translate([outer_diameter / 4, 0, 0])
        cube([outer_diameter / 2, cut_width, height + 1], center = true);
}
