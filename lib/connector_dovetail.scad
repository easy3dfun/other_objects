module connector_dovetail(
    height = 10,
    width  = 10, // width of the wider side
    depth  = 3,
    tolerance = 0 
) {
    w = width + (tolerance * 2);
    d = depth + tolerance;
    tip_w = w - d;

    rotate([90,0,0])
    linear_extrude(height = height + (tolerance * 2), center = true)
        polygon(points = [
            [-w/2, -tolerance], 
            [ w/2, -tolerance],
            [ tip_w/2,  depth],
            [-tip_w/2,  depth],
        ]);
}
