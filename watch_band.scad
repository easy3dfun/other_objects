//> include_bottom watch_bridge.scad
//> include_bottom watch_belt_2.scad

translate([-20.25, 0, 2])
    rotate([240, 0, 90]) watch_bridge(width=13);

watch_belt();
