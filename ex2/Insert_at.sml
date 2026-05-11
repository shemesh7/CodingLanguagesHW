fun insert_at elem 0 lst = elem :: lst
  | insert_at elem n (x :: xs) = x :: insert_at elem (n - 1) xs
  | insert_at elem _ [] = [elem];
