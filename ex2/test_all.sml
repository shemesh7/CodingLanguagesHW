(* ==========================================
   TESTING FILE: test_all.sml
   Ensure all your other .sml files are in 
   the same directory before running this.
   ========================================== *)

print "\n--- Loading Files ---\n";
use "Insert_at.sml";
use "insert_none_at.sml";
use "add_to_search_tree.sml";
use "table.sml";

print "\n--- Running Tests ---\n";

(* 1. Tests for insert_at *)
val test_insert_at_1 = 
    insert_at #"e" 1 [#"a", #"b", #"c"] = [#"a", #"e", #"b", #"c"];
val test_insert_at_2 = 
    insert_at #"e" 3 [#"a", #"b", #"c"] = [#"a", #"b", #"c", #"e"];
val test_insert_at_3 = 
    insert_at #"e" 0 [#"a", #"b", #"c"] = [#"e", #"a", #"b", #"c"];

(* 2. Tests for insert_none_at *)
val test_insert_none_at_1 = 
    insert_none_at 2 ["a", "b", "c"] = ["a", "b", "None", "c"];
val test_insert_none_at_2 = 
    insert_none_at 0 ["Not None", "Not None", "Not None", "Not None"] = 
    ["None", "Not None", "Not None", "Not None", "Not None"];

(* 3. Tests for add_to_search_tree *)
val tree0 = Empty;
val tree1 = add_to_search_tree tree0 10;
val tree2 = add_to_search_tree tree1 5;
val tree3 = add_to_search_tree tree2 15;

val test_tree_1 = tree1 = Node (10, Empty, Empty);
val test_tree_2 = tree2 = Node (10, Node (5, Empty, Empty), Empty);
val test_tree_3 = tree3 = Node (10, Node (5, Empty, Empty), Node (15, Empty, Empty));

(* 4. Tests for table *)
val expr1 = And (Or (Var "a", Var "b"), And (Var "a", Var "b"));
val expected_table_1 = 
    [([("b", true), ("a", true)], true), 
     ([("b", false), ("a", true)], false),
     ([("b", true), ("a", false)], false), 
     ([("b", false), ("a", false)], false)];

val test_table_1 = table ["a", "b"] expr1 = expected_table_1;

print "\n--- Test Results ---\n";
print ("insert_at tests passed: " ^ Bool.toString (test_insert_at_1 andalso test_insert_at_2 andalso test_insert_at_3) ^ "\n");
print ("insert_none_at tests passed: " ^ Bool.toString (test_insert_none_at_1 andalso test_insert_none_at_2) ^ "\n");
print ("add_to_search_tree tests passed: " ^ Bool.toString (test_tree_1 andalso test_tree_2 andalso test_tree_3) ^ "\n");
print ("table tests passed: " ^ Bool.toString test_table_1 ^ "\n");