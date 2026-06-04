// --- Parameters ---
wrist_width        = 60;  // Width of wrist (X-axis)
wrist_depth        = 42;  // Depth of wrist (Y-axis)
wall_thickness     = 0.48; // Thickness of the band wall
wall_height        = 10;  // Width of the band on the wrist
open_angle         = 40;  // Gap size at the top in degrees
hook_standoff_left = 2.2; // Distance the left hooks stand off from the band (gap)
hook_standoff_right= 2.4; // Distance the right hooks stand off from the band (gap)
hook_length        = 2; // How far the hook reaches backward
hook_spacing_angle = 14;   // Distance between first and second hook in degrees
$fn                = 64;  // Smoothness of the curves

// --- Core Math ---
x_radius = wrist_width / 2;
y_radius = wrist_depth / 2;
start_angle = open_angle / 2;
end_angle = 360 - (open_angle / 2);
step = 5; 

// Generate core arc points
arc_points = [for (a = [start_angle : step : end_angle]) [x_radius * sin(a), y_radius * cos(a)]];

// Hook 1 positions (at the very ends)
p_start_1 = arc_points[0];
p_end_1   = arc_points[len(arc_points)-1];

dir_out_start_1  = [sin(start_angle), cos(start_angle)];
dir_back_start_1 = [cos(start_angle), -sin(start_angle)]; 

dir_out_end_1    = [sin(end_angle), cos(end_angle)];
dir_back_end_1   = [-cos(end_angle), sin(end_angle)];   

// Hook 2 positions (further down the band)
start_angle_2 = start_angle + hook_spacing_angle;
end_angle_2   = end_angle - hook_spacing_angle;

p_start_2 = [x_radius * sin(start_angle_2), y_radius * cos(start_angle_2)];
p_end_2   = [x_radius * sin(end_angle_2),   y_radius * cos(end_angle_2)];

dir_out_start_2  = [sin(start_angle_2), cos(start_angle_2)];
dir_back_start_2 = [cos(start_angle_2), -sin(start_angle_2)]; 

dir_out_end_2    = [sin(end_angle_2), cos(end_angle_2)];
dir_back_end_2   = [-cos(end_angle_2), sin(end_angle_2)];   

// --- 3D Render ---
linear_extrude(height = wall_height) {
    // Draw the main C-band
    poly_line(arc_points, wall_thickness);
    
    // Draw Primary Hooks (Outer)
    hook(p_start_1, dir_out_start_1, dir_back_start_1, hook_standoff_left, hook_length, wall_thickness);
    hook(p_end_1, dir_out_end_1, dir_back_end_1, hook_standoff_right, hook_length, wall_thickness);
    
    // Draw Secondary Hooks (Inner Adjustment)
    hook(p_start_2, dir_out_start_2, dir_back_start_2, hook_standoff_left, hook_length, wall_thickness);
    hook(p_end_2, dir_out_end_2, dir_back_end_2, hook_standoff_right, hook_length, wall_thickness);
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
