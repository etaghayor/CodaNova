open Core
open Ast
open Ast_utils
open Utils
open Typecheck
open Dsl

let () =
  (* let a = * in
  (λx:{ v:F | True}
  let _ = assert (a=1) in a )
  (let _ = assert (a=2) in a) *)
  (*TODO: Change "_"*)
  let expr = 
    LetIn ("a", star, 
      App (
        LamA ("x", tf, 
          LetIn("b", Assert (Var "a", f1), Var "a")
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
(*   
  let _ = Typecheck.(S.run {cs= []; gamma=[];alpha= []; delta= []}
              (check expr2 (refine_expr tf (eq nu f1)))) in () *)

  let t, _ = Typecheck.run_synthesis expr  in

  let t' = normalize t in

  print_endline ("Type of e:\n" ^(show_typ t)) ;

  print_endline ("\n Normal Type of e:\n" ^(show_typ t'))
  
  ;
  print_endline "\nStart Checking:\n";

  pc (run_checking expr t') ~filter:true

