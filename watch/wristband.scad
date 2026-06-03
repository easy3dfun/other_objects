// --- Parameters ---
wrist_width    = 60;       // Width of wrist (X-axis)
wrist_depth    = 42;       // Depth of wrist (Y-axis)
wall_thickness = 0.4;      // Thickness of the band wall
wall_height    = 10;       // Width of the band on the wrist
open_angle     = 45;       // Gap size at the top in degrees
hook_standoff  = 1;        // Size of the gap between hook and band
hook_length    = 3;        // How far the hook reaches backward
$fn            = 64;       // Smoothness of the curves

// --- Point Generation ---
x_radius = wrist_width / 2;
y_radius = wrist_depth / 2;
start_angle = open_angle / 2;
end_angle = 360 - (open_angle / 2);
step = 5; 

// Generate the Oval C-shape arc points using independent X and Y radii
arc_points = [
    for (a = [start_angle : step : end_angle]) 
        [x_radius * sin(a), y_radius * cos(a)]
];

// Reference the exact start and end points of the arc
p_start = arc_points[0];
p_end   = arc_points[len(arc_points)-1];

// Outward and backward vector calculations adjusted for the oval angle
dir_out_start  = [sin(start_angle), cos(start_angle)];
dir_back_start = [cos(start_angle), -sin(start_angle)]; 

// Calculate center-to-center distance to achieve the exact target air gap
center_to_center_dist = hook_standoff + wall_thickness;

// Calculate standoff point and final hook tip for the start side
p_standoff_start = p_start + (dir_out_start * center_to_center_dist);
hook_tip_start   = p_standoff_start + (dir_back_start * hook_length);

dir_out_end    = [sin(end_angle), cos(end_angle)];
dir_back_end   = [-cos(end_angle), sin(end_angle)];   

// Calculate standoff point and final hook tip for the end side
p_standoff_end = p_end + (dir_out_end * center_to_center_dist);
hook_tip_end   = p_standoff_end + (dir_back_end * hook_length);

// Combine all points into a single continuous path including the standoffs
points = concat(
    [hook_tip_start, p_standoff_start], 
    arc_points, 
    [p_standoff_end, hook_tip_end]
);

// --- 3D Extrusion ---
linear_extrude(height = wall_height) {
    poly_line(points, wall_thickness);
}

// --- Your Original Module ---
module poly_line(pts, thickness) {
    for (i = [0 : len(pts) - 2]) {
        hull() {
            translate(pts[i]) circle(d = thickness, $fn = 16);
            translate(pts[i+1]) circle(d = thickness, $fn = 16);
        }
    }
}
