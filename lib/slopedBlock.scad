module slopedBlock(
    size_x=40,
    size_y=40,
    size_z=40,
    y_loss=5,
) {
    linear_extrude(height = size_z)
        polygon(points=[
            [0, 0],
            [size_x, 0],
            [size_x, size_y - y_loss],
            [0, size_y],
        ]);
}
