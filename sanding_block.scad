$fs = 1;
$fn = 50;

gap_thickness = 1;

grip_thickness = 1;

block_length = 50;
block_thickness = 30;
socket_length = 10;

color([0.25,0.5,1])
  translate([0,-0,-0])
    intersection() {
      cubeRounded(block_length+5, 21, 26, 4);
      translate([-socket_length/2,0,0]) cube([block_length,100,100], center=true);
    }

difference() {
  cube([50,block_thickness,block_thickness], center=true);
  translate([  -socket_length, 0, 0]) cube([block_length, block_thickness-grip_thickness*2, 999], center=true);
}

module cubeRounded(x, y, z, r) {
  minkowski() {
    cube([x-r, y-r, z-r], center=true);
    sphere(r=r);
  }
}