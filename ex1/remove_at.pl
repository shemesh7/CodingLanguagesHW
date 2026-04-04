remove_at(H, [H|T], 1, T).
remove_at(X, [H|T], K, [H|R]) :- 
    K_1 is K - 1,
    remove_at(X, T, K_1, R).