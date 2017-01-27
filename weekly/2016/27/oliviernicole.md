* Testing of rebased branch and subsequent corrections finished. The remaining test failures are (all but one) due to lack of support for recursive modules, except for an unexpectedly long type error, probably due to the twofold compilation.
* Alain Frisch's native toplevel (`ocamlnat`) now compiles again, but has no macro support.
* Macro support was added to `ocamlopt` (careful, not `ocamlc.opt`). There was almost nothing to do since `ocamlopt` is a bytecode program.
* Installing packages with `opam` is possible again but the fix is very ugly (`ln -s ocamlc ocamlc.opt`). `opam` doesn't seem to support bytecode-only installations.
