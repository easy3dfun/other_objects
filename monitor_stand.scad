depth = 180;
width = 40;
h_start = 5;
h_end = 40;

polyhedron(
    points = [
        // bottom face
        [0, 0, 0],                 // 0
        [depth, 0, 0],             // 1
        [depth, width, 0],         // 2
        [0, width, 0],             // 3

        // top face (sloped)
        [0, 0, h_start],           // 4
        [depth, 0, h_end],         // 5
        [depth, width, h_end],     // 6
        [0, width, h_start]        // 7
    ],
    faces = [
        [0, 1, 2, 3],  // bottom
        [4, 5, 6, 7],  // top
        [0, 1, 5, 4],  // front
        [1, 2, 6, 5],  // right
        [2, 3, 7, 6],  // back
        [3, 0, 4, 7]   // left
    ]
);
