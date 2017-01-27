* Monday (2016-10-03)  
: With the help of Leo White, I realised that `Int_base` (see prev. worklog)
  should not be set to 0 in the static code. So I just removed the related
  condition in `Translmod`, and this segfault went away. But doing that incurred
  new dependencies from files such as `utils/numbers.ml` to stdlib `cmm` files.
  I moved all `stdlib/*.cmm` files to `boot/` (as was already done with
  `stdlib/*.cmi`) and it seems to do the trick for now.
  Today's issue arose in the following code:
  ```
  (* this introduces a module `T` in scope *)
  include Identifiable.Make (struct (* ... *) end)
  module Pair = Identifiable.Make (Identifiable.Pair (T) (T))
  ```
  Causing a `Bytegen.comp_expr: var T_1712` error.
* Tuesday  
: Removing another `target_phase` condition just made it work. It's quite
  surprising and I am afraid that something might break if I keep applying fixes
  that I don't understand, but I'm too lazy to take it seriously right now.
  But bad news: `ocamldoc/odoc_args.ml` uses first-class modules in way that
  makes the current way of translating modules go wrong:
  ```
  module Html =
    (val
     (
     match !Odoc_args.current_generator with
       None -> (module Odoc_html.Generator : Odoc_html.Html_generator)
     | Some (Odoc_gen.Html m) -> m
     | _ ->
         failwith
           "A non-html generator is already set. Cannot install the Todo-list html generator"
    ) : Odoc_html.Html_generator)
  ;;
  ```
  Simply translating module unpacking (`Tmod_unpack`) fixed that one, but it
  will probably break in certain cases.
  Warning: phase not taken into account when typing recursive modules in
  `Typemod`. (later note: fixed)
* Wednesday  
: Basic examples with static modules work. And even static functors! How amazing
  is that!
  I implemented phase checks for modules, i.e. the compiler raises an error if
  a module identifier of the wrong phase is used in a functor application or a
  binding.
* Thursday  
: Today, I removed all the debug messages printed by the compiler and started to
  write a test suite for macros. For now it only contains very basic checks
  related to static values, quoting, splicing and static modules.
  I also removed the `Translstatic` module, which had become unnecessery, and
  moved its contents to `Translmod`. Doing that enabled me to make the REPL
  compile static modules (prior to that, they were just ignored).
  To-do list for the next days:
  * make `ocamlopt` work again by fixing
    `Translmod.transl_store_implementation`.
  * run all tests on both compilers to see if anything is broken.
  * rebase `macros` on `trunk` (ouuuuch) and run the tests again.
* Friday  
: Remark: one day, I will have to harmonize the behaviour of bytecode and native
  linker. This is not needed for macros to work, but is necessary to have a
  consistent user interface between the two compilers.
  `ocamlopt` compiles again. Testing time!
  A bunch of tests failed this time:
  ```
  Summary:
    551 tests passed
      8 tests skipped
     46 tests failed
      2 unexpected errors
    607 tests considered
  List of failed tests:
      tests/typing-recmod/t19ok.ml
      tests/typing-implicit_unpack/implicit_unpack.ml.reference
      tests/parsing/shortcut_ext_attr.ml.reference
      tests/lib-format/pr6824.ml
      tests/lib-format/tformat.ml
      tests/lib-printf/pr6534.ml
      tests/lib-printf/tprintf.ml
      tests/lib-printf/pr6938.ml
      tests/basic-more/testrandom.ml
      tests/basic-more/tbuffer.ml
      tests/basic-more/opaque_prim.ml
      tests/utils/test_strongly_connected_components.ml
      tests/typing-recmod/t18ok.ml
      tests/basic-more/morematch.ml
      tests/no-alias-deps/aliases.ml.reference
      tests/typing-recmod/t10ok.ml
      tests/lib-scanf
      tests/typing-modules/aliases.ml
      tests/typing-modules-bugs/pr6572_ok.ml
      tests/ppx-attributes/warning.ml
      tests/basic-more/tformat.ml
      tests/basic-more/if_in_if.ml
      tests/lib-threads/torture.ml
      tests/translprim/module_coercion.ml.reference
      tests/basic-more/pr2719.ml
      tests/basic-more/top_level_patterns.ml
      tests/typing-recmod/t22ok.ml
      tests/no-alias-deps/aliases.cmo.reference
      tests/typing-gadts/pr6993_bad.ml
      tests/typing-poly/poly.ml
      tests/parsing/extensions.ml.reference
      tests/parsing/attributes.ml.reference
      tests/lib-str/t01.ml
      tests/basic-more/sequential_and_or.ml
      tests/typing-modules-bugs/pr7182_ok.ml
      tests/misc/weaktest.ml
      tests/typing-recmod/t03ok.ml
      tests/basic-more/function_in_ref.ml
      tests/typing-recmod/t16ok.ml
      tests/basic-more/bounds.ml
      tests/lib-num
      tests/utils/edit_distance.ml
      tests/basic-more/tprintf.ml
      tests/basic-more/pr6216.ml
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
  In comparison, results on the 5th of July were:
  ```
  Summary:
      590 tests passed
        8 tests skipped
        9 tests failed
        1 unexpected errors
      608 tests considered
  List of failed tests:
      tests/typing-recmod/t18ok.ml
      tests/typing-recmod/t10ok.ml
      tests/typing-modules-bugs/pr6572_ok.ml
      tests/ppx-attributes/warning.ml
      tests/typing-recmod/t22ok.ml
      tests/typing-poly/poly.ml
      tests/typing-modules-bugs/pr7182_ok.ml
      tests/typing-recmod/t03ok.ml
      tests/typing-recmod/t06ok.ml
  List of unexpected errors:
      tests/typing-fstclassmod
  List of skipped tests:
      tests/lib-dynlink-csharp
      tests/unwind
      tests/asmcomp/is_static_flambda
      tests/asmcomp/unrolling_flambda
      tests/lib-bigarray-2
  ```
  By taking the diff, I can see that no errors fixed themselves, and which ones
  are new:
  ```
  8a9,22
  >     tests/typing-recmod/t19ok.ml
  >     tests/typing-gadts/pr7230.ml
  >     tests/typing-implicit_unpack/implicit_unpack.ml.reference
  >     tests/parsing/shortcut_ext_attr.ml.reference
  >     tests/lib-format/pr6824.ml
  >     tests/lib-format/tformat.ml
  >     tests/lib-printf/pr6534.ml
  >     tests/lib-printf/tprintf.ml
  >     tests/lib-printf/pr6938.ml
  >     tests/basic-more/testrandom.ml
  >     tests/basic-more/tbuffer.ml
  >     tests/basic-more/opaque_prim.ml
  >     tests/utils/test_strongly_connected_components.ml
  9a24,25
  >     tests/basic-more/morematch.ml
  >     tests/no-alias-deps/aliases.ml.reference
  10a27,28
  >     tests/lib-scanf
  >     tests/typing-modules/aliases.ml
  12a31,38
  >     tests/basic-more/tformat.ml
  >     tests/tool-ocaml/t330-compact-2.ml
  >     tests/basic-more/if_in_if.ml
  >     tests/lib-threads/torture.ml
  >     tests/translprim/module_coercion.ml.reference
  >     tests/basic-more/pr2719.ml
  >     tests/basic-more/top_level_patterns.ml
  >     tests/typing-extensions/extensions.ml.reference
  13a40,41
  >     tests/no-alias-deps/aliases.cmo.reference
  >     tests/typing-gadts/pr6993_bad.ml
  14a43,47
  >     tests/parsing/extensions.ml.reference
  >     tests/parsing/attributes.ml.reference
  >     tests/lib-str/t01.ml
  >     tests/typing-warnings/application.ml.reference
  >     tests/basic-more/sequential_and_or.ml
  15a49
  >     tests/misc/weaktest.ml
  16a51,59
  >     tests/typing-gadts/pr5906.ml
  >     tests/basic-more/function_in_ref.ml
  >     tests/typing-recmod/t16ok.ml
  >     tests/basic-more/bounds.ml
  >     tests/lib-num
  >     tests/typing-gadts/pr7269.ml
  >     tests/utils/edit_distance.ml
  >     tests/basic-more/tprintf.ml
  >     tests/basic-more/pr6216.ml
  17a61
  >     tests/match-exception/match_failure.ml
  19a64
  >     tests/lib-dynlink-bytecode
  ```
  Several failures seem due to include path problems, causing `Unbound modules`
  errors.

