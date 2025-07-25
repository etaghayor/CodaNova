open Core
open Ast
open Ast_utils
open Utils
open Typecheck
open Dsl

let () =
  (* 
    let x = * in
    assert (
      (λy:{ v:F | True}. x + y) 1
      =
      1
    )
  *)
  (*TODO: Change "_"*)
  let expr = 
    LetIn("x",
          star,
          Assert(
            App(
              LamA("y", tf, fadd (v "x") (v "y")),
              f1),
            f1
          )
         )


  in

  (* let x = e1 in e2 EQUAL
     (Lambda x.e2) e1 *)
  let t, _ = Typecheck.run_synthesis expr  in

  let t' = normalize t in

  print_endline ("Type of e:\n" ^(show_typ t)) ;

  print_endline ("\n Normal Type of e:\n" ^(show_typ t'))

