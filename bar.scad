color([0,1,0,0.5]) thePart();

translate([-25, 0, 0])
  connector(13, 11, 30);

module connector(w, d, h) {
    color([0,0,1,0.5])
          cube([w, d, h], center=true);
    roof_size = (1/sqrt(2)) * w;
    color([1,0,0,0.5])
        translate([0, 0, h/2])
            rotate([0,45,0])
                cube([roof_size, d, roof_size], center=true);
}

// The part of which we want to connect multiple of
// Just a 17x15x50mm large bar
module thePart() {
      cube([17, 15, 50], center=true);
}