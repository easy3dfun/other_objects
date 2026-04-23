//> include_bottom lib/connector_dovetail.scad
//> include_bottom lib/slopedBlock.scad

difference() {
    slopedBlock(40, 30, 40, 7.5);
    translate([35, 20, 20]) rotate([0, 90, 0]) connector_dovetail(40, 20, 5, 0.1);
}

translate([-5, 15, 20]) rotate([0, 90, 0]) connector_dovetail(30, 20, 5);
