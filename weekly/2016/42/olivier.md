* Monday (2016-10-24)
: Still tracking that bug. The facts are the following: the program segfaults
  when trying to dereference a `code_t*` pointer. The value of this pointer has
  been set by the instruction `PUSHGETGLOBAL Pervasives, 48`. The fact that this
  instruction was executed without segfault shows that accessing the field
  labelled `Pervasives` (at that moment) is not an issue. What is an issue is
  the value of field 48.
  Ok, so the problem is that the slot 41, corresponding to `Pervasives`, is
  erased. So an invariant has been violated.
  I understood what the problem is, it's actually very simple: I've tried to
  execute bytecode (using `reify_bytecode`) with a fresh symtable. But that
  resulted in the erasing of the compiler's global data in
  `Symtable.update_global_table`.  So it can be stated that: "to execute
  bytecode directly, the symtable needs to be shared between the executer and
  the executed".
  This bug was introduced by the change I made last Thursday, when I turned an
  `init_static` in `Runstatic` into `init`. I did that for the sake of
  bootstrapping, which otherwise would fail with an `Undefined global` error on
  a built-in exception.
* Tuesday   
: The bug was fixed, along with a few others (see commits for details), and all
  the tests are passed again.
* Wednesday, Thursday, Friday  
: Spent some time working on a staged regular expression matcher, to try macros
  in a "real-world" situation. I simply staged a very simple, higher-order
  representation of regular expressions with continuations. It allowed for some
  compile-time optimizations like:
  ~~~
  # static f = compile @@ (lit "John" +.+ lit "Kevin") *.* lit " likes apples";;
  val f : (str -> bool) expr =
    << fun cs_1  ->
         (cs_1 = "John likes apples") || (cs_1 = "Kevin likes apples") >>
  # static f = compile @@ maybe (lit "A") *.* lit "A" *.* lit "B";;
  val f : (str -> bool) expr =
    << fun cs_2  -> (cs_2 = "AB") || (cs_2 = "AAB") >>
  ~~~

  The performance is unfortunately quite poor, due to the naiveness of the
  initial, higher-order algorithm. In particular, the code size for concatenated
  regexp increases exponentially with the number of regexps. But it has had the
  merit to demonstrate the tractability of macros, since no problem related to
  the macro system arose during development.
