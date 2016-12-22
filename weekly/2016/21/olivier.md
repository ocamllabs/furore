* Support for loading static components of external modules was added. This implied compiling the static part of modules to `.cmm` files.
* When using lifted versions of standard modules (e.g. `Printf`), the compiler would load the corresponding `.cmo` file. The problem is that standard modules are already present in the bytecode of `ocamlc` itself, so lifted standard modules were, in a way, loaded twice. In addition of being useless, this second loading would cause problems with side effects implying
buffering (e.g. when using `Printf.printf`, the ordering of outputs was wrong). This
was fixed by adding a function `Symtable.init_static ()` that simply calls `init_toplevel ()` and then adds the lifted version of every global identifier (pointing to the same position in the bytecode) directly into the
symtable. This way, standard modules are not loaded twice, and their use no longer involves reading an external `.cmo` file.
* At that point the produced lambda code was highly unsafe to use because it pointed to runtime and static fields of external modules as though they were in a same record, which could lead to wrong indexes and segfaults. This was fixed for now by adding 0 as a placeholder for non-static (resp.non-runtime) components in `.cmm` (resp. `.cmo`) files. A more sophisticated way might be necessary in the long term.

Limitations:  
* Constrained internal modules (i.e. `module M : sig ... end = struct...`) is not supported by `Translstatic` yet. Nor are functors. These constructions are translated as the unit lambda.
* `Includemod` is still phase-agnostic, so interface mismatches involving values with the right name and the wrong phase will not be detected.
