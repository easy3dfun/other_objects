module connector_dovetail(
    height = 10,
    width  = 10, // width of the wider side
    depth  = 3,
) {
    tip_w = width - depth;
    rotate([90,0,0])
    linear_extrude(height = height, center = true)
        polygon(points = [
            [-width/2, 0],
            [ width/2, 0],
            [ tip_w/2,  depth],
            [-tip_w/2,  depth],
        ]);
}
