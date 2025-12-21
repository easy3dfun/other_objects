module tree() {

linear_extrude(height = 1)
polygon(points=[
    [-15, 0],   // bottom left
    [-8, 10],
    [-12, 10],
    [-5, 20],
    [-9, 20],
    [0, 35],    // top
    [9, 20],
    [5, 20],
    [12, 10],
    [8, 10],
    [15, 0],    // bottom right
    [4, 0],     // trunk right
    [4, -8],    // trunk bottom right
    [-4, -8],   // trunk bottom left
    [-4, 0]     // trunk left
]);

}
