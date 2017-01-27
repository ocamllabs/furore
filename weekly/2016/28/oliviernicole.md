* Automatic loading implemented in the bytecode linker, both at compile-time and for linking of runtime code. Automatic here means that the needed .cmm, .cmo and .cma file are automatically searched for in the include path. It's mainly for convenience reasons now, if it is too big a change it can be suppressed later.
* `ocamlc.opt` should work very soon, I just need to make phase-1 built-in exceptions work.
* I experimented a bit, trying to use macros with the Markup.ml library (with HTML templates in mind). The very simple following code runs and prints "<p>lol</p>":

```
static identity str =
  let open ^Markup in
  let open ^Pervasives in
  let res =
    (string str |> parse_html |> signals |> write_html |> to_string) in
  Expr.of_string res

let () = print_endline $(identity "<p>lol")
```  

I will try writing more useful macros ASAP.
