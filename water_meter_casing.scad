// Rendering settings for smoothness
$fn = 500;

// Variables (dimensions in mm)
outer_diameter = 150;
inner_diameter =  90;
height = 0.8;

difference() {
    cylinder(d = outer_diameter, h = height, center = true);
    cylinder(d = inner_diameter, h = height + 1, center = true);
}
