Friday, 2017-01-06 (back from holiday)
======================================

Start working on "lambda quoting" again.

Added the `CamlinternalLambda` file, contains a `lambda` type that resembles
`Lambda.lambda`.

WARNING: Unlike with `CamlinternalAST` types, we do not necessarily want
`CamlinternalLambda.lambda` to be isomorphic to `Lambda.lambda`! E.g. the
`Ident.t` in `Lambda.lambda` is replaced with a simple string in
`CamlinternalLambda`. Instead, we will rely on a trivial function to transform a
`CamlinternalLambda.lambda` into a `Lambda.lambda`. This approach is simpler
than the one used in `CamlinternalAST`.

Week starting on Monday 2017-01-09
==================================

* Re-read Oleg's paper about BER MetaOCaml to understand scope extrusion
  detection checks.
  
  It has been decided that for now, we will leave
  those checks in Parsetree quoting and not try to replicate them in Lambda
  quoting.

* Flick: read stuff about ctypes, try to figure out how to represent processes
  and command blocks.

* Add the `iterate` combinator (translation of Flick for loops) and start
  building the blocks of processes.

* Compiler: add more lambda quoting combinators and move all combinators in a
  Lambda module in `CamlinternalQuote`.

* Fix bug with phase of type extensions, improved the compilation of menhir (in
  the sense that the first error occurs later in the build process). Menhir is
  necessary to build motto.

* Now having a problem with module type discovery. Recall that, for
  compatibility reasons, each module declared in a source file must be deeply
  inspected in case it exports static values or macros. If it is not the case,
  then it is safe not to include it in the static code. This way, we don't add
  useless static dependencies, so that dependency trees are backward-compatible.

* Here, some module types are not found for an unknown reason, entailing
  irrelevant static dependencies and preventing the compilation of Menhir.

* Update other files to Parsetree quoting combinators being moved in a new
  module.

* Keep working on interface discovery.

* Start working on using the lambda combinators to actually construct lambda
  quotes in `Translquote`.

* There is little documentation on the syntax and semantics of Flick. All that
  is available is documentation about Crisp, and sometimes the designs of these
  two languages diverge. For instance, in Crisp, two expressions at the same
  level of indentation separated by a newline, e.g.:
  ```
  expr1
  expr2
  ```
  are evaluated in parallel, whereas in Flick they are evaluated sequentially.

  After speaking with Nik, it would be useful to keep a kind of log of such
  remarks that could be included in Flick's documentation.

* FINALLY found the bug in deep interface inspection: in `Includemod`, the
  environment used for building module coercions should know about the largest
  signature (using `Env.add_signature`), but it wasn't the case.

  Menhir now compiles on the macro switch, and so does motto.
