$fs = 1;

color([0.25,0.5,1])
  translate([-27,-0,-0])
    cubeRounded(10, 21, 26, 4);

difference() {
  cube([60,30,30], center=true);
  translate([  -10,    13, 0]) cube([60, 1, 40], center=true);
  translate([  -10,   -13, 0]) cube([60, 1, 40], center=true);
  translate([-32, -14.5, 0])   cube([15, 3, 40], center=true);
  translate([-32,  14.5, 0])   cube([15, 3, 40], center=true);
}

module cubeRounded(x, y, z, r) {
  minkowski() {
    cube([x-r, y-r, z-r], center=true);
    sphere(r=r);
  }
}