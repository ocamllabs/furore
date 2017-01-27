* Remove "zero" placeholders for other-phase values in the lambda code. This
  took me most of the week, as I had to phase information to `Path.t`, but also
  to `module_coercion`s.
  This modification should avoid over-approximating the static dependency tree
  as is currently the case. Currently, every run-time dependency is a static
  dependency. Since static dependencies must be compiled before there parent in
  the tree can be compiled, this limitation would break most OCaml projects.
  I expect this work to be finished, I'll do the tests later tonight.
* Talked with Leo about linking and side effects. Maybe, at some point, it will
  be necessary to ban the `static` keyword, unless the effect system is
  integrated into OCaml soon enough.
* In addition to switching the quoting library to producing lambda code, it
  would be good to detect scope extrusion. This would be done by passing
  `CamlinternalQuote.Var.t` to macros, instead of the current `Longident.t loc`.
* Note for later: rename `CamlinternalQuote.Ident` to
  `CamlinternalQuote.Global` and move `lfrommacro` to `Exp`.
