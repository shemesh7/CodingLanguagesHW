:- consult('is_prime.pl').

goldbach(N, X, C) :-
    C >= 2,
    K is N - C,
    is_prime(K),
    is_prime(C),
    X = [K, C].

goldbach(N, X, C) :-
    C >= 2,
    C_1 is C - 1,
    goldbach(N, X, C_1).

goldbach(_, [], _).

goldbach(N, X) :-
    C is N - 2,
    once(goldbach(N, X, C)).
