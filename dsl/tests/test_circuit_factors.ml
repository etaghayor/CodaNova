open Core
open Ast
open Ast_utils
open Utils
open Typecheck
open Dsl

let () =
  (* circuit (x : {v:F| True}):
                    (y : {v:F| True} * z : {v:F| True})
                    =
                    let y = * in
                    let z = * in
                    assert (y.z = x) in
                    (y, z)
                  *)
  let expr = 
    LetIn ("y", star (),
           LetIn("z", star (),
                 LetIn ("_",
                        assert_eq (fmul (v "y") (v "z")) (v "x"),
                        pair (v "y") (v "z")
                       ))) in
  let circ = Circuit {name = "c";
                      inputs = [("x", tf)];
                      outputs = [("y", tf); ("z", tf)];
                      dep = None;
                      body = expr} in

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
 
  let cons = Typecheck.typecheck_circuit [] circ ~liblam:[] in
  pc cons ~filter:true
  (* let t, _ = Typecheck.run_synthesis (functionalize_circ circ) in

  let t' = normalize t in

  print_endline ("Type of e:\n" ^(show_typ t)) ;

  print_endline ("\n Normal Type of e:\n" ^(show_typ t')) *)
(* 
  ;
  print_endline "\nStart Checking:\n";

  pc (run_checking expr t') ~filter:true *)

