$fn=100;

mount_w = 70;
mount_h = 50;
mount_d = 5;

stick_distance = 20; // Distance of each stick from the center

bucket_height   = 235;
bucket_d_top    = 268;
bucket_d_bottom = 195;

color([0.5, 0.5, 0.5]) cube([mount_w, mount_h, mount_d], center=true);

color([0.5, 0.5, 0.5])  difference() {
    sticks();
    bucket();
}

color ([1,0,0]) rim();

// bucket();

module sticks() {
    translate([ stick_distance, 0, 0]) stick();
    translate([-stick_distance, 0, 0]) stick();
}

module stick() {
    intersection() {
        rotate([ 60, 0, 0])
            cube([10,90,10], center=true);
        translate([0, 0, 20])
            cube([mount_w, mount_h, 40], center=true);
    }
}

module rim() {
    translate([0,-10,0])
    difference() {
        bucket();
        translate([0, -bucket_height, 150]) cube([bucket_d_top, 500, bucket_d_top], center=true);
        translate([0,10,0]) bucket();
        translate([0, 0, 150+30]) cube([bucket_d_top, 500, bucket_d_top], center=true);
    }
}


module bucket() {
    translate([0, -90, 150])
        rotate([-90,0,0])
            cylinder(
                h = bucket_height,
                d1 = bucket_d_bottom,
                d2 = bucket_d_top,
                center = true
             );
}
