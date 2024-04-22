
% const(white_cross_1, cube(
%     _, w, _, w, w, w, _, w, _,
%     _, _, _, _, _, _, _, _, _,
%     _, _, _, _, _, _, _, _, _,
%     _, _, _, _, _, _, _, _, _,
%     _, _, _, _, _, _, _, _, _,
%     _, _, _, _, _, _, _, _, _)).

white_cross_1(cube(
    _, w, _, w, w, w, _, w, _,
    _, _, _, _, _, _, _, _, _,
    _, _, _, _, _, _, _, _, _,
    _, _, _, _, _, _, _, _, _,
    _, _, _, _, _, _, _, _, _,
    _, _, _, _, _, _, _, _, _)).

% const(white_cross_2, cube(
%     _, w, _, w, w, w, _, w, _,
%     _, g, _, _, g, _, _, _, _,
%     _, r, _, _, r, _, _, _, _,
%     _, b, _, _, b, _, _, _, _,
%     _, o, _, _, o, _, _, _, _,
%     _, _, _, _, _, _, _, _, _)).

white_cross_2(cube(
    _, w, _, w, w, w, _, w, _,
    _, g, _, _, g, _, _, _, _,
    _, r, _, _, r, _, _, _, _,
    _, b, _, _, b, _, _, _, _,
    _, o, _, _, o, _, _, _, _,
    _, _, _, _, _, _, _, _, _)).

% const(white_corners_1, cube(
%     w, w, _, w, w, w, _, w, _,
%     g, g, _, _, g, _, _, _, _,
%     _, r, _, _, r, _, _, _, _,
%     _, b, _, _, b, _, _, _, _,
%     _, o, o, _, o, _, _, _, _,
%     _, _, _, _, _, _, _, _, _)).

white_corners_1(cube(
    w, w, _, w, w, w, _, w, _,
    g, g, _, _, g, _, _, _, _,
    _, r, _, _, r, _, _, _, _,
    _, b, _, _, b, _, _, _, _,
    _, o, o, _, o, _, _, _, _,
    _, _, _, _, _, _, _, _, _)).

% const(white_corners_2, cube(
%     w, w, _, w, w, w, w, w, _,
%     g, g, g, _, g, _, _, _, _,
%     r, r, _, _, r, _, _, _, _,
%     _, b, _, _, b, _, _, _, _,
%     _, o, o, _, o, _, _, _, _,
%     _, _, _, _, _, _, _, _, _)).

white_corners_2(cube(
    w, w, _, w, w, w, w, w, _,
    g, g, g, _, g, _, _, _, _,
    r, r, _, _, r, _, _, _, _,
    _, b, _, _, b, _, _, _, _,
    _, o, o, _, o, _, _, _, _,
    _, _, _, _, _, _, _, _, _)).

% const(white_corners_3, cube(
%     w, w, _, w, w, w, w, w, w,
%     g, g, g, _, g, _, _, _, _,
%     r, r, r, _, r, _, _, _, _,
%     b, b, _, _, b, _, _, _, _,
%     _, o, o, _, o, _, _, _, _,
%     _, _, _, _, _, _, _, _, _)).

white_corners_3(cube(
    w, w, _, w, w, w, w, w, w,
    g, g, g, _, g, _, _, _, _,
    r, r, r, _, r, _, _, _, _,
    b, b, _, _, b, _, _, _, _,
    _, o, o, _, o, _, _, _, _,
    _, _, _, _, _, _, _, _, _)).

% const(white_corners_4, cube(
%     w, w, w, w, w, w, w, w, w,
%     g, g, g, _, g, _, _, _, _,
%     r, r, r, _, r, _, _, _, _,
%     b, b, b, _, b, _, _, _, _,
%     o, o, o, _, o, _, _, _, _,
%     _, _, _, _, _, _, _, _, _)).

white_corners_4(cube(
    w, w, w, w, w, w, w, w, w,
    g, g, g, _, g, _, _, _, _,
    r, r, r, _, r, _, _, _, _,
    b, b, b, _, b, _, _, _, _,
    o, o, o, _, o, _, _, _, _,
    _, _, _, _, _, _, _, _, _)).

% const(middle_layer_1a, cube(        
%     _, w, w, w, w, w, w, w, w,
%     _, g, g, _, g, _, g, g, _,
%     r, r, r, _, r, _, _, _, _,
%     b, b, b, _, b, _, _, _, _,
%     o, o, _, _, o, _, _, _, w,
%     _, _, _, o, _, _, o, _, _)).

% const(middle_layer_1b, cube(
%     w, w, w, w, w, w, w, w, w,
%     g, g, g, g, g, _, _, _, _,
%     r, r, r, _, r, _, _, _, _,
%     b, b, b, _, b, _, _, _, _,
%     o, o, o, _, o, o, _, _, _,
%     _, _, _, _, _, _, _, _, _)).

% const(middle_layer_2a, cube(
%     w, w, w, w, w, w, _, w, w,
%     g, g, _, g, g, _, _, _, w,
%     _, r, r, _, r, _, r, r, _,
%     b, b, b, _, b, _, _, _, _,
%     o, o, o, _, o, o, _, _, _,
%     g, g, _, _, _, _, _, _, _)).

% const(middle_layer_2b, cube(
%     w, w, w, w, w, w, w, w, w,
%     g, g, g, g, g, g, _, _, _,
%     r, r, r, r, r, _, _, _, _,
%     b, b, b, _, b, _, _, _, _,
%     o, o, o, _, o, o, _, _, _,
    % _, _, _, _, _, _, _, _, _)).

middle_layer_2b(cube(
    w, w, w, w, w, w, w, w, w,
    g, g, g, g, g, g, _, _, _,
    r, r, r, r, r, _, _, _, _,
    b, b, b, _, b, _, _, _, _,
    o, o, o, _, o, o, _, _, _,
    _, _, _, _, _, _, _, _, _)).

% const(middle_layer_3a, cube(
%     w, w, w, w, w, w, w, w, _,
%     g, g, g, g, g, g, _, _, _,
%     r, r, _, r, r, _, _, _, w,
%     _, b, b, _, b, _, b, b, _,
%     o, o, o, _, o, o, _, _, _,
%     _, _, r, _, _, r, _, _, _)).

% const(middle_layer_3b, cube(
%     w, w, w, w, w, w, w, w, w,
%     g, g, g, g, g, g, _, _, _,
%     r, r, r, r, r, r, _, _, _,
%     b, b, b, b, b, _, _, _, _,
%     o, o, o, _, o, o, _, _, _,
%     _, _, _, _, _, _, _, _, _)).

% const(middle_layer_4a, cube(
%     w, w, _, w, w, w, w, w, w,
%     g, g, g, g, g, g, _, _, _,
%     r, r, r, r, r, r, _, _, _,
%     b, b, _, b, b, _, _, _, w,
%     _, o, o, _, o, o, o, o, _,
%     _, _, _, _, _, _, _, b, b)).

% const(middle_layer_4b, cube(
%     w, w, w, w, w, w, w, w, w,
%     g, g, g, g, g, g, _, _, _,
%     r, r, r, r, r, r, _, _, _,
%     b, b, b, b, b, b, _, _, _,
%     o, o, o, o, o, o, _, _, _,
%     _, _, _, _, _, _, _, _, _)).

middle_layer_4b(cube(
    w, w, w, w, w, w, w, w, w,
    g, g, g, g, g, g, _, _, _,
    r, r, r, r, r, r, _, _, _,
    b, b, b, b, b, b, _, _, _,
    o, o, o, o, o, o, _, _, _,
    _, _, _, _, _, _, _, _, _)).

% const(yellow_cross_1, cube(
%     w, w, w, w, w, w, w, w, w,
%     g, g, g, g, g, g, _, _, _,
%     r, r, r, r, r, r, _, _, _,
%     b, b, b, b, b, b, _, _, _,
%     o, o, o, o, o, o, _, _, _,
%     _, _, _, y, y, y, _, _, _)).

% const(yellow_cross_1, cube(
%     w, w, w, w, w, w, w, w, w,
%     g, g, g, g, g, g, _, _, _,
%     r, r, r, r, r, r, _, _, _,
%     b, b, b, b, b, b, _, _, _,
%     o, o, o, o, o, o, _, _, _,
%     _, y, _, _, y, _, _, y, _)).

yellow_cross_1(cube(
    w, w, w, w, w, w, w, w, w,
    g, g, g, g, g, g, _, _, _,
    r, r, r, r, r, r, _, _, _,
    b, b, b, b, b, b, _, _, _,
    o, o, o, o, o, o, _, _, _,
    _, y, _, _, y, _, _, y, _)).

% const(yellow_cross_2, cube(
%     w, w, w, w, w, w, w, w, w,
%     g, g, g, g, g, g, _, _, _,
%     r, r, r, r, r, r, _, _, _,
%     b, b, b, b, b, b, _, _, _,
%     o, o, o, o, o, o, _, _, _,
%     _, y, _, y, y, y, _, y, _)).

yellow_cross_2(cube(
    w, w, w, w, w, w, w, w, w,
    g, g, g, g, g, g, _, _, _,
    r, r, r, r, r, r, _, _, _,
    b, b, b, b, b, b, _, _, _,
    o, o, o, o, o, o, _, _, _,
    _, y, _, y, y, y, _, y, _)).

% const(yellow_corners_1, cube(
%     w, w, w, w, w, w, w, w, w,
%     g, g, g, g, g, g, _, _, _,
%     r, r, r, r, r, r, _, _, _,
%     b, b, b, b, b, b, _, _, _,
%     o, o, o, o, o, o, _, _, _,
%     y, y, y, y, y, y, y, y, y)).

yellow_corners_1(cube(
    w, w, w, w, w, w, w, w, w,
    g, g, g, g, g, g, _, _, _,
    r, r, r, r, r, r, _, _, _,
    b, b, b, b, b, b, _, _, _,
    o, o, o, o, o, o, _, _, _,
    y, y, y, y, y, y, y, y, y)).

% const(yellow_corners_2, cube(
%     w, w, w, w, w, w, w, w, w,
%     g, g, g, g, g, g, g, _, g,
%     r, r, r, r, r, r, r, _, r,
%     b, b, b, b, b, b, b, _, b,
%     o, o, o, o, o, o, o, _, o,
%     y, y, y, y, y, y, y, y, y)).

yellow_corners_2(cube(
    w, w, w, w, w, w, w, w, w,
    g, g, g, g, g, g, g, _, g,
    r, r, r, r, r, r, r, _, r,
    b, b, b, b, b, b, b, _, b,
    o, o, o, o, o, o, o, _, o,
    y, y, y, y, y, y, y, y, y)).

% const(yellow_edges, cube(
%     w, w, w, w, w, w, w, w, w,
%     g, g, g, g, g, g, g, g, g,
%     r, r, r, r, r, r, r, r, r,
%     b, b, b, b, b, b, b, b, b,
%     o, o, o, o, o, o, o, o, o,
%     y, y, y, y, y, y, y, y, y)).

yellow_edges(cube(
    w, w, w, w, w, w, w, w, w,
    g, g, g, g, g, g, g, g, g,
    r, r, r, r, r, r, r, r, r,
    b, b, b, b, b, b, b, b, b,
    o, o, o, o, o, o, o, o, o,
    y, y, y, y, y, y, y, y, y)).



