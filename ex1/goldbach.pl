:- consult('is_prime.pl').

goldbach(_,[], 0).

goldbach(N, X, C) :-
    K is N - C,
    is_prime(K),
    is_prime(C),
    X = [K, C]
    ;
    C_1 is C - 1,
    goldbach(N, X, C_1).

goldbach(N,X) :- 
    C is N - 2,
    goldbach(N, X, C).