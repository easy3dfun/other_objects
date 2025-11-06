difference() {
    cube([50,17,15], center=true);
    translate([-15,0,0]) difference() {
        cube([20,20,20], center=true);
        cube([50,13,11], center=true);
    };
}