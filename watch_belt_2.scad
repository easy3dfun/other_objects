module watch_belt() {
    // Rounded open wall with two opposite-bent overlapping long-side halves

    L = 42;          // Inside length
    W = 16;          // Inside width
    H = 3;           // height
    T = 0.8;         // wall thickness

    corner_r = 3;    // INSIDE corner radius
    
    // Individually controlled bend amounts for each half
    bend_left = 1.75;  // bend amount for the left lower half (inward)
    bend_right = 0;    // bend amount for the right lower half (outward)
    
    overlap = 8;   // how much the two free halves overlap along the length

    corner_steps = 16;

    linear_extrude(H)
        stroke_path(make_path(), T);


    // ---------- shape path ----------

    function make_path() =
        let(
            // Shift centerline outward by half the thickness
            hw = T / 2,
            x  = L/2 + hw,
            y  = W/2 + hw,
            r  = corner_r + hw,

            // Positive overlap means the two free ends pass each other.
            // Bottom side:
            //   outward = negative Y
            //   inward  = positive Y
            left_free_end  = [ overlap/2, -y + bend_left ],  // uses bend_left
            right_free_end = [-overlap/2, -y - bend_right ], // uses bend_right

            bl = [-x+r, -y+r],
            tl = [-x+r,  y-r],
            tr = [ x-r,  y-r],
            br = [ x-r, -y+r]
        )
        concat(
            // start at free end of left lower half, bent inward
            [left_free_end, [-x+r, -y]],

            // bottom-left rounded corner
            arc(bl, r, -90, -180, corner_steps, 1),

            // left side
            [[-x, y-r]],

            // top-left rounded corner
            arc(tl, r, 180, 90, corner_steps, 1),

            // top long side
            [[x-r, y]],

            // top-right rounded corner
            arc(tr, r, 90, 0, corner_steps, 1),

            // right side
            [[x, -y+r]],

            // bottom-right rounded corner
            arc(br, r, 0, -90, corner_steps, 1),

            // end at free end of right lower half, bent outward
            [right_free_end]
        );


    // ---------- helper geometry ----------

    function arc(c, r, a1, a2, steps, skip=0) =
        [
            for (i = [skip:steps])
                let(a = a1 + (a2-a1) * i / steps)
                    [c[0] + r*cos(a), c[1] + r*sin(a)]
        ];


    // Creates a constant-width open wall around a centerline.
    // Uses mitred/straight joins, not rounded joins.
    module stroke_path(p, width) {
        hw = width / 2;
        n = len(p);

        left_pts = [
            for (i = [0:n-1])
                offset_point(p, i, hw)
        ];

        right_pts = [
            for (i = [n-1:-1:0])
                offset_point(p, i, -hw)
        ];

        polygon(concat(left_pts, right_pts));
    }

    function offset_point(p, i, d) =
        let(n = len(p))
        i == 0
            ? p[i] + normal(unit(p[1] - p[0])) * d
        : i == n-1
            ? p[i] + normal(unit(p[i] - p[i-1])) * d
        : miter_point(p[i-1], p[i], p[i+1], d);

    function miter_point(a, b, c, d) =
        let(
            v1 = unit(b - a),
            v2 = unit(c - b),
            n1 = normal(v1),
            n2 = normal(v2),
            m  = unit(n1 + n2),
            q  = d / max(0.0001, m * n2)
        )
        b + m * q;

    function normal(v) = [-v[1], v[0]];

    function unit(v) =
        let(l = norm(v))
        l == 0 ? [0,0] : v / l;
}
