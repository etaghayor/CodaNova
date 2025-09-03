open Core
open Ast
open Ast_utils
open Utils
open Typecheck
open Dsl
open Notation

let () =
  (* let a = * in
      assert (
        (λx:{ v:F | v > 0}. x+a) 2
     =
        (λy:{ v:F | True}. y) 3
     )
  *)
  let expr = 
    LetIn("a",
          star,
          Assert(
            App(
              LamA("x", refine tf (QExpr (Comp (Lt, f0, nu))), v "x" +% v "a"),
              f2
            ),
            App(
              LamA("y", tf, v "y"),
              fn 3
            )
          )
         )

  in

  (* let x = e1 in e2 EQUAL
     (Lambda x.e2) e1 *)

  let t, _ = Typecheck.run_synthesis expr  in

  let t' = normalize t in

  print_endline ("Type of e:\n" ^(show_typ t)) ;

  print_endline ("\n Normal Type of e:\n" ^(show_typ t'))

