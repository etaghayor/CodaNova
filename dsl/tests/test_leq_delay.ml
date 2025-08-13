open Core
open Ast
open Ast_utils
open Utils
open Typecheck
open Dsl

let () =
  (* let a = * in
     let res = (λx:{ v:F | v > 0}.x ) a in
     assert (res = 0)
  *)
  let expr = 
    LetIn ("a", star, 
           LetIn ("res",
                  App (
                    LamA ("x", refine tf 
                            (QExpr (Comp (Lt, f0, nu)))
                         , v "x"
                         )
                    ,
                    v "a"
                  )
                  ,
                  assert_eq (v "res") f0
                 )
          )

  in

  (* let x = e1 in e2 EQUAL
     (Lambda x.e2) e1 *)

  let t, _ = Typecheck.run_synthesis expr  in

  let t' = normalize t in

  print_endline ("Type of e:\n" ^(show_typ t)) ;

  print_endline ("\n Normal Type of e:\n" ^(show_typ t'))

