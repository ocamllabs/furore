* Module lifting was implemented, i.e. external modules may now be used in static code by simply adding a caret (`^`) to their names, e.g.:

Lifting of module defined inside the compilation unit (via `module M =
struct... end`) is not supported, as the definition of such modules may
depend on values that are only known at runtime. For this reason, only external, compiled modules can be lifted.
* Support for accessing static values of internal modules was added, i.e. the following compiles and prints what is expected:

  ```
  module M = struct
    open ^Pervasives

    static rec take n = function
      | [] -> []
      | x :: xs -> if n > 0 then x :: take (n-1) xs else []

    module N = struct
      static rec l = "0" :: l'
             and l' = "1" :: l
    end
  end

  open ^Pervasives

  static () =
    print_endline @@ ^String.concat "" @@ M.take 10 M.N.l
  ```

Limitations:  
* Static value description in signatures (i.e. `static val x :
some_type`) are supported by the parser, but not handled by the typechecker for now, as it implies modifying `Includemod`. Handling static components in signatures will be necessary for the next step, that is, saving and loading static code from/to external files.

