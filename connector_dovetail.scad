module connector_dovetail(
    height = 20
) {
    linear_extrude(height = height, center = true)
        polygon(points = [
            [-3, 0],     // base (narrow)
            [ 3, 0],
            [ 5, 5],    // tip (wide)
            [-5, 5]
        ]);
}
