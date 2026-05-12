datatype 'a tree =
    Empty
  | Node of 'a * 'a tree * 'a tree;

fun add_to_search_tree Empty n = Node (n, Empty, Empty)
  | add_to_search_tree (Node (v, left, right)) n =
      if n < v
      then Node (v, add_to_search_tree left n, right)
      else Node (v, left, add_to_search_tree right n);

(* Part b: Although < is overloaded in SML (works for int, real, string, char),
   SML's type inference defaults to int when it sees < with no other type hints.
   As written, the compiler infers: int tree -> int -> int tree.
   Passing real arguments would cause a Type Mismatch error.

   Solution – pass the comparator as a parameter:
     fun add_to_search_tree _ Empty n = Node (n, Empty, Empty)
       | add_to_search_tree comp (Node (v, left, right))  n =
           if comp (n, v)
           then Node (v, add_to_search_tree comp left n, right)
           else Node (v, left, add_to_search_tree comp right n);

   And then the comparator we need to pass for real numbers(floating point) is:
   (op < : real * real -> bool)
   *)
