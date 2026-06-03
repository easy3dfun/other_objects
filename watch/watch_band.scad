//> include_bottom watch_bridge.scad
//> include_bottom watch_belt.scad

difference() {
    translate([-21, 0, 2.5])
        rotate([225, 0, 90]) watch_bridge(width=13,height=5,arch_h=4.2);
    translate([-18, 0, 1.5])
        cube([7, 16, 4], center=true);
}

difference() {
    translate([21, 0, 2.5])
        rotate([225, 0, -90]) watch_bridge(width=13,height=5,arch_h=4.2);
    translate([18, 0, 1.5])
        cube([7, 16, 4], center=true);
}

watch_belt();
