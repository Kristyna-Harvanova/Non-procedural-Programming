% Let the Prolog atoms 'zero' and 'one' denote the binary digits 0 and 1. We may use a series of variables to denote a binary number. For example,

%     X3 = one, X2 = zero, X1 = zero, X0 = one

% represents 1001 (in base 2) which equals 9 (in base 10).

% Write a Prolog predicate

%     add(X3, X2, X1, X0, Y3, Y2, Y1, Y0, Z4, Z3, Z2, Z1, Z0)

% that is true if

%     (X3 X2 X1 X0) + (Y3 Y2 Y1 Y0) = (Z4 Z3 Z2 Z1 Z0)

% where all variables are the atoms 'zero' or 'one', and groups of variables represent binary numbers as in the example above.

% Because Prolog predicates work bidirectionally, your predicate will be able to perform subtraction as well as addition.

% Note: In theory, you could solve the exercise by listing 256 different facts. However, I will not accept any such answer. (A solution in fewer than 20 lines is possible.)

% Important: Do not use any Prolog numbers or lists in this exercise. All variables must hold only atoms.

% Example:

% ?- add(zero, one, zero, one, zero, zero, one, one, Z4, Z3, Z2, Z1, Z0).
% Z4 = Z2, Z2 = Z1, Z1 = Z0, Z0 = zero,
% Z3 = one .
% Explanation: 5 + 3 = 8.

% Example #2:

% ?- add(X3, X2, X1, X0, zero, zero, one, one, zero, one, zero, zero, zero).
% X3 = X1, X1 = zero,
% X2 = X0, X0 = one ;
% Explanation: The solution to the equation X + 3 = 8 is X = 5.

% Example #3:

% ?- add(X3, X2, X1, X0, Y3, Y2, Y1, Y0, one, one, one, one, one).
% false.
% Explanation: There are no two four-bit numbers X and Y such that X + Y = 31.

binary_digit(zero).
binary_digit(one).

binary_number(A3, A2, A1, A0) :-
    binary_digit(A3),
    binary_digit(A2),
    binary_digit(A1),
    binary_digit(A0).

binary_result(A4, A3, A2, A1, A0) :-
    binary_digit(A4),
    binary_digit(A3),
    binary_digit(A2),
    binary_digit(A1),
    binary_digit(A0).

% add_digit(A, B, C, D, E) ... A + B + C = D, carry E, where C is previous carry
add_digit(zero, zero, zero, zero, zero).
add_digit(zero, zero, one, one, zero).
add_digit(zero, one, zero, one, zero).
add_digit(zero, one, one, zero, one).
add_digit(one, zero, zero, one, zero).
add_digit(one, zero, one, zero, one).
add_digit(one, one, zero, zero, one).
add_digit(one, one, one, one, one).

add(X3, X2, X1, X0, Y3, Y2, Y1, Y0, Z4, Z3, Z2, Z1, Z0) :-
    binary_number(X3, X2, X1, X0),
    binary_number(Y3, Y2, Y1, Y0),
    add_digit(X0, Y0, zero, Z0, C0),
    add_digit(X1, Y1, C0, Z1, C1),
    add_digit(X2, Y2, C1, Z2, C2),
    add_digit(X3, Y3, C2, Z3, Z4),
    binary_result(Z4, Z3, Z2, Z1, Z0).
