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

let ( ++ ) x fn =
  match x with
  | 0 -> fn ()
  | r -> r

let compare_weekly a b =
  compare a.y b.y ++ fun () ->
  compare a.w b.w

let years = [2017;2016]

let name_of_uid = function
  | "oliviernicole" -> "Olivier Nicole"
  | "avsm" -> "Anil Madhavapeddy"
  | "dinosaure" -> "Romain Calascibetta"
  | "jdjakub" -> "Joel Jakubovic"
  | "ciaran16" -> "Ciaran Lawlor"
  | "engil" -> "Enguerrand Decorne"
  | "philipdexter" -> "Philip Dexter"
  | "let-def" -> "Frédéric Bour"
  | "gemmag" -> "Gemma Gordon"
  | "ilsordo" -> "Maxime Lesourd"
  | "timada" -> "Takayuki Imada"
  | "kayceesrk" -> "KC Sivaramakrishnan"
  | "dra27" -> "David Allsopp"
  | "g2p" -> "Gabriel de Perthuis"
  | "seveneng" -> "Qi Li"
  | "ryanrhymes" -> "Liang Wang"
  | "stedolan" -> "Stephen Dolan"
  | "fondation451" -> "Nicolas Assouad"
  | "sanderspies" -> "Sander Spies"
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
  Fmt.pr "## Summary of activity by author\n\n";
  (* By author *)
  let authors = Hashtbl.create 1 in
  List.iter (fun w -> Hashtbl.add authors w.uid w) all_weeklies;
  let a = Hashtbl.fold (fun k v a -> if List.mem k a then a else k :: a) authors [] in
  List.iter (fun uid ->
    Fmt.pr "### Author %s\n\n" (name_of_uid uid);
    List.iter (fun {uid;w;y} ->
      Fmt.pr "#### Week %d for %s\n\n" w (name_of_uid uid);
        OS.File.read (Fpath.v (Fmt.strf "%d/%d/%s.md" y w uid)) |> R.get_ok |> Fmt.pr "%s\n\n"
    ) (Hashtbl.find_all authors uid |> List.sort compare_weekly)
  ) a;
  Ok ()
