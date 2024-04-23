
%%% Defining final states of Rubik's cube for parts of the human algorithm to solve it. %%%

white_cross_1(cube(
    _, w, _, w, w, w, _, w, _,
    _, _, _, _, _, _, _, _, _,
    _, _, _, _, _, _, _, _, _,
    _, _, _, _, _, _, _, _, _,
    _, _, _, _, _, _, _, _, _,
    _, _, _, _, _, _, _, _, _)).

white_cross_2(cube(
    _, w, _, w, w, w, _, w, _,
    _, g, _, _, g, _, _, _, _,
    _, r, _, _, r, _, _, _, _,
    _, b, _, _, b, _, _, _, _,
    _, o, _, _, o, _, _, _, _,
    _, _, _, _, _, _, _, _, _)).

white_corners_1(cube(
    w, w, _, w, w, w, _, w, _,
    g, g, _, _, g, _, _, _, _,
    _, r, _, _, r, _, _, _, _,
    _, b, _, _, b, _, _, _, _,
    _, o, o, _, o, _, _, _, _,
    _, _, _, _, _, _, _, _, _)).

white_corners_2(cube(
    w, w, _, w, w, w, w, w, _,
    g, g, g, _, g, _, _, _, _,
    r, r, _, _, r, _, _, _, _,
    _, b, _, _, b, _, _, _, _,
    _, o, o, _, o, _, _, _, _,
    _, _, _, _, _, _, _, _, _)).

white_corners_3(cube(
    w, w, _, w, w, w, w, w, w,
    g, g, g, _, g, _, _, _, _,
    r, r, r, _, r, _, _, _, _,
    b, b, _, _, b, _, _, _, _,
    _, o, o, _, o, _, _, _, _,
    _, _, _, _, _, _, _, _, _)).

white_corners_4(cube(
    w, w, w, w, w, w, w, w, w,
    g, g, g, _, g, _, _, _, _,
    r, r, r, _, r, _, _, _, _,
    b, b, b, _, b, _, _, _, _,
    o, o, o, _, o, _, _, _, _,
    _, _, _, _, _, _, _, _, _)).

middle_layer_2b(cube(
    w, w, w, w, w, w, w, w, w,
    g, g, g, g, g, g, _, _, _,
    r, r, r, r, r, _, _, _, _,
    b, b, b, _, b, _, _, _, _,
    o, o, o, _, o, o, _, _, _,
    _, _, _, _, _, _, _, _, _)).

middle_layer_4b(cube(
    w, w, w, w, w, w, w, w, w,
    g, g, g, g, g, g, _, _, _,
    r, r, r, r, r, r, _, _, _,
    b, b, b, b, b, b, _, _, _,
    o, o, o, o, o, o, _, _, _,
    _, _, _, _, _, _, _, _, _)).

yellow_cross_1(cube(
    w, w, w, w, w, w, w, w, w,
    g, g, g, g, g, g, _, _, _,
    r, r, r, r, r, r, _, _, _,
    b, b, b, b, b, b, _, _, _,
    o, o, o, o, o, o, _, _, _,
    _, y, _, _, y, _, _, y, _)).

yellow_cross_2(cube(
    w, w, w, w, w, w, w, w, w,
    g, g, g, g, g, g, _, _, _,
    r, r, r, r, r, r, _, _, _,
    b, b, b, b, b, b, _, _, _,
    o, o, o, o, o, o, _, _, _,
    _, y, _, y, y, y, _, y, _)).

yellow_corners_1(cube(
    w, w, w, w, w, w, w, w, w,
    g, g, g, g, g, g, _, _, _,
    r, r, r, r, r, r, _, _, _,
    b, b, b, b, b, b, _, _, _,
    o, o, o, o, o, o, _, _, _,
    y, y, y, y, y, y, y, y, y)).

yellow_corners_2(cube(
    w, w, w, w, w, w, w, w, w,
    g, g, g, g, g, g, g, _, g,
    r, r, r, r, r, r, r, _, r,
    b, b, b, b, b, b, b, _, b,
    o, o, o, o, o, o, o, _, o,
    y, y, y, y, y, y, y, y, y)).

yellow_edges(cube(
    w, w, w, w, w, w, w, w, w,
    g, g, g, g, g, g, g, g, g,
    r, r, r, r, r, r, r, r, r,
    b, b, b, b, b, b, b, b, b,
    o, o, o, o, o, o, o, o, o,
    y, y, y, y, y, y, y, y, y)).



