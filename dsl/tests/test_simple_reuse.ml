open Core
open Ast
open Ast_utils
open Utils
open Typecheck
open Dsl

let () =
  (* let a = * in
     assert (a = 1) in
     assert (a = 2)
  *)
  let expr = 
    LetIn ("a", star, 
           LetIn("_",
                 assert_eq (v "a") f1,
                 assert_eq (v "a") f2
                )
          )
  in

  (* Utils: *)
  (* let x = e1 in e2 EQUAL
     (Lambda x.e2) e1 *)
  (* let _ = assert (a=1) in a *)

  (*   
  let _ = Typecheck.(S.run {cs= []; gamma=[];alpha= []; delta= []}
              (check expr2 (refine_expr tf (eq nu f1)))) in () *)
  (* 
  let init =
    {cs= []; gamma=[];alpha= []; delta= []} in *)

  let t, _ = Typecheck.run_synthesis expr in

  let t' = normalize t in

  print_endline ("Type of e:\n" ^(show_typ t)) ;

  print_endline ("\n Normal Type of e:\n" ^(show_typ t'))
(* 
  ;
  print_endline "\nStart Checking:\n";

  pc (run_checking expr t') ~filter:true *)

