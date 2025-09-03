open Core
open Ast
open Ast_utils
open Utils
open Typecheck
open Dsl

let () =
  (* let a = * in
     let res = (λx:{ v:F | v > 0}.x+1 ) a in
     assert (res = 4)
  *)
  let expr = 
    LetIn ("a", star, 
           LetIn ("res",
                  App (
                    LamA ("x", refine tf 
                            (QExpr (Comp (Lt, f0, nu)))
                         , Ascribe (fadd (v "x") f1, refine tf (QExpr (Comp (Lt, v "x", nu) )))
                         )
                    ,
                    v "a"
                  )
                  ,
                  assert_eq (v "res") (fn 4)
                    )
          )

  in

  (* let x = e1 in e2 EQUAL
     (Lambda x.e2) e1 *)

  let t, _ = Typecheck.run_synthesis expr  in

  let t' = normalize t in

  print_endline ("Type of e:\n" ^(show_typ t)) ;

  print_endline ("\n Normal Type of e:\n" ^(show_typ t'))

