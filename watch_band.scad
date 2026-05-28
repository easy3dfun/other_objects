//> include_bottom watch_bridge.scad
//> include_bottom watch_belt_2.scad

difference() {
    translate([-20.25, 0, 2])
        rotate([240, 0, 90]) watch_bridge(width=13);
    translate([-18, 0, 1.5])
        cube([5, 16, 4], center=true);
}

watch_belt();
