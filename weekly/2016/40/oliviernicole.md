* Monday (2016-10-10)  

Added static modifiers where appropriate in reference files to fix three
  `parsing/` tests.
  More importantly, fixed `bytecomp/bytelink.ml` so that `std_exit.cmo` is
  linked last, which was not the case until then. Number of failed tests fell to
  20.

```
  Summary:
    577 tests passed
      8 tests skipped
     20 tests failed
      2 unexpected errors
    607 tests considered
  List of failed tests:
      tests/typing-recmod/t19ok.ml
      tests/typing-implicit_unpack/implicit_unpack.ml.reference
      tests/basic-more/testrandom.ml
      tests/typing-recmod/t18ok.ml
      tests/no-alias-deps/aliases.ml.reference
      tests/typing-recmod/t10ok.ml
      tests/typing-modules/aliases.ml
      tests/typing-modules-bugs/pr6572_ok.ml
      tests/ppx-attributes/warning.ml
      tests/translprim/module_coercion.ml.reference
      tests/typing-recmod/t22ok.ml
      tests/no-alias-deps/aliases.cmo.reference
      tests/typing-gadts/pr6993_bad.ml
      tests/typing-poly/poly.ml
      tests/typing-modules-bugs/pr7182_ok.ml
      tests/typing-recmod/t03ok.ml
      tests/typing-recmod/t16ok.ml
      tests/lib-num
      tests/typing-recmod/t06ok.ml
      tests/match-exception/match_failure.ml
  List of unexpected errors:
      tests/lib-dynlink-bytecode
      tests/typing-fstclassmod
  List of skipped tests:
      tests/lib-dynlink-csharp
      tests/unwind
      tests/asmcomp/is_static_flambda
      tests/asmcomp/unrolling_flambda
      tests/lib-bigarray-2
```

  Note: the current linker may load/link object files in a different order from
  that given on the command line. That should be avoided.

* Tuesday  

Fix the linker to guarantee that object files are linked in the same order as
  specified on the command line (provided that the command-line arguments are
  topologically-sorted). Removed 2 errors.

```
  Summary:
    579 tests passed
      8 tests skipped
     18 tests failed
      2 unexpected errors
    607 tests considered
  List of failed tests:
      tests/typing-recmod/t19ok.ml
      tests/typing-implicit_unpack/implicit_unpack.ml.reference
      tests/typing-recmod/t18ok.ml
      tests/no-alias-deps/aliases.ml.reference
      tests/typing-recmod/t10ok.ml
      tests/typing-modules/aliases.ml
      tests/typing-modules-bugs/pr6572_ok.ml
      tests/ppx-attributes/warning.ml
      tests/translprim/module_coercion.ml.reference
      tests/typing-recmod/t22ok.ml
      tests/no-alias-deps/aliases.cmo.reference
      tests/typing-gadts/pr6993_bad.ml
      tests/typing-poly/poly.ml
      tests/typing-modules-bugs/pr7182_ok.ml
      tests/typing-recmod/t03ok.ml
      tests/typing-recmod/t16ok.ml
      tests/typing-recmod/t06ok.ml
      tests/match-exception/match_failure.ml
  List of unexpected errors:
      tests/lib-dynlink-bytecode
      tests/typing-fstclassmod
  List of skipped tests:
      tests/lib-dynlink-csharp
      tests/unwind
      tests/asmcomp/is_static_flambda
      tests/asmcomp/unrolling_flambda
      tests/lib-bigarray-2
```

  Fixed segfaults by lifting "CamlinternalMod" module name in `Translmod`, when
  appropriate. Only 6 failures left, even less than after the last testing
  session!

```
  Summary:
    592 tests passed
      8 tests skipped
      6 tests failed
      1 unexpected errors
    607 tests considered
  List of failed tests:
      tests/no-alias-deps/aliases.ml.reference
      tests/translprim/module_coercion.ml.reference
      tests/typing-recmod/t22ok.ml
      tests/no-alias-deps/aliases.cmo.reference
      tests/typing-poly/poly.ml
      tests/match-exception/match_failure.ml
  List of unexpected errors:
      tests/lib-dynlink-bytecode
  List of skipped tests:
      tests/lib-dynlink-csharp
      tests/unwind
      tests/asmcomp/is_static_flambda
      tests/asmcomp/unrolling_flambda
      tests/lib-bigarray-2
```

* Wednesday  

Two other fixes (see commit logs):

```
  Summary:
    594 tests passed
      8 tests skipped
      4 tests failed
      1 unexpected errors
    607 tests considered
  List of failed tests:
      tests/no-alias-deps/aliases.ml.reference
      tests/typing-recmod/t22ok.ml
      tests/no-alias-deps/aliases.cmo.reference
      tests/typing-poly/poly.ml
  List of unexpected errors:
      tests/lib-dynlink-bytecode
  List of skipped tests:
      tests/lib-dynlink-csharp
      tests/unwind
      tests/asmcomp/is_static_flambda
      tests/asmcomp/unrolling_flambda
      tests/lib-bigarray-2
```

  With the help of Leo, I changed the placeholder for classes in static code to
  make `typing-recmod/t22ok.ml` work.

* Thursday  

: Managed to fix all the tests (including the unexpected error), see commit
  logs.
  Started rebasing on branch `4.04`.

* Friday  

: Mark Shinwell remarked that in the case of a branch with so many changes on
  it, doing a rebase is extremely long: conflicts need to be resolved on a
  per-commit basis, and almost all commits trigger conflicts. So I decided to
  rather do a merge.
  The merge is at about 30% progress (building and testing not included).
