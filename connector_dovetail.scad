// =============================================
// SCAD Connector Shapes (Dovetail Style)
// =============================================
// These two modules create a matching dovetail connector ~10 mm in size.
// 
// • male_connector()  → add this to object 2 (union)
// • female_connector() → subtract this from object 1 (difference)
// 
// The dovetail is designed to slide together along the Y-axis.
// Height (protrusion depth) = 10 mm
// Base width (narrow, at attachment surface) = 8 mm
// Top width (wide, at tip) = 12 mm
// Length (along slide direction) = 20 mm (gives a solid connection)
// 
// Usage example:
//   // Object 2 (add male)
//   translate([x, y, z]) male_connector();
//   
//   // Object 1 (subtract female)
//   difference() {
//     your_object1();
//     translate([x, y, z]) female_connector();
//   }
// 
// Place both connectors so their Z=0 plane sits exactly on the mating face of each object.
// The male will protrude +Z, the female will cut +Z into object 1.
// Slide the parts together along Y after printing.

module male_connector() {
    // Male dovetail (added to object 2)
    rotate([90, 0, 0])                  // orient so protrusion is +Z, length along Y
        linear_extrude(height = 20, center = true)   // 20 mm length, centered in Y
            polygon(points = [
                [-8/2, 0],     // base (narrow) at Z = 0
                [ 8/2, 0],
                [12/2, 10],    // tip (wide) at Z = 10 mm
                [-12/2, 10]
            ]);
}

module female_connector() {
    // Female dovetail (subtracted from object 1)
    // Identical geometry to male for perfect fit
    rotate([90, 0, 0])
        linear_extrude(height = 20, center = true)
            polygon(points = [
                [-8/2, 0],
                [ 8/2, 0],
                [12/2, 10],
                [-12/2, 10]
            ]);
}

// Optional: quick preview of both connectors side-by-side
// male_connector();
// translate([30, 0, 0]) female_connector();
