open Core
open Ast
open Ast_utils
open Typecheck
open Dsl


let () =
  (* let a = * in
  (λx:{ v:F | True}
  let _ = assert (a=1) in a )
  (let _ = assert (a=2) in a) *)
  (*TODO: Change "_"*)
  let expr = 
    LetIn ("a", NonDet, 
      App (
        LamA ("x", tf, 
          LetIn("_", Assert (Var "a", zn 1), Var "a")
        ),
        LetIn("_", Assert (Var "a", zn 2), Var "a")   
      )
    )
  in
  let t =
    refine @@ synthesize expr in

  let t' = normalize t in

  print_endline (show_typ t) ;;

  print_endline (show_typ t')
