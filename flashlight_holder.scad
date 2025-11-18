$fs=0.5;
$fa=1;

grip_thickness = 4;

difference() {
  translate([5,0,0]) cube([22, 27+grip_thickness, 20], center=true);
  union() {
    cylinder(h=100, d=27, center=true);
    translate([10, 11, 0])
        cylinder(h=100, d=5, center=true);
    translate([10, -11, 0])
        cylinder(h=100, d=5, center=true);
  };
}