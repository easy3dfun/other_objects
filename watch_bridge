module watch_bridge(
    width=15,
    height=4,
    depth=1.6,
    arch_h=3.2,
    pillar_w=0.8
) {
    difference() {
        // Main body centered on X and Y axes
        translate([0, 0, height/2])
            cube([width, depth, height], center=true);
        
        // Arch cutout centered on X and Y axes
        translate([0, 0, arch_h/2])
            cube([width - (2 * pillar_w), depth + 2, arch_h], center=true);
    }
}
