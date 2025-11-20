difference() {
    part1(30);
    translate([29,0,0]) part1(0);
}

module part1(fullsize) {
    difference() {
        cube([50,17,15], center=true);
        translate([-fullsize,0,0]) difference() {
            cube([50,20,20], center=true);
            cube([50,13,11], center=true);
        };
    }
    color([1,0,0])
        translate([-25,0,0])
            rotate([0,45,0])
                cube([7.5,13,7.5], center=true);
}