$fn = 96;

button_d     = 15.3;  // outer diameter
button_h     = 1.5;   // thickness of the flat part
rim_w        = 1.2;   // width of the raised rim
rim_h        = 0.5;   // height of the raised rim
hole_d       = 1.5;     // thread hole diameter
hole_spacing = 2.5;   // distance between hole centres
edge_r       = 0.2;   // rounding radius of the top outer edge
chamfer_h    = 0.75;   // height of the underside chamfer
chamfer_ang  = 60;    // chamfer angle measured from the flat underside

total_h = button_h + rim_h;
R       = button_d / 2;
run     = chamfer_h / tan(chamfer_ang);  // horizontal width of the chamfer

module outer_shape() {
    hull() {
        // underside: flat bottom with a 60 degree chamfer
        cylinder(r1 = R - run, r2 = R, h = chamfer_h);
        // top: rounded outer edge
        translate([0, 0, total_h - edge_r])
            rotate_extrude()
                translate([R - edge_r, 0])
                    circle(r = edge_r);
    }
}

difference() {
    outer_shape();

    // recess inside the rim
    translate([0, 0, button_h])
        cylinder(d = button_d - 2 * rim_w, h = rim_h + 0.01);

    // four thread holes
    for (x = [-1, 1], y = [-1, 1])
        translate([x * hole_spacing / 2, y * hole_spacing / 2, -0.01])
            cylinder(d = hole_d, h = total_h + 0.02);
}
