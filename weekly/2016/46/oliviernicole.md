**Monday (2016-11-14)**

Specification of macro closures: the result of translating a macro into lambda
code should be:  
  * if the target phase is 1: the code of the macro itself;  
  * if the target phase is 0: the closure, i.e. a block containing pointers to
    the cross-stage, phase-0 identifiers used in the macro's body.  

  Unrelatedly: discovered a bug in our early form of CSP. This "weak" CSP
  enabled the programmer to quote non-global identifiers *if* the quote was
  "trapped" inside a top-level splice.
  The current implementation is faulty, as it allows to quote simple identifiers
  like `y`, but not compound paths like `M.y`, e.g. the following does not work:

```
  # module M = struct let y = 42 end;;
  (seq
    (apply (field 1 (global Toploop!)) "M/1388"
      (pseudo //toplevel//(1):11-32 (makeblock 0 0)))
    (makearray[addr]))
  (apply (field 1 (global Toploop!)) "M/1388"
    (let (y/1389 =[int] 42)
      (pseudo //toplevel//(1):11-32 (makeblock 0 y/1389))))
  module M : sig val y : int end
  # let x = $(<<M.y>>);;
  >> Fatal error: No global path for identifier
  Fatal error: exception Misc.Fatal_error
```

  Although this early form of CSP should be made redundant by path closures, I
  note this here for future reference.
  Improved printing of macros in signatures (`macro` instead of `static val`).

* Tuesday    
  Generation of `Lfrommacro` identifiers by macro expansion works. Now working
  to make the type-checker handle `Lfrommacro` properly. Quite nicely, there is
  no need to add a constructor to the `Path.t` type, since `Path.Pdot` already
  has an integer field that can be used to represent closure fields.
  Also, the compiler now shows the results of splicing when the options
  `-dsource` or `-dparsetree` are set.

* Wednesday    
  Note: when modifying `CamlinternalQuote` it might be necessary to do `make
  install` to have the changes taken into account in `Translquote`, since
  `Translquote` loads `^CamlinternalQuote` from the standard path unless
  otherwise specified.  
  First examples with path closures working. Deactivated all warnings during
  compilation of splices.  
  Nested macros now work as well.

* Thursday    

  Fix quoting of identifier so that globals are spliced as `Lglobal`. That
  incidentally fix the issue with compound paths (see Monday).
  Fix bug with macro numbering that would trigger segfaults when mixing macros
  and the `include` keyword.
  Replace previous warning deactivation with something cleaner.
  Discovered a bug in the REPL that raises problems with values that exist in
  two phases (i.e. currently, macros and modules that contain static values).
  The current mechanism is:  
  1. The static lambda is compiled and executed and its result is stored in the
     global map of the REPL via `Toploop.set_value`  
  2. The run-time lambda of the same phrase is compiled and executed and its
     result is stored in the same place, thus erasing the previous result.  
  This is fine for entirely static or entirely run-time values, because they
  are "associated" an identifier in one phase only. But it makes macros and
  two-phase modules unusable.  
  To fix that, it was sufficient to split the global map by phase (just as what
  has been done with the symtable).  
  I also ran the test suite and after a few minor fixes all tests are
  successful. There is not yet a proper testing of path closures though.
  Added a string component to `Lfrommacro` to print the name of field (along
  with its position) in a macro closure, for debugging and clarity purposes. The
  drawback is that it exposes internal names that depend on the implementation
  and might confuse the user.

* Friday    
  Talked with Leo about future plans.  
  Banned quoting from outside of macros and splices. As a direct consequence,
  turned `Expr.of_*` functions into macros.

