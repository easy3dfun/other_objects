$fn=100;

mount_w = 70;
mount_h = 50;
mount_d = 5;

stick_distance = 20; // Distance of each stick from the center

bucket_height   = 235;
bucket_d_top    = 268;
bucket_d_bottom = 195;

// bucket();

tolerance = 0.1;

difference() {
    new_holder();
    translate([0, -1.5, -3]) bucket_holder(10+tolerance, 10+tolerance, 90);
}


module new_holder() {
    difference() {
        color ([1,0,0]) rim();
        translate([0,-12.4,0])
        rotate([-30,0,0])
        cube([1000,10,1000], center=true);
    }

    difference() {
        sticks (12.4, 12.4, 90);
        bucket();
     }
}

module rim() {
    translate([0,-5,0])
    difference() {
        bucket();
        translate([0, -bucket_height, 150]) cube([bucket_d_top, 500, bucket_d_top], center=true);
        translate([0,10,0]) bucket();
        translate([0, 0, 150+30]) cube([bucket_d_top, 500, bucket_d_top], center=true);
    }
}

// --------------------------------------------------
// Original Bucket holder
// --------------------------------------------------

module bucket_holder(sw=10, sh=10, sd=90) {
    color([0.5, 0.5, 0.5]) cube([mount_w, mount_h, mount_d], center=true);

    color([0.5, 0.5, 0.5])  difference() {
        sticks(sw, sh, sd);
        bucket();
    }
}

module sticks(w=10, h=10, d=90) {
    translate([ stick_distance, 0, 0]) stick(w, h, d);
    translate([-stick_distance, 0, 0]) stick(w, h, d);
}

module stick(w=10, h=10, d=90) {
    intersection() {
        rotate([ 60, 0, 0])
            cube([w, d, h], center=true);
        translate([0, 0, 20])
            cube([mount_w, mount_h, 40], center=true);
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
