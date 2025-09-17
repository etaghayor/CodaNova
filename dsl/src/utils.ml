open Core

let todo () = failwith "not implemented"

let todos s = failwith (s ^ ": not implemented")

module StringSet = Set.Make (String)

let curry f a b = f (a, b)

let uncurry f (a, b) = f a b

let ( >> ) f g x = x |> f |> g

let to_numbered ?(init = 0) (l : 'a list) : (int * 'a) list =
  List.init (List.length l) ~f:(fun i -> (i + init, List.nth_exn l i))

module Fresh = struct
  let counter = ref 0

  let gen prefix =
    let id = !counter in
    counter:= id +1 ;
    prefix ^ string_of_int id
end