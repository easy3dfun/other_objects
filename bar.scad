part_w = 17;
part_d = 15;
part_h = 50;

connector_h = 30;
connector_w = 13;
connector_d = 11;

connector(connector_w, connector_d, connector_h, part_w, part_d, part_h, false);

difference() {
  color([0,1,0,0.5]) thePart(part_w, part_d, part_h);
  connector(connector_w, connector_d, connector_h, part_w, part_d, part_h, true);
}

module connector(w, d, h, pw, pd, ph, inverse=false) {
  module raw_connector() {
    color([0,0,1,0.5])
          cube([w, d, h], center=true);
    roof_size = (1/sqrt(2)) * w;
    color([1,0,0,0.5])
        translate([0, 0, h/2])
            rotate([0,45,0])
                cube([roof_size, d, roof_size], center=true);
  }
  
  y_shift = inverse ? h/2-ph/2 : h/2+ph/2;
  
  translate([0, 0, y_shift])
    raw_connector();
}

// The part of which we want to connect multiple of
// Just a 17x15x50mm large bar
module thePart(w, d, h) {
      cube([17, 15, 50], center=true);
}