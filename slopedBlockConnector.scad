//> include_bottom lib/connector_dovetail.scad
//> include_bottom lib/slopedBlock.scad

slopedBlock();
translate([-5,20,20]) rotate([0,90,0]) connector_dovetail(40,20,5);
