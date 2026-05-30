module watch_belt() {
    /*
      Rounded Open Wall
      Outer Dimensions: 42x16mm, 3mm high, 0.8mm thick.
      One half of the long wall bends outward, the other half bends inward.
    */

    // --- Parameters ---
    length = 42;
    width = 16;
    height = 3;
    thickness = 0.8;

    // How far the bent halves push outward/inward (in mm)
    bend_amount = 1; 

    // How much the bent and unbent walls overlap each other horizontally (in mm)
    // Use a negative number to create a gap instead!
    overlap = 6;

    // 8mm radius makes it a perfect capsule (half-circle ends) for a 16mm width.
    // Decrease this if you want a more rectangular box with rounded corners.
    corner_radius = 4; 


    // --- Internal Calculations ---
    // Calculate the centerline path coordinates
    L_mid = length - thickness;
    W_mid = width - thickness;
    R = corner_radius - thickness/2;
    cx = L_mid/2 - R;
    cy = W_mid/2 - R;

    // Helper function to generate corner arcs
    function arc(x, y, r, a1, a2, steps=24) = 
        [for (i=[0:steps]) 
            [x + r*cos(a1 + (a2-a1)*i/steps), y + r*sin(a1 + (a2-a1)*i/steps)]
        ];

    // Define the continuous path of the wall
    wall_path = concat(
        // 1. Left half of the bottom wall (Bends INWARD)
        [for (i=[0:29]) 
            // t goes from 1 (at the overlapping tip) down to >0 (near the corner)
            let(t = 1 - i/30)           
            
            // x moves leftwards from overlap/2, ending just before -cx
            let(px = -cx + (cx + overlap/2)*t)     
            
            // Uses +bend_amount to push the wall inward towards the center
            let(py = -W_mid/2 + bend_amount*(1-cos(t*90))) 
            [px, py]
        ],
        
        // 2. Bottom-left corner (starts exactly where the inward bend finishes)
        arc(-cx, -cy, R, 270, 180),
        
        // 3. Top-left corner (implicitly connects and draws the left wall)
        arc(-cx, cy, R, 180, 90),
        
        // 4. Top-right corner (implicitly connects and draws the top wall)
        arc(cx, cy, R, 90, 0),
        
        // 5. Bottom-right corner (implicitly connects and draws the right wall)
        arc(cx, -cy, R, 360, 270),
        
        // 6. Right half of the bottom wall (Bends OUTWARD)
        [for (i=[1:30]) 
            let(t = i/30)           // t goes from >0 to 1
            
            // x moves leftwards from the corner, passing 0, and ending at -overlap/2
            let(px = cx - (cx + overlap/2)*t)     
            
            // Uses -bend_amount to push the wall outward away from the center
            let(py = -W_mid/2 - bend_amount*(1-cos(t*90))) 
            [px, py]
        ]
    );

    // --- Modules ---

    // Module to trace a 2D path array with a specific thickness
    module polyline(pts, th) {
        for(i=[0:len(pts)-2]) {
            hull() {
                translate(pts[i]) circle(d=th, $fn=16);
                translate(pts[i+1]) circle(d=th, $fn=16);
            }
        }
    }

    // --- 3D Generation ---
    // Extrude the 2D outline to the specified height
    $fn = 32; // Overall smoothness
    linear_extrude(height=height) {
        polyline(wall_path, thickness);
    }
}
