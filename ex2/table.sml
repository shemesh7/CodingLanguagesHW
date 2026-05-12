datatype expr =
    Var of string
  | Not of expr
  | And of expr * expr
  | Or of expr * expr;

fun eval env (Var s) =
      (case List.find (fn (k, _) => k = s) env of
         SOME (_, v) => v
       | NONE => false)
  | eval env (Not e) = not (eval env e)
  | eval env (And (e1, e2)) = eval env e1 andalso eval env e2
  | eval env (Or (e1, e2)) = eval env e1 orelse eval env e2;

fun combinations [] = [[]]
  | combinations (v :: vs) =
      let val rest = combinations vs
      in
        map (fn combo => combo @ [(v, true)]) rest @
        map (fn combo => combo @ [(v, false)]) rest
      end;

fun table vars e =
  let val combos = combinations vars
  in map (fn env => (env, eval env e)) combos
  end;
