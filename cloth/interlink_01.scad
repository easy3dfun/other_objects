// Interlocking 45-degree wristband links
// OpenSCAD

$fn = 36;

// ----------------------------
// Choose what to render
// ----------------------------
mode = "strip";     // "one", "strip", or "ring"

// ----------------------------
// Link parameters, in mm
// ----------------------------
link_count   = 12;

thick        = 2.0;
bend_angle   = 45;

body_len     = 13;
body_w       = 9;
body_corner  = 1.5;

tongue_len   = 8;
tongue_w     = 4;

eye_len      = 8;
eye_w        = 9;

clearance    = 0.35;
slot_len     = 5.8;
slot_w       = tongue_w + 2 * clearance;

weld_overlap = 0.8;

// Center-to-center spacing so the male tongue of one link
// lands in the slotted eye of the next link.
pitch = body_len + cos(bend_angle) * ((tongue_len + eye_len) / 2);


// ----------------------------
// 2D helpers
// ----------------------------
module rounded_rect2d(l, w, r) {
    hull() {
        translate([ -l/2 + r, -w/2 + r ]) circle(r = r);
        translate([  l/2 - r, -w/2 + r ]) circle(r = r);
        translate([ -l/2 + r,  w/2 - r ]) circle(r = r);
        translate([  l/2 - r,  w/2 - r ]) circle(r = r);
    }
}

module body2d() {
    rounded_rect2d(body_len, body_w, body_corner);
}

module tongue2d() {
    // Local X runs from -tongue_len to +weld_overlap.
    // Rounded far end.
    union() {
        translate([(-tongue_len + weld_overlap) / 2, 0])
            square([tongue_len + weld_overlap, tongue_w], center = true);

        translate([-tongue_len, 0])
            circle(d = tongue_w);
    }
}

module eye2d() {
    // Slotted plate, local X runs from -weld_overlap to eye_len.
    difference() {
        translate([(eye_len - weld_overlap) / 2, 0])
            rounded_rect2d(eye_len + weld_overlap, eye_w, body_corner);

        translate([eye_len / 2, 0])
            rounded_rect2d(slot_len, slot_w, 1.0);
    }
}


// ----------------------------
// 3D link
// ----------------------------
module link_piece() {
    union() {
        // Flat center plate
        linear_extrude(height = thick, center = true, convexity = 5)
            body2d();

        // Left male tongue, bent upward 45 degrees
        translate([-body_len / 2, 0, 0])
            rotate([0, bend_angle, 0])
                linear_extrude(height = thick, center = true, convexity = 5)
                    tongue2d();

        // Right female slotted eye, bent upward 45 degrees
        translate([body_len / 2, 0, 0])
            rotate([0, -bend_angle, 0])
                linear_extrude(height = thick, center = true, convexity = 5)
                    eye2d();
    }
}


// ----------------------------
// Assemblies
// ----------------------------
module wristband_strip(n = link_count) {
    for (i = [0 : n - 1]) {
        translate([(i - (n - 1) / 2) * pitch, 0, 0])
            color(i % 2 == 0 ? [0.95, 0.55, 0.12] : [0.15, 0.45, 0.90])
                link_piece();
    }
}

module wristband_ring(n = link_count) {
    // Places the links around a wrist-sized ring.
    // For printing, "strip" mode is usually easier.
    r = pitch / (2 * sin(180 / n));

    for (i = [0 : n - 1]) {
        rotate([0, 0, i * 360 / n])
            translate([r, 0, 0])
                rotate([0, 0, 90])
                    color(i % 2 == 0 ? [0.95, 0.55, 0.12] : [0.15, 0.45, 0.90])
                        link_piece();
    }
}


// ----------------------------
// Render selection
// ----------------------------
if (mode == "one") {
    link_piece();
}
else if (mode == "strip") {
    wristband_strip(link_count);
}
else if (mode == "ring") {
    wristband_ring(link_count);
}
