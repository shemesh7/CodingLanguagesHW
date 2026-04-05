and(X, Y):-
    X = true,
    Y = true.

or(X, Y):-
    X = true ; Y = true.

not(X):-
    X = fail.

xor(X, Y):-
    X \= Y.

nand(X, Y):-
    not(and(X, Y)).

nor(X,Y):-
    not(or(X, Y)).

equal(X,Y):-
    X = Y.