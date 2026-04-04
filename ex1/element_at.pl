element_at(H, [H|_], 1).
element_at(X, [_|T], K) :- 
    K_1 is K - 1,
    element_at(X, T, K_1).