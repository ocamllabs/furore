* The integration of Leo White's quoting library, as well as the implementation of top-level splicing, were completed. As a consequence, it is now possible to compile programs containing macros as long as CSP is not needed (except CSP for global identifiers which comes for free), for example:

```
  open ^Pervasives
  static rec power' n x =
    if n = 0 then
      << 1 >>
    else if n mod 2 = 0 then
      let y = power' (n/2) x in
      << let z = $y in Pervasives.( * ) z z >>
    else
      << Pervasives.( * ) $x $(power' (pred n) x) >>

  (* val power' : int -> int expr -> int expr = <fun> *)
  static power n =
    << fun x -> $(power' n <<x>>) >>
  (* val power : int -> (int -> int) expr = <fun> *)
  let power_five = $(power 5)
  (* val power_five : int -> int = <fun> *)
```

* Execution of static bindings and splices was implemented in the REPL. Declaring modules with static components in the REPL is not supported for now.
* The `Expr` module, for phase-invariant `'a -> 'a expr` conversions, was added. Using this module it is for instance possible to write the following function:

```
  static rec range = function
    | 0 -> << [] >>
    | n -> << $(^Expr.of_int n) :: $(range (^Pervasives.pred n)) >>
```

* The tracking of stage (defined as the number of surrounding quotes, minus the number of non-top-level splices) was implemented. It makes it possible to tell whether a identifier in a quote will be usable at the splicing point or whether some form of CSP is needed. Since CSP is not implemented at the moment, when encountering a (non-global) identifier of the wrong stage a type error is thrown. (Type errors don't abruptly stop the program but show pretty-printed errors with the location of the problem).
