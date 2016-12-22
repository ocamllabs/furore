#!/usr/bin/env ocamlscript
Ocaml.packs := ["bos";"fpath";"fmt";"rresult"]
--
open Bos
open Rresult
open R.Infix

type weekly = {
  y: int;
  w: int;
  uid: string;
}

let years = [2017;2016]

let name_of_uid = function
  | "olivier" -> "Olivier Nicole"
  | "avsm" -> "Anil Madhavapeddy"
  | "romain" -> "Romain Calascibetta"
  | "joel" -> "Joel Jakubovic"
  | "ciaran" -> "Ciaran Lawlor"
  | "engil" -> "Enguerrand Decorne"
  | "phillip" -> "Philip Dexter"
  | "fred" -> "Frederic Bour"
  | uid -> uid
 
let _ =
  OS.Path.fold ~elements:`Files 
     (fun p acc -> 
       match Fpath.segs p with
       |[y;w;uid] -> begin
         let y = int_of_string y in
         let w = int_of_string w in
         let uid = Fpath.(rem_ext (v uid) |> to_string) in
         let x = {y;w;uid} in
         Fmt.epr "Processing %d / %d : by %s\n" y w uid;
         x :: acc
       end
       |_ -> Fmt.epr "Skipping %a\n" Fpath.pp p; acc
     ) [] (List.map (fun d -> Fpath.v (string_of_int d)) years)
  >>= fun all_weeklies ->
  List.iter (fun year -> 
    Fmt.pr "## Weekly notes for %d\n\n" year;
    for i = 52 downto 0 do
      match List.filter (fun {w;y;_} -> (y=year) && (w=i)) all_weeklies with
      |[] -> ()
      |ents ->
        Fmt.pr "### Week %d\n\n" i;
        List.iter (fun {uid;w;y} ->
          Fmt.pr "#### %s\n\n" (name_of_uid uid);
          OS.File.read (Fpath.v (Fmt.strf "%d/%d/%s.md" y w uid)) |> R.get_ok |> Fmt.pr "%s\n\n"
        ) ents
    done;
  ) years;
  Ok ()
