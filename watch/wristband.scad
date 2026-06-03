// --- Parameters ---
wrist_width    = 60;       // Width of wrist (X-axis)
wrist_depth    = 42;       // Depth of wrist (Y-axis)
wall_thickness = 0.4;      // Thickness of the band wall
wall_height    = 10;       // Width of the band on the wrist
open_angle     = 45;       // Gap size at the top in degrees
hook_standoff  = 1;        // Size of the gap between hook and band
hook_length    = 3;        // How far the hook reaches backward
$fn            = 64;       // Smoothness of the curves

// --- Core Math ---
x_radius = wrist_width / 2;
y_radius = wrist_depth / 2;
start_angle = open_angle / 2;
end_angle = 360 - (open_angle / 2);
step = 5; 

// Generate core arc points
arc_points = [for (a = [start_angle : step : end_angle]) [x_radius * sin(a), y_radius * cos(a)]];

p_start = arc_points[0];
p_end   = arc_points[len(arc_points)-1];

// Directional vectors
dir_out_start  = [sin(start_angle), cos(start_angle)];
dir_back_start = [cos(start_angle), -sin(start_angle)]; 

dir_out_end    = [sin(end_angle), cos(end_angle)];
dir_back_end   = [-cos(end_angle), sin(end_angle)];   

// --- 3D Render ---
linear_extrude(height = wall_height) {
    // 1. Draw the main C-band
    poly_line(arc_points, wall_thickness);
    
    // 2. Draw the hooks using the new module
    hook(p_start, dir_out_start, dir_back_start, hook_standoff, hook_length, wall_thickness);
    hook(p_end, dir_out_end, dir_back_end, hook_standoff, hook_length, wall_thickness);
}

// --- Modules ---

// Reusable Hook Module
module hook(base_pt, out_dir, back_dir, standoff, length, thickness) {
    p_standoff = base_pt + (out_dir * standoff);
    p_tip      = p_standoff + (back_dir * length);
    
    poly_line([base_pt, p_standoff, p_tip], thickness);
}

// Line Drawing Module
module poly_line(pts, thickness) {
    for (i = [0 : len(pts) - 2]) {
        hull() {
            translate(pts[i]) circle(d = thickness, $fn = 16);
            translate(pts[i+1]) circle(d = thickness, $fn = 16);
        }
    }
}
