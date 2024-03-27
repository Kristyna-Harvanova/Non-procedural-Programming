maptree(_, nil).
maptree(P, b(L, X, R)) :-
    call(P, X), maptree(P, L), maptree(P, R).

size(nil, 0, -1).
size(b(L, _, R), S, H) :-
    SP is S - 1, between(0, SP, SL), SR is S - SL - 1,
    HP is H - 1, (HL = HP, between(-1, HP, HR); between(-1, HP, HL), HR = HP, HL \= HR),
    size(L, SL, HL),
    size(R, SR, HR).

decode_char(Key, A, B) :- B is ((A - 97 + Key) mod 26) + 97.

decode_string(_, _, [], []).
decode_string(Key1, Key2, [A|As], [B|Bs]) :-
    decode_char(Key1, A, B),
    decode_string(Key2, Key1, As, Bs).

decode(K1, K2, S1, S2) :-
    string_codes(S1, C1),
    decode_string(K1, K2, C1, C2),
    string_codes(S2, C2).

somewhere(A, B) :- member(B, A).

decrypt(Line, Dict, R) :-
    split_string(Line, " ", " ", Words),
    between(0, 25, Key1),
    between(0, 25, Key2),
    maplist(decode(Key1, Key2), Words, Decoded),
    maplist(somewhere(Dict), Decoded),
    atomics_to_string(Decoded, " ", R).