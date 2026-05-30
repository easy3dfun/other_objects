points = [
    [   0,  -3],
    [   0,   0],
    [ -10,   0],
    [ -10, -50],
];

wall_thickness = 0.4;
wall_height    = 40;

linear_extrude(height = wall_height) {
    poly_line(points, wall_thickness);
}

module poly_line(pts, thickness) {
    for (i = [0 : len(pts) - 2]) {
        hull() {
            translate(pts[i]) square(thickness, center = true);
            translate(pts[i+1]) square(thickness, center = true);
        }
    }
}
