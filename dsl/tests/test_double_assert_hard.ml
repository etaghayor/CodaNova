open Core
open Ast
open Ast_utils
open Utils
open Typecheck
open Dsl

let () =
  (* let a = * in
    (λx:{ v:F | True}.
      assert (x = 1) in
      x)
    (assert (a = 2) in
      a)
    *)
  (*TODO: Change "_"*)
  let expr = 
    LetIn ("a", star, 
      App (
        LamA ("x", tf, 
          LetIn("b", Assert (Var "x", f1), Var "x")
        ),
        LetIn("c", Assert (Var "a", f2), Var "a")   
      )
    )
  in

  (* let x = e1 in e2 EQUAL
    (Lambda x.e2) e1 *)


  (* let _ = assert (a=1) in a *)
  let e1 = App (LamA ("b", tunit, Var "a") , Assert (Var "a" , f1)) in
  let e2 = App (LamA ("c", tunit, Var "a") , Assert (Var "a" , f2)) in

  let expr2 = 
    App (
      (LamA ("a", tf, 
              App (LamA("x",tf, e1), e2)
            ) 
        ), star
      )
    
  in

  let t, _ = Typecheck.run_synthesis expr  in

  let t' = normalize t in

  print_endline ("Type of e:\n" ^(show_typ t)) ;

  print_endline ("\n Normal Type of e:\n" ^(show_typ t'))
