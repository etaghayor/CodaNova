open Core
open Ast
open Ast_utils
open Utils
open Typecheck
open Dsl

let () =
  (* circuit (x : {v:F| T}) -> {v:F | v=2}):
    assert (x = 2) in
    x*)
  let expr = 
    LetIn ("_", Assert (v "x", f2), v "x" ) in
  let circ = Circuit {name = "c";
              inputs = [("x", tf)];
              outputs = [("o",refine tf (QExpr(eq nu f2)))];
              dep = None;
              body = expr}
  in
  ()
  (* Utils: *)
  (* let x = e1 in e2 EQUAL
     (Lambda x.e2) e1 *)
  (* let _ = assert (a=1) in a *)

  (* let t, _ = Typecheck.typ circ in

  let t' = normalize t in

  print_endline ("Type of e:\n" ^(show_typ t)) ;

  print_endline ("\n Normal Type of e:\n" ^(show_typ t')) *)
(* 
  ;
  print_endline "\nStart Checking:\n";

  pc (run_checking expr t') ~filter:true *)

