datatype 'a binary_tree =
    Empty
  | Node of 'a * 'a binary_tree * 'a binary_tree;

fun add_to_search_tree Empty n = Node (n, Empty, Empty)
  | add_to_search_tree (Node (v, left, right)) n =
      if n < v
      then Node (v, add_to_search_tree left n, right)
      else Node (v, left, add_to_search_tree right n);

(* Part b: Although < is overloaded in SML (works for int, real, string, char),
   SML's type inference defaults to int when it sees < with no other type hints.
   As written, the compiler infers: int binary_tree -> int -> int binary_tree.
   Passing real arguments would cause a Type Mismatch error.

   Option 1 – type annotation (locks the function to real only):
     change "if n < v" to "if (n : real) < (v : real)"

   Option 2 – true polymorphism (pass the comparator as a parameter):
     fun add_to_search_tree _    Empty              n = Node (n, Empty, Empty)
       | add_to_search_tree comp (Node (v, l, r))  n =
           if comp (n, v)
           then Node (v, add_to_search_tree comp l n, r)
           else Node (v, l, add_to_search_tree comp r n);
     (* call with: add_to_search_tree (op <) tree n  for int or real *) *)
asdf - correct the comment before submitting