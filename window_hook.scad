points = [
    [   0,  -3],
    [   0,   0],
    [ -10,   0],
    [ -10, -50],
];


wall_thickness = 0.4;
wall_height    = 40;

// Extrude the created wall path
linear_extrude(height = wall_height) {
    poly_line(points, wall_thickness);
}

// Module to create a thick line from open points
module poly_line(pts, thickness) {
    for (i = [0 : len(pts) - 2]) {
        hull() {
            translate(pts[i]) circle(d = thickness, $fn = 16);
            translate(pts[i+1]) circle(d = thickness, $fn = 16);
        }
    }
}
