% In a simple Caesar cipher, each letter is rotated forward in the alphabet by some number of places K. 
% For example, if we encrypt the word 'YES' with K = 3 then we obtain 'BHV'. 
% If the key K is known, the cipher can be decrypted by rotating each letter by the inverse value -K.

% In this assignment, we will consider a slightly more complicated cipher in which there are two keys K1 and K2. 
% To encrypt each word, all letters at odd positions in the word are rotated by K1, and letters at even positions are rotated by K2. 
% For example, if K1 = 1 and K2 = 6 and we encrypt the word "DONUT", we obtain "EUOAU", because
%    D + 1 = E
%    O + 6 = U
%    N + 1 = O
%    U + 6 = A
%    T + 1 = U

% Write a predicate decrypt(+C, +D, -M) that takes an encrypted text C and a list of words D, and produces the original text M. 
% All words in the text have been encrypted with the same keys K1 and K2. Their values are not known, however it is guaranteed 
% that every word in the decrypted text will be in the given list D. All words will contain only lowercase letters in the range 'a' .. 'z'.

% If there is more than one possible answer, your predicate should succeed once for each possibility.

% Example:
% ?- decrypt("jff dufdn qlf", ["pie", "sky", "ice", "cream", "water", "donut"], M).
% M = "ice cream pie"

% Example #2:
% ?- decrypt("dzx tm sj", ["yo", "the", "or", "yes", "run", "no", "out", "up"], M).
% M = "yes or no"

% Example #3:
% ?- decrypt("k l m n", ["a", "b", "c", "d"], M).
% M = "a b c d"

% Hints:
% Yes, Prolog actually has strings, though we have not discussed them in class. The following built-in predicates may be useful:
%  - split_string(+S, " ", " ", -W) will split a string into a list of words W:
% ?- split_string("one fine day", " ", " ", W).
% W = ["one", "fine", "day"].

%  - atomics_to_string(+W, " ", -S) will join a list of words W into a string S:
% ?- atomics_to_string(["one", "fine", "day"], " ", S).
% S = "one fine day".

%  - string_codes(?S, ?C) will convert between a string S and a list of ASCII numbers C. The conversion will work in either direction, as long as at least one of the arguments is instantiated:
% ?- string_codes("abc", L).
% L = [97, 98, 99].

% ?- string_codes(S, [97, 98, 99]).
% S = "abc".

% As a possible way to structure your program, you could write the following predicates:

% % True if word E decrypts to word D using the keys K1 and K2.
% decrypt_word(E, D, K1, K2) :- ...

% % True if words EWords decrypt to DWords (all of which
% % are in the dictionary) using the keys K1 and K2.
% decrypt_all(EWords, Dictionary, DWords, K1, K2) :- ...