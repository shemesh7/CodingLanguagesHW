/* The predicate not is already implemented */

and(X, Y):-
    call(X), call(Y).

or(X, Y):-
    call(X) ; call(Y).

xor(X, Y):-
    (call(X), \+ call(Y)) ; (\+ call(X), call(Y)).

nand(X, Y):-
    \+ (call(X), call(Y)).

nor(X,Y):-
    \+ (call(X) ; call(Y)).

equal(X,Y):-
    (call(X), call(Y)) ; (\+ call(X), \+ call(Y)).

bool_val(true).
bool_val(fail).

table(A, B, Expr) :-
    bool_val(A),
    bool_val(B),
    (call(Expr) -> Result = true ; Result = fail),
    write(A), write('  '), write(B), write('  '), write(Result), nl,
    fail.   
    /* the fail at the end makes prolog backtrack and try all the options for A,B */
table(_, _, _). 
/* catches the final backtrack so the query doesn't end with false */