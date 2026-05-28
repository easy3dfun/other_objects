//> include_bottom watch_bridge.scad
//> include_bottom watch_belt_2.scad

difference() {
    translate([-20.25, 0, 2])
        rotate([240, 0, 90]) watch_bridge(width=13);
    translate([0, 0, 0.3])
        cube([42, 16, 3], center=true);
}

watch_belt();
