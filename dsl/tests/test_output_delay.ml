open Core
open Ast
open Ast_utils
open Utils
open Typecheck
open Dsl

let () =
  (* let a = * in
     assert (a = 0) in
     ((λx:{ v:F | True}.x ) a) > 0

  *)
  let expr = 
    LetIn ("a", star, 
           LetIn("_", assert_eq (v "a") f0,
                 lt
                   (App (
                       LamA ("x", tf
                            , v "x"),
                       v "a"))
                   f0

                )
          )

  in

  (* let x = e1 in e2 EQUAL
     (Lambda x.e2) e1 *)

  let t, _ = Typecheck.run_synthesis expr  in

  let t' = normalize t in

  print_endline ("Type of e:\n" ^(show_typ t)) ;

  print_endline ("\n Normal Type of e:\n" ^(show_typ t'))

