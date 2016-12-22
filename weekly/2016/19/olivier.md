* I implemented the `static` keyword; all right-hand sides of static bindings will be executed during compilation. So:

```
  static msg = "Hello"
  static () = print_endline msg
  let () = print_endline "runtime!"
```

  will print "Hello" during compilation and "runtime!" when it's run.
  I only implemented this feature in the bytecode compiler as we decided
  to focus on it for now.

At that point though, sharing static and runtime values is not
explicitely forbidden. So the following program:

```
  let msg = "let-bound"
  static () = print_endline msg
```

would make the compiler crash with a non-informative error message.
* To address that, I split the environment into a static and a runtime part. So the above program would now be rejected with an "Unbound variable" message. That's not very informative either, but a more explicit staging error should be easy to implement later.
* Currently, static bindings cannot refer to other modules than the one being compiled. So the program:

```
  static () = print_endline A.msg
```

  fails with the error "Undefined global A", even if the files `a.cmi`
  and `a.cmo` are in the include path.  The only exception to this are
  the stdlib modules (such as `Printf` and `Pervasives`), because their
  bytecode is contained in the ocamlc program. So there needs to be a
  way to use non-standard modules in static code.

  It appears that this triggers not only implementation question, but
  design issues. For example values from non-static modules should not
  be usable in static code, but the types exported by these modules
  should, otherwise lots of useful macros would be ill-formed. For
  example, when performing a quote:

```
  module M = struct
    type t = T
    let x = T
  end

  macro m () = (<< M.x >> : M.t expr)
```

This very simple macro would be rejected if types weren't shared across stages. So there needs to be a distinct treatment between types and values.

* Finally, the use of lifted modules (i.e. modules exporting non-static values that are used in static code of another module) raises lots of questions, as there can be two versions of a module in the same code: a lifted version and a non-lifted version, as in:

```
  static module M = struct
    type t = T
    let x = T
  end

  module M = struct
    type t = S
    let x = S
  end

  static foo = (M.x : M.t)
```

In `M.x : M.t`, `M.x` refers to the static module, but to which module does `M.t` refer? Since types are shared across stages, this is ambiguous. There are lot of examples where referring to lifted and non-lifted modules using the same name is a problem. I don't fully understand all these examples yet. ^^

That's why Leo White came up with the proposition to make lifting syntactically explicit. For example, the lifted version of a module `Foo` would be `^Foo`.

On the implementation level, this implies to come back on a few changes made previously to the compiler, but it should eventually make implementation easier.
