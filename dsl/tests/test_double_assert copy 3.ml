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
    LetIn("x",
          Lam("z", LetIn ("y", star, "z")),
          Assert(
            App(v "x", Const(CInt 1)),
            v "y"
          )
         )

  in

  (* let x = e1 in e2 EQUAL
     (Lambda x.e2) e1 *)

let t, _ = Typecheck.run_synthesis expr  in

let t' = normalize t in

print_endline ("Type of e:\n" ^(show_typ t)) ;

print_endline ("\n Normal Type of e:\n" ^(show_typ t'))

