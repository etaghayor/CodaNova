open Core
open Ast
open Ast_utils
open Utils
open Typecheck
open Dsl

let () =
  (* assert (
      let a = * in
        (λx:{ v:F | True}. a)
        (let _ = assert (a=2) in (a+2)
      ,
      4  
  *)
  let subexpr = 
    LetIn ("a", star, 
           App (
             LamA ("x", tf,  v "a"),
             LetIn("_", Assert (v "a", f2), fadd (v "a") f2)   
           )
          )
  in
  let expr = 
    Assert (subexpr, fn 3)
    (* Comp( Eq,
          subexpr,
          fn 3)     *)

  in

  (* let x = e1 in e2 EQUAL
     (Lambda x.e2) e1 *)

  let t, _ = Typecheck.run_synthesis expr  in

  let t' = normalize t in

  print_endline ("Type of e:\n" ^(show_typ t)) ;

  print_endline ("\n Normal Type of e:\n" ^(show_typ t'))

