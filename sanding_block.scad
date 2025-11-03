difference() {
  cube([60,30,30], center=true);
  translate([  -10,    13, 0]) cube([60, 1, 40], center=true);
  translate([  -10,   -13, 0]) cube([60, 1, 40], center=true);
  translate([-27.5, -14.5, 0]) cube([ 5, 3, 40], center=true);
  translate([-27.5,  14.5, 0]) cube([ 5, 3, 40], center=true);
}
