not_divisable_by_lower(_,1).
not_divisable_by_lower(N,K) :-
    C is ceiling(N / K),
    not(N / K =:= C),
    K_1 is K-1,
    not_divisable_by_lower(N,K_1).

is_prime(N) :-
    N_2 is ceiling(N / 2),
    not_divisable_by_lower(N, N_2).
