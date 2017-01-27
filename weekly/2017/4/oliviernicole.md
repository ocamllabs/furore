* Diagnosis of a "problem" with generation of Parsetrees and Lambdas in
  parallel by macros.
  To quote Leo:
  > the best thing to do would be to start by making lambda quoting work on its
  > own without worrying about creating an AST
  > Step two would be to make the extrusion errors in terms of source variables
  > with locations
  > And step three would be to start building the AST again
  > The final version would, instead of producing:
  > ```
  > let splice1 = ... in
  > let splice2 = ... in
  > let ast = ... Field(0, [splice1]) ... Field(0, [splice2]) ... in
  > let lambda = ... Field(1, [splice1]) ... Field(1, [splice2]) ... in
  >   Makeblock [ast; lambda]
  > ```
  > produce something like:
  > ```
  > let splice1 = ref null in
  > let splice2 = ref null in
  > let lambda =
  >   ... (let res = ... in splice1 := Field(1, res); Field(0, res)) ...
  >   ... (let res = ... in splice2 := Field(1, res); Field(0, res)) ...
  > in
  > let ast = ... !splice1 ... !splice2 ... in
  >   Makeblock [lambda; ast]
  > ```
  > This would give us ASTs without any renaming of variables
  > With a bit more work we could probably get renaming as well
* Jeremy and Leo discovered three bugs, noted here for future reference:
  ```
  $ ocaml -dsource
  # static r = ~Pervasives.ref None;;
  static r = (~Pervasives).ref None ;;
  static val r : '_a option ~Pervasives.ref = {~Pervasives.contents = None}
  # let f () = let x = 10 in $(let c = <<x>> in ~Pervasives.(:=) r (Some c); c);;
  let f () =  let x = 10  in $(let c = << x >>  in (~Pervasives).(:=) r (Some c); c) ;;
  splice #1: x val f : unit -> int = <fun>
  # let g () = let x = "Hello world" in $(let open ~Pervasives in match !r with Some c -> c | None -> << 0 >>);;
  let g () = let x = "Hello world" in $(let open ~Pervasives in match !r with Some c -> c | None -> << 0 >>);;
  Warning 26: unused variable x. splice #1: x val g : unit -> int = <fun>
  # g () + 5;;
  - : int = 70275569256653
  ```
  `CamlinternalQuote.Exp.Local` should be used for all identifiers quoted in
  toplevel splices.
  ```
  module M = struct $(<<()>>) end;;
  ```
  results in an "index out of bounds" exception.
  ```
  static print x = ~Pervasives.print_endline x;;
  $(print "one"; <<()>>);;
  $(print "two"; <<()>>);;
  ```
  results in a segfault when put in a file and compiled with `ocamlc`.
* Lambda quoting now works, including path closures but without scope extrusion
  detection. There are still a few bugs to fix in the REPL but the tests show
  that all the other functions have been preserved. It is nice to see that
  macros are quite orthogonal to other features.
