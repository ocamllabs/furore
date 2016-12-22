We ask our interns to keep a raw worklog/summary of their work each week to make it easier to see and gauge progress. Now all members of the group can see the status of a project, and we can generate monthly project summaries.

## Week 16: April 18th-April 24th

### Romain
* A robust implementation of email (I check with a complete suit test from another implementation in PHP and JavaScript)
* A robust implementation of meta-data of email (the header of email), it's compliant with old and new standard - 822, 2822 and 5322)
* A beginning implementation of multipart email (I implemented Base64 and QuotedPrintable compute for encoded data)
* Implementation of inline encoded data (compliant with the standard 2047)

You can see all at: https://github.com/oklm-wsh/MrMime

## Week 17: April 25th-May 1st

### Romain
* I fixed some bug with parsing of email and header
* I implemented the RFC 5321 (to have a literal domain in an email) and use Ipaddr library for this part
* I implemented the validator website (http://oklm-wsh.github.io/Validator/validator.html) with some tests of email
* I implemented the header fields from RFC 2045
* I attacked the implementation of RFC 2046 (a multipart email)
* I implemented a PPX to inject an IANA database in MrMime project (and I talked about that with Rudy for an integrate of that in Cohttp maybe)

I talked with Richard and I think I will avoid the implementation of RFC 3798 (to permit a long parameter in a Content-Type field) and move fast to the implementation in a unikernel when I finish the multipart. So I think it is the last last RFC (to much RFC ...).

### Enguerrand
* ocaml-tls binding: Separating handling of IOs from the OCaml code: now the C program must handle all IOs (networking, file reading)…
* As of friday this is mostly finished and the handshake from a simple C TLS client is working.
* A working prototype of the binding is to expect by the end of next week.
* Worked on Canopy: Improved CSS, various bugfixes and PR reviews

## Week 18: May 2nd-May 8th
## Week 19: May 9th-May 15th

### Romain
* As you know, I released Syndic 1.5 with ptime to compile in MirageOS. Hannes merged this change in Canopy
* I optimized Decompress and I won 4 MB/s in Inflate
* Jeremy Yallop send me a snippet for Decompress to win 2 MB/s (I didn't try this snippet yet but it is my TODO)
* I came back to MrMime and fixed little bug in multipart parsing
* I reorganized MrMime to have a better interface
* I tried to use ocaml-imap to communicate with my GMail and it's work fine
* But I'm focussing on the test of parsing now so I think the next, I will do just a many test to prove the maturity of MrMime (I already started)
* May be I cook some cookies tomorrow for Monday :)

### Enguerrand
* TLS: Implemented a few simple clients and servers using various C TLS libraries (libtls, mbedtls) to understand their API. Started to implement the binding trying to replicate libtls's interface.
* Various things on Canopy (bugfixes)
* Spent some time playing with Reason (reading the doc, tried to implement a web toplevel for Reason using js_of_ocaml), tried to debug an issue with ocaml-git

### Olivier
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

## Week 20: May 16th-May 22nd

### Romain
* I fixed some little bug with MrMime and the "real world" email
* Firstly, I use a script with fetchmail program to download my email
* But, I implemented a library to communicate with my GMail (with the POP3 protocol), you can see the project: https://github.com/oklm-wsh/Jackson (it's a little project, and it just a prototype to test MrMime)
* So I continue to fix MrMime with the real world and automatize the test suite
* At the same time, I look sessions type and GADT in OCaml to create a tool to describe a protocol (like POP3 or SMTP) with GADT (so a typed protocol), may be if I have a good result with GADT (because it's very complex), I use that for Jackson and for the implementation of SMTP
* So not specifically productive but, step by step, I have a little prototype to communicate with GMail (or another service) and a resilient implementation of email

### Enguerrand
* TLS: Halfway through the binding implementation, the configuration parsing from libtls is now working for ocaml-tls, only things left is writing and reading on sockets and the binding will be complete.

### Olivier
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

## Week 21: May 23rd-May 29th

### Romain
* I updated MrMime with a new program maildir. You can execute this program with ./maildir -p /path/to/your/mails/ -n LFif the newline of your email is LF character (and it's probably your case with mac osx). I retrieve two difficulties about the parsing:
 - The difficulty to predict the end of the email - so may be you catch an infinite loop when you scan your emails
 - The latency with Base64 and QuotedPrintable decoder (because, for each character, we need to try the boundary parser to stop the decoder)
* So you can use the project on two way. The first way is to use maildirbinary. But if you catch a infinite loop for example (or a weird exception), you can try with a specific email with utop -init test.ml(the second way). At this moment, you can compile the project with debug information (with ./configure --enable-trace and make install) and see where MrMime fails. The parsing is resilient with the malformed header. So now, I will implement the pretty-printing of email and prove if the parsing and pretty-printing is bijective (just to be on the safe side).

(you need to configure the project with --enable-teststo get the maildirbinary)

### Olivier
* Support for loading static components of external modules was added. This implied compiling the static part of modules to `.cmm` files.
* When using lifted versions of standard modules (e.g. `Printf`), the compiler would load the corresponding `.cmo` file. The problem is that standard modules are already present in the bytecode of `ocamlc` itself, so lifted standard modules were, in a way, loaded twice. In addition of being useless, this second loading would cause problems with side effects implying
buffering (e.g. when using `Printf.printf`, the ordering of outputs was wrong). This
was fixed by adding a function `Symtable.init_static ()` that simply calls `init_toplevel ()` and then adds the lifted version of every global identifier (pointing to the same position in the bytecode) directly into the
symtable. This way, standard modules are not loaded twice, and their use no longer involves reading an external `.cmo` file.
* At that point the produced lambda code was highly unsafe to use because it pointed to runtime and static fields of external modules as though they were in a same record, which could lead to wrong indexes and segfaults. This was fixed for now by adding 0 as a placeholder for non-static (resp.non-runtime) components in `.cmm` (resp. `.cmo`) files. A more sophisticated way might be necessary in the long term.

Limitations:  
* Constrained internal modules (i.e. `module M : sig ... end = struct...`) is not supported by `Translstatic` yet. Nor are functors. These constructions are translated as the unit lambda.
* `Includemod` is still phase-agnostic, so interface mismatches involving values with the right name and the wrong phase will not be detected.

## Week 22: May 30th-June 5th

### Romain
* I optimized the Base64 decoder but MrMime is slow with QuotedPrintable (but I have an idea to fix that)
* MrMime is more resilient with bad email (like an email without Fromand Dateinformation)
* I fixed some little bug (infinite loop, order of meta-data, multipart inception, unstructured data, and raised exception)
* I retrieved a regression with my test (so, I have a good tests suite) and I fixed this regression - it's a specific problem with a wrong example from the standard RFC 822
* I started the implementation of pretty-printing, so I continue the prototype (I am inspired by the Format module from OCaml standard lib to respect the 80 characters rules)
* I will use an archive from the caml-list (from daniel) to have a good tests suit about the parsing of email (it's a huge example about the old/bad emails)
* So this week, it's just some fixes and a minimal prototype about the pretty-printing :s

### Olivier
* Phase mismatch is now detected in signatures (i.e. the compiler will complain if you try to match a `static val` and a `val`).
* We are now focusing on quoting and splicing. The splicing part involved quite a lot of refactoring in `Translstatic`: `Translstatic` used to translate an implementation file into a lambda creating the module and adding a reference to it in the symtable. Now the lambda generated by `Translstatic` not only creates the module but also returns an array of untyped ASTs, corresponding to all the splicings of code into phase zero (i.e. splicings that are not inside a quotation).
* In a new module `Runstatic`, this static lambda code is run and the splicings are actually reified. They are then used by `Translcore` to "fill" phase-zero splicings every time it encounters one. This approach is implemented and compiles, but not yet thoroughly tested, since to test splicing something has to be quoted, and the quoting library is not integrated into the compiler yet.
* Finally, I started working on integrating the quoting library written by Leo White. The main function `Translquote.quote_expression`, takes a typed tree and returns the lambda code that will generate the isomorphic *untyped* tree at run-time (well, at static run-time). This work is still going on.

Limitations:  
* As stated above splicing is untested for now.
* Because I didn't know whether I should reimplement some parts of `Translmod` in `Translstatic`, module coercions are still not handled by `Translstatic`. So for now, coercing static components of a `.ml` using a `.mli` won't work — the fix is easy but I'm focusing on quoting for now.

## Week 23: June 6th-June 12th

### Romain
* So I focused this week on my abstract for the ICFP (so Richard corrected the paper and I have sent Friday)
* I continue to implement the pretty-printer of MrMime (I implemented without regresssion with my unit test)
* I start to look S/MIME (secure mail) - so may be I will implement with ocaml-tls the secure mail one time

### Enguerrand
* My first step is to take @yallop script to generate ctypes bindings and make it generate some OCaml parse tree instead of generating OCaml sources so I try to find some ways of integrating it easily in a Reason/OCaml flow. One of the goal would be trying to avoid as much as possible fighting with a build system
* I also took some time to finish a Reason js_of_ocaml REPL I started some months ago. We will probably communicate about it soon publicly, but for now it’s available there: https://engil.github.io/reason-web-toplevel/

### Olivier
* The integration of Leo White's quoting library, as well as the implementation of top-level splicing, were completed. As a consequence, it is now possible to compile programs containing macros as long as CSP is not needed (except CSP for global identifiers which comes for free), for example:

```

  open ^Pervasives

​

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

### Philip
My work this summer is about providing approximate programming tools for OCaml programmers. There are several different styles of approximate computing; each requires of their users different technical knowledge of the subject.

As one example, loop perforation is an approximate computing technique where iterations of a loop are skipped in the pursuit of reducing resource usage (be it time or energy). A loop perforation build system will generally have a self tuning step where, given test input and a fitness function from the user, the system can automatically deduce an approximation strategy. Further refinement by the user is indeed an option, but this is a good example of a technique which asks little of its user.

Loop perforation's ease of use leads KC and I to believe that adding a loop perforation system in OCaml is a great first step in the broader plan of supplying a goodie bag of approximation tools.

I have written a ppx extension for loop perforation. It is basic. In writing it I have both learned a lot about ppx extensions and expanded my compiler knowledge. The next steps are to decide whether to implement a self tuning system. If yes: the ppx extension and the self tuning system would make for a decent first release of an approximation system for OCaml. If no: there are other techniques for approximate computing that we can play with before we decide where to spend coding efforts.

We have met with a group in the lab which is interested in prolonging the flight time of their drone operations. It is hard to say whether there is a collaboration opportunity; approximate computing is not always the right tool for the job.

## Week 24: June 13th-June 19th

### Romain
I did some technical updates in MrMime:  
* First, I added an abstraction about the operating system (Windows and Unix)
* I reorganized the project to produce a good low-level API to manipulate an email
* I finished, as you know, the encoder (and I can produce an email now)
* I optimized the Base64 and the QuotedPrintable decoder (with tailcall optimization)
* I finished the pretty-printing of an email
* I fixed some little bugs between the encoder and the decoder
* And I added the support of UTF-8 with the uutfsoftware by daniel - now, I have only 3 errors with 2000 mails (so ~0.15% fails - so MrMime is more resilient)
* I talked with Daniel about the API and the support of UTF-8 (because an email can have many encoding data) and the main thing is to normalize the email on one encoding, the UTF-8. But, for that, I need another software to normalize any encoding to UTF-8 (daniel told me who will do)
* May be, the next week, I will start the SMTP protocol with the unikernel

### Olivier
* I finally implemented support of static components in coercions. Now, module interfaces can be fully constrained (not only a subset consisting only of runtime values).
* As a necessary condition for that change, the code duplication between `Translmod` and `Translstatic` was reduced to a minimum. Now, all `Translstatic` does is create the necessary lambda code to run splices.
* When trying to use external static code in REPL, I realized that the it couldn't work because of the coexistence of ambiguous identifiers in the symbol table (e.g. `Expr` may be bound to the runtime part of the `Expr` module used in runtime code, or the static part of that module used in static code, a problem that doesn't arise in `ocamlc` since only the static parts are run). I am currently working on adding phase information to the symbol table to resolve these ambiguities.

### Philip
A user cannot zealously apply approximate computing strategies to every line of every program they write. This week I have looked through three OCaml programs which I believe can benefit from approximation: 1. A ray tracer 2. A H.261 video decoder 3. The black--scholes algorithm for option pricing

Not all three programs have explicit for-loops---OCaml programmers tend to favor recursion---but all three have perforation opportunity.

My next step is to implement an interactive system which will guide a user in approximating their programs. It will first identify all potential loops/recursive calls in a program which allow perforation. Given this set it will then attempt to find the /best/ combination of perforation. Testing all possible combinations of loop perforation is unfeasible so some heuristics must be developed.

I also spent some time this week working on multicore OCaml. I wet my feet by writing a recursive lock implementation. The code can be found on [github] along with the [issue] requesting the implementation.

[github](https://github.com/ocamllabs/reagents/compare/master...philipdexter:recursive)

[issue](https://github.com/ocamllabs/reagents/issues/2)

## Week 25: June 20th-June 26th

### Romain
* I continue to optimize MrMime and I will use the Bigstring (which is more faster than the String module) with my RingBuffer
* I finished to implement the interface (recommended by david) of my parser combinator (it is the same interface as the angstorm library from seliopou but with a different backend - as you know I use a ring-buffer)
* So I continue the large background work on MrMime and keep the stability (and avoid any regression) with my unit tests. So, nothing impressive but needed to concurrent any other implementation of email :)

### Philip
Our perforation system allows programmers to annotate looping constructs which they believe can benefit from perforation. Compiling an annotated program into an optimized program which uses loop perforation is not straghtforward.

The most difficult task of this system is in finding the optimal perforation configuration. One solution is to profile every possible permutation of configurations. As this is entirely unfeasible the most truly difficult task is finding a heuristic which allows us to prioritize configurations.

After running some subset of all configurations, there will be a smaller subset of optimal configurations which form a time-error tradeoff curve. Our end result would present this graph to the user, allowing them to choose which tradeoff works best for them.

My time this week has been split between converting a black--scholes C implementation to OCaml and a first draft of our perforation program. The perforation program can successfully run different perforation configurations however there are no heuristics involved yet.

## Week 26: June 27th-July 3rd

### Romain
* I continue to improve the interface of MrMime
* I succeed to use the interface of david (it's the same of angstorm project) - now, the user can produce its parser
* I find some littles regressions with my big test (my 2000 emails) - I will fix that
* We can use the bigstring instead the string module now (so, possibly, we can improve the performance - but I need some tests about that)
* I continue to documente the project and after we can have a release of MrMime
* For this week, I will work on Decompress (as Richard advise me) about the performance, I already a PoC from zlib so I will test it.
* I think I continue to work the morning on MrMime (because is just some fixes) and after I work on Decompress.

### Olivier
* Vast changes in the way dependencies of static code are loaded: although `.cmm` files are still automatically loaded from the include path (`-I`), `.cmo` and `.cma` dependencies of static code must now be specified using the `-m` command-line flag. Since dependencies of dependencies must be specified as well, it can lead to rather large compilation commands. This is intended as a backward-compatibility feature, since hopefully dependency management in OCaml should soon evolve to loading `.cmo` files from path during linking, if Leo White's proposal for that gets accepted.

​The changes made to dependency loading involved a bootstrap of the compiler, and a modification of the stdlib makefile (and 3 days of very painful debugging because of a line that hadn't been removed).
* A rebase on `trunk` was performed to avoind falling behind, but some work is necessary to get the native compiler running again (without trying to make it support macros yet) before the testsuite can be run.
* Static and runtime declarations can now be interleaved in the REPL. To achieve this, the symbol table used for linking now carries phase information (i.e. the symtable is now mapping (identifier, phase) pairs to positions in the global data array).
* Cross-stage identifiers may now be quoted inside toplevel splices. To do that, it was necessary to make the typechecker track the top-levelness of the current environment, but also to propagate upwards the set of cross-stage identifiers encountered in the environment. The only missing form of cross-stage persistence (CSP) left to implement is *path closures*.
* Redaction of a report about macros to motivate a second, 6-month internship, starting in September.

### Philip
Our perforation system is ready for initial testing so this week I've mostly worked on running experiments. I translated a swaptions program into OCaml. A lot of time was spent fixing bugs in the translation but once everything was set up I ran it through our loop perforation system and have some initial results.

We haven't quite reproduced the results from the C perforation system in the paper I'm referring to. They show results where a 5x speedup is achieved with only a 1% loss in accuracy. Our system can only produce a 1.2x speedup while losing 5% accuracy. We can get to 2x speedup but we have to sacrifice 40% accuracy. We do not perform the same state space searching as the paper version does so when that is all set up we may be able to reproduce the results.

I'm confident that once we perform the same sort of searches as the C version we can gain similar speedups. This will be an immediate goal of next week.

## Week 27: July 4th-July 10th

### Romain
* I defunctorized Decompress, so the API is more simply and I won 2 Mb/s for the inflate but I losted 2 Mb/s for the deflate
* Now Decompress uses memcpy function instead memmove (standard function used by OCaml), it's a technical aspect but a big technical point about the portability on Decompress (on Xen architecture specifically). So, I talk about that with Jeremy and we think we have no problem and may be it's a good change to improve the performance of Decompress
* I used a project from LexiFy, landmarks (Thomas advised me to use that), and Spacetime from Mark to find the bottleneck in Decompress and I found this Friday. I have an idea to optimize Decompress (again and again) but I think, we found the the big problem about the performance in Decompress (and it converges with Jeremy's idea)

### Olivier
* Testing of rebased branch and subsequent corrections finished. The remaining test failures are (all but one) due to lack of support for recursive modules, except for an unexpectedly long type error, probably due to the twofold compilation.
* Alain Frisch's native toplevel (`ocamlnat`) now compiles again, but has no macro support.
* Macro support was added to `ocamlopt` (careful, not `ocamlc.opt`). There was almost nothing to do since `ocamlopt` is a bytecode program.
* Installing packages with `opam` is possible again but the fix is very ugly (`ln -s ocamlc ocamlc.opt`). `opam` doesn't seem to support bytecode-only installations.

### Philip
This week I have generalized the perforation system to the point where I was able to take an off-the-shelf ocaml implementation of kmeans clustering and run it through the perforation system. The program was able to produce nice, readable results for different configurations [attached image]. However when more than 2 loops are perforated, the data starts becoming very hard to visualize. The system is really smooth but it's still lacking: I had to turn one use of List.iter into a for loop. However, I have created a plan to perforate recursive functions which will allow the system to work on programs which don't use for loops.

This week I also worked with the reagents library for ocaml-multicore. In the beginning of the week I parallelized an existing ray tracer written in OCaml. (The ray tracer also is a good candidate for perforation.) Further, KC and I have discussed working on a lock-free hash table implementation to use in the Hack type checker (written in OCaml). Currently hack use a C hash table implementation strapped on the to OCaml code. Writing a competitive implementation in OCaml would be a great way to show of ocaml-multicore.

### Ciaran
**Monday**   
- Background reading. Refreshing how git works in more detail. Looking at irmin, datakit.
- Reading articles from Thomas Leonard's blog.

**Tuesday**   

Setting up opam / ocaml.
- Installing opam using brew. Following RWO setup guide. Installing core, utop etc via opam. Configuring utop to #require core packages.
- Setting up vim. Installing merlin and creating .merlin file. Installing ocp-indent-vim. Sorting out .vimrc. Installed syntastic, setup to use merlin.

Docker tutorial
- Installed docker. Followed the basic docker tutorial - the basics of images, containers etc.

OCaml
- Reading some more of Thomas Leonard's articles. Reading  RWO.

**Wednesday**  
- Finished reading most of part 1 of RWO. Read some of the later chapters as well, but part 1 covers most of the language features.

Dependencies and utop
- utop doesn't load the init file (.ocamlinit) when loading an ml file from the command line. Using #use loads the init file.
- I expected utop to work with a file that used other modules in the same directory, but it doesn't. It is possible by building first using ocamlbuild and then using #load_rec on the cmo file. Useful for interacting / quickly testing a bit of code split across multiple files.

Lexing and Parsing
- Read the chapter about parsing in RWO and managed to get the very basics working.

**Thursday**  

IOCaml and Hydrogen
- Setting up Hydrogen for Atom as explained on the website. Working with python (although requires running atom via terminal), need to get working with IOCaml. Installed OCaml support for atom using apm install language-ocaml.
- Doesn't work on 4.03 for some reason, requires < 4.03.0. Switching to 4.02.3. (Later on - after updating opam I can install on 4.03)
- Trying to opam install IOCaml fails as it depends on gmp, which it isn't installing automatically. Installed manually with homebrew.
- Still failing as ctypes won't compile - The compilation of ctypes failed at "make XEN=disable libffi.config".
- Installed libffi manually using brew. opam install IOCaml now works.
- IOCaml doesn't work. Jupyter says 0 active kernels. Hydrogen works with python even if jupyter notebook isn't running, so I guess it's using its own instance. IOCaml works by itself from the command line, just not sure how to link with Jupyter or Hydrogen.
- Jupyter doesn't have a kernel spec for IOCaml. I have no idea how to add one.

* There are pages on the IOCaml wiki for adding the kernel spec, but I can't figure it out.

Lexing and Parsing  
- Messing around with ocamllex and Menhir in the afternoon, trying to create a simple template language.
- Decided to try sedlex instead as it supports unicode.
- sedlex won't install for 4.03. Latest version does work on 4.03 but opam isn't seeing it. Trying to figure out how to refresh the repo.
- Can't find much (Later on - did I actually try opam update?). The latest version listed by opam is 1.99.2, but the opam repository online gives 1.99.3.
- Adding PKG sedlex to my .merlin file causes 'Error while running external preprocessor'. Can't figure out what exactly is the problem for now, something to do with the fact sedlex uses ppx?

Sedlex  
- Just trying to lex for now, the template language consists of text and logic parts which need to be lexed differently, so the lexer needs some contextual infomation.
- Managed to get lexing working pretty well for the template language, by using some mutable state. Don't think there is any other way really.

**Friday**

Sedlex  
- I'm currently testing my lexer by building, then going into utop and doing
~~~
    #directory "_build";;
    #load_rec "_build/lexer.cmo";;
~~~
  This lets me quickly test it with different strings without having to rebuild, and lets me see the returned list of tokens.

* Sedlex doesn't let you define regexps using
    `let lid =
      let lid1 = [%sedlex.regexp? R] in
      [%sedlex.regexp lid1]
  as they will be unbound. Currently doing:
    let lid1 = [%sedlex.regexp? R]
    let lid = [%sedlex.regexp lid1]`
  They have their own scope anyway.

* Does defining a function within a function that is called often have a significant performance penalty to defining it outside the function?

**Weekend**
- Messed around with lexing a bit more, got parsing working as well using Menhir. Requires using MenhirLib.Convert API as Menhir is made to work with ocamllex.

### Joel
**Tuesday**

Tried installing OPAM and OCaml etc on Windows:

Follow the instructions on https://github.com/protz/ocaml-installer/wiki, up to the final Sanity Check
`Env var OCAMLLIB` exists, so I "clean it up" - removing it, I assume, from my environment. However I can only do so for my current cmd session using SET, and it doesn't show up in systemwide environment variables so I assume it must be part of my user account's environment. Unfortunately I cannot change or access those; "edit environment variables for your account" shows no dialog, nothing (this has been a problem on my machine for a while, but I've never needed the feature till now). So I decide to unset OCAMLLIB in my Cygwin terminal, as it will at least persist for that session. I get to running opam install depext-cygwinports, but I get errors and unfortunately the others are not able to fix.

Later I open Cygwin terminal again. I forget to source .bashrc and run opam install depext-cygwinports and to my surprise it works. I then opam install zarith batteries stdint etc. and it also works, although I have to use the "fake install" steps in the Troubleshooting section. I then look at https://github.com/realworldocaml/book/wiki/Installation-Instructions and opam install core utop, but I get:
  `[ERROR] core is not available because your system doesn't comply with os != "win32" & ocaml-version = "4.02.3"`

I also read at the beginning of the article that Core is unsupported on Windows. So maybe I will have to go through the hassle of installing an Ubuntu VM after all, since my existing one is at home on my external hard drive.

opam install'd core utop on Ubuntu. Initially had some issues with an older version but fixed them.

**Wednesday**

Begin by installing the next list of packages. During the process I get one

 `Building conf-zlib.1:
   pkg-config zlib
 [ERROR] The compilation of conf-zlib.1 failed`

I later end up with detailed error descriptions (as well as one for cohttp) giving "Out of space" errors - I'd given it the default size of 8GB, and I'd used a fixed-size virtual disk so it can't just be resized!

After wasting time grappling with VirtualBox to accept my new 512GB dynamic vdi, I now need to expand the partition or something. But I know nothing about it, and it involves boot-level munging of irreversible operations and I am seriously not interested in reinstalling the VM along with all the OCaml/OPAM stuff that took absolutely ages yesterday (and will probably take even longer, given my new VDI is dynamic). Instead I resolve to see what I can do in OCaml without zlib or cohttp installed in OPAM.

Not a great deal, it seems. For when I type in utop to my terminal (now using the old 8GB disk) all I get is
Fatal error: unknown C primitive `unix_has_symlink`

I would be surprised if this had anything to do with the lack of zlib or cohttp, since they were opam packages presumably for development. I google a bit, find similar looking errors, and do eval `opam config env`, try again and this time I'm finally in.

And it only took two whole days!

Later, we get to Docker, where I continue getting through Real World OCaml and receive a licence key for Windows 10 Professional - thanks Dr. Titmus.

**Thursday**

I begin the day by attempting the Windows 10 Pro upgrade three times in a row, using the official channels. Frustratingly, each time, after the restart, it appears as if nothing has happened. I'm still on Home. Maybe it would be better after all to just get a computer at Docker and the CL.

I talk to Graham Titmus and download the Win10 Multiple Editions ISO from DreamSpark. It tells me I'll need to burn it to a boot disk, so I go back to Titmus' office to ask - he isn't there, so after a while I go back and e-mail him, continuing with R.W.O in the meantime.

The time comes to run corebuild on my VM. I do so, and I get the "out of memory" error, because I'm still using the 8GB disk. I thought I could get away with it.

Titmus arrives and gives me a disk. I burn the ISO to the disk. I go through the setup process and, after many loooong waits eventually come to the final setup screen. "You have chosen to: install Windows Home" nope, I never chose anything like that, or even had any options. Google told me that the Multiple Editions version contained both Home AND Professional - and that it would ask me which one I would like.

 `C:\WINDOWS\system32>dism /Get-WimInfo /WimFile:D:\sources\install.wim
  Deployment Image Servicing and Management tool
  Version: 10.0.10586.0`

 `Details for image : D:\sources\install.wim`

 `Index : 1
  Name : Windows 10 Pro
  Description : Windows 10 Pro
  Size : 14,516,205,352 bytes`

 `Index : 2
  Name : Windows 10 Home
  Description : Windows 10 Home
  Size : 14,431,121,717 bytes`

The operation completed successfully.

So it does contain Pro. Why didn't it acknowledge this? Perhaps I need to boot from the disc instead.

I can't seem to boot from it. Instead I enter in the new code to System > Activation. This time it takes a LOT longer ... but ultimately ends up just like the other attempts.

I give up. I'll use my VM.

Increased primary partition, shouldn't have any (of the same) problems now.

 `$ eval `opam config env`
  $ opam install -y async yojson core_extended core_bench cohttp async_graphics cryptokit menhir merlin`

 `...`

~~~
 `#=== ERROR while installing conf-zlib.1 =======================================#
  # opam-version 1.2.0
  # os           linux
  # command      pkg-config zlib
  # path         /home/jdj27/.opam/4.03.0/build/conf-zlib.1
  # compiler     4.03.0
  # exit-code    1
  # env-file     /home/jdj27/.opam/4.03.0/build/conf-zlib.1/conf-zlib-5816-d2c37b.env
  # stdout-file  /home/jdj27/.opam/4.03.0/build/conf-zlib.1/conf-zlib-5816-d2c37b.out
  # stderr-file  /home/jdj27/.opam/4.03.0/build/conf-zlib.1/conf-zlib-5816-d2c37b.err`
~~~

Googled, performed some magic, got it to work.

Continuing with RWO, this time much faster and more productively since I now have something to type into.

**Friday**

Just did RWO today, finally, was nice - got through several chapters, now up to chapter 8 (Imperative programming).

### Philip
This week I have generalized the perforation system to the point where I was able to take an off-the-shelf ocaml implementation of kmeans clustering and run it through the perforation system. The program was able to produce nice, readable results for different configurations [attached image]. However when more than 2 loops are perforated, the data starts becoming very hard to visualize. The system is really smooth but it's still lacking: I had to turn one use of List.iter into a for loop. However, I have created a plan to perforate recursive functions which will allow the system to work on programs which don't use for loops.

This week I also worked with the reagents library for ocaml-multicore. In the beginning of the week I parallelized an existing ray tracer written in OCaml. (The ray tracer also is a good candidate for perforation.) Further, KC and I have discussed working on a lock-free hash table implementation to use in the Hack type checker (written in OCaml). Currently hack use a C hash table implementation strapped on the to OCaml code. Writing a competitive implementation in OCaml would be a great way to show of ocaml-multicore.

## Week 28: July 11th-July 17th

### Romain
* I push my big change to MrMime, so Richard launched a test with ~18 000 emails and all emails are ok (we catch no error).
* We find a performance problem (with the multipart and the quoted-printable encoding) but it's a specific problem (so when I have a time, I will fix this problem)
* But, overall, MrMime is more faster (it's the result of improvement of internal buffer)
* After, I worked on Decompress and I defunctorized the project, I optimized the translation between op-code and character and I avoided some closures allocations, but, with all this point, with Jeremy, we can't notice any imrpovement :disappointed:
* So, I will try a deforestation of Decompress and we will see if we have a good result
* For the hackaton, I worked on Decompress, but, as I said, no big change and just some experimentals modifications.
* For the next week, I will start to fix some bug in ocaml-git as Richard advised me. Voilà!

### Olivier
* Automatic loading implemented in the bytecode linker, both at compile-time and for linking of runtime code. Automatic here means that the needed .cmm, .cmo and .cma file are automatically searched for in the include path. It's mainly for convenience reasons now, if it is too big a change it can be suppressed later.
* `ocamlc.opt` should work very soon, I just need to make phase-1 built-in exceptions work.
* I experimented a bit, trying to use macros with the Markup.ml library (with HTML templates in mind). The very simple following code runs and prints "<p>lol</p>":

```

static identity str =

  let open ^Markup in

  let open ^Pervasives in

  let res =

    (string str |> parse_html |> signals |> write_html |> to_string) in

  Expr.of_string res

let () = print_endline $(identity "<p>lol")

```  

I will try writing more useful macros ASAP.

### Philip
This week I split my time under two projects: the continuing of my auto perforator and the datakit project.

The auto perforator is coming along very nicely. There is now a hill climbing algorithm built in which will explore the perforation state space. I have the system working under 3 domains: swaptions, ray tracer, and kmeans. I will give a talk about the system next Tuesday.

The datakit project is under KC's guidance. The idea is to use datakit to power a distributed key-value store. The implementation would be a domain for testing systems which adapt to byzantine errors by changing the strength of their reads into the database.

### Ciaran
**Monday**

IOCaml on 4.03
- Requires ctyptes. ctypes fails due to requiring libffi. There is a message about needing to brew install libffi but I missed it at first. Installed after that.
- Forked and cloned iocaml, followed wiki post on iocaml github to create kernelspec for jupyter:
  `{
  "display_name": "OCaml",
  "language": "ocaml",
  "argv": [
    "<full path to iocaml>/iocaml.top",
    "-object-info",
    "-completion",
    "-connection-file",
    "{connection_file}"
  ]
  }`  
  Had to use the full path to get it to work.    
  Then run "jupyter kernelspec install --name iocaml-kernel `pwd`" inside that directory.  
  And run  
    `DYLD_LIBRARY_PATH= pwd :$DYLD_LIBRARY_PATH && eval opam config env && jupyter notebook --Session.key= --notebook-dir=notebooks`  
  to get jupyter running (again inside the iocaml directory).
- Actually just `jupyter notebook --Session.key=` seems to work fine?
- Hydrogen connects directly to the kernels without going through Jupyter (even though it uses jupyter for the kernelspecs). In atom, trying to use Hydrogen with ocaml code causes it to hang. Running just `jupyter notebook without --Session.key=` causes the server to repeatedly connect and disconnect to the kernel, so this is probably the issue.

**Tuesday**  

IOCaml    
- Used 'apm develop hydrogen' to clone hydrogen as a development plugin, so I can modify it. To use my version I have to start atom with atom --dev.
- Trying to figure out where exactly in Hydrogen the key stuff is set. Adding lots of console.log statements.
- The connection to a kernel is created in kernel.coffee, which uses the config passed in by kernel-manager.coffee.
- KernelManager either generates the config or loads it from ./hydrogen/connection.json in the atom project directory. So you can set key: "" and signature_scheme: "" in the json file, but then every option must be set. This means ports aren't found automatically etc, they must be set manually.
* For now, I'm just hardcoding in the key and scheme into kernel.coffee.
- Trying to do more with iocaml. Need to #require various things, but #use "topfind" doesn't work. That can be fixed by adding a .iocamlinit file to ~, starting it with
~~~
  `let () =
    try Topdirs.dir_directory (Sys.getenv "OCAML_TOPLEVEL_PATH")
    with Not_found -> ()
  ;;
  #use "topfind";;
  #thread;;
  #require "iocaml-kernel.notebook";;
~~~
* The actual ocamlinit doesn't need the above to come before adding other things like #use "topfind". Shouldn't IOCaml load the toplevel path itself?
(Some of Monday and Tuesday is summarised in a gist on github)

**Wednesday**  
- Trying to figure out how iocaml displays data but I can't figure it out. There's something about adjustable type definitions.
- Trying to figure out how hmac stuff works in zmq, but I don't think I'm going to get anywhere. IOCaml is difficult to figure out. Sockets are opened in sockets.ml, messages are sent and received though message.ml only?
- Following datakit quick start. Managed to get the basics working.
- Trying to get ocaml 9p working, currently a dependency bug.
- Can't connect to the docker container yet, trying to figure out.

**Thursday**  

Datakit    
- I can run it in docker but I can't actually connect to it. Trying to connect ocaml-9p just eventually results in a timeout.
- Got it connecting, had to expose the port to the host using -p 5640:5640.
(Most of Thursday was spent reading about docker networking or looking at datakit or ocaml-9p, so not much to log.)

**Friday**  

Shell for ocaml-9p or datakit    
- Writing a quick lexer and parser for the commands so that things like strings and ids are actually handled properly.
- Works pretty well, quite resilient. Parses input into an AST of commands with their arguments. Also handles strings properly, plus relatively easy to extend.
- I'm writing this in such a way that tab completion should be fairly easy to add.
- To interact with Datakit I will need to install it properly rather than through docker so I can use it in my program. But currently it won't make - getting error during linking, undefined symbols for x86_64.
- Experimenting with Notty to make the shell interactive, for things like tab completion.
- Notty doesn't seem to support applications that aren't full screen terminal when capturing key presses. For example utop allows tab completion while still being scrollable. Notty generally seems to be more for graphics. lambda-term should support this but looks more low level and depends on Camomile.
- Notty also doesn't appear to clean up the terminal after ctrl + c, leaves mouse interaction on etc. And ctrl c can't be intercepted.

### Joel
**Monday**

Setting up Angstrom: I follow the readme instructions, ignoring the initial opam install as the package is not yet released.

 `opam pin add -n angstrom .
  opam install --deps-only angstrom`

Which goes fine.

I want to use vim to explore the source but it complains that it doesn't have alcotest, so I fix that:
~~~
 `opam install alcotest
  [...]
  Building fmt.0.8.0:
  ocaml pkg/pkg.ml build --pinned false --with-base-unix true --with-cmdliner true
  Installing fmt.0.8.0.
  [ERROR] 'pinned' has type bool, but a env element of type string was expected`
~~~

Messing around with versions settles on alcotest.0.4.1 as one that works. I run the config and make commands without incident.

Spent the rest of the day surveying Angstrom, OCaml internals and practising more Vim.

**Tuesday**

Wrote simple test parser for balanced parentheses using Angstrom. Went surprisingly smoothly - my previous experimentation with parser combinators and monads earlier in the year has clearly paid off.

Wrote initial version of ANSIparse - first test results in out-of-memory from infinite loop somewhere. !!

Rewrote the grammar and the code, still need to rewrite testing code and do the tests.

**Wednesday**

Continued rewrite a few times. Became apparent during testing that I had misread the format codes and fixed that. Got a working parser from string -> (style list * string) list, eg

~~~
`"Hello, \x1b[1mBrave, \x1b[4;31mNew \x1b[0mWorld!"`

to

`[ ( []                    , "Hello, " );
  ( [Bold]                , "Brave, " );
  ( [Underline; Fore Red] , "New "    );
  ( [Reset]               , "World!"  ); ]`
~~~

Now I need to work on the structuring, i.e. converting to HTML. There is already implicit structure; (styles, str) :: rest applies styles in order to str AND, implicitly, rest. However, the presence of Reset turns things off. I wonder how useful it would be to try and extract some tree structure from this data by e.g. matching styles and Resets.

**Thursday**

Today, worked on making the parser incremental, in that it works a line at a time given its intended use. Ran into some more unpleasant infinite-loop bugs; one of which was of the form

~~~
`Items --> Item*
Item --> Escape | Text
Text --> char*`
~~~

So we can derive "HELLO" as
Items --> Item* --> Text* --> Text --> "HELLO", or
Items --> Item* --> Text* --> Text Text* --> "HELLO" "", or "HELLO" "" "", etc... and never finishing

So I had to add lookahead whereby the parser for Text fails if it will read the empty string (because it's at the end of input).

**Friday**

Split into concrete (text) and abstract (tree) modules for later use. Had a look at TyXml.

### Philip
This week I split my time under two projects: the continuing of my
auto perforator and the datakit project.

The auto perforator is coming along very nicely. There is now a
hill climbing algorithm built in which will explore the perforation
state space. I have the system working under 3 domains: swaptions,
ray tracer, and kmeans. I will give a talk about the system next
Tuesday.

The datakit project is under KC's guidance. The idea is to use
datakit to power a distributed key-value store. The implementation
would be a domain for testing systems which adapt to byzantine
errors by changing the strength of their reads into the database.

## Week 29: July 18th-July 24th

### Romain
* I finished fixing some bugs with Decompress, so we have a stable version after many optimization. As I explained, we don't have a big improvement on the performance but Jeremy will take the relay
* After Richard focused me on a performance problem in MrMime, so I fixed​ the bug. It's a technical point bug I wait Richard to launch an other test
* I started a little library to see any differences between an email before and after decoding/encoding, I think, I will finish this mini-project this week-end - and may be it's a useful project for irmin

### Olivier
* Macro support has been implemented in `ocamlc.opt` (bytecode compiler running on the native back-end), after various bug corrections. The execution of macros is as follows:  
  1. static code is compiled to bytecode and written to a temporary `.cmm` file  
  2. that `.cmm` file is linked with its dependencies to make a temporary bytecode executable  
  3. using `Sys.command`, `ocamlrun` is called on that file. The executable runs and writes the top-level splices to the file passed as a command-line
     argument.  
  4. The untyped parse trees are unmarshalled and spliced into the run-time code.
* I pushed further the idea of HTML templates using the Markup.ml library. An example of a code that can be run (and that includes run-time strings in the template) is:

```
open Markup
open Htmltemplate
​
let par =
  Printf.printf "Please enter a string: ";
  read_line ()
​
let () =
  $(template [Lit {|
    <!DOCTYPE html>
    <html>
      <head>
        <title>Some page</title>
      </head>
      <body>
        <h1>Some page</h1>
        <p>|}; Var <<par>>; Lit {|</p>
      </body>
    </html>
  |} ])
    |> of_list |> pretty_print |> write_html |> to_string
    |> print_endline
```

The HTML tree is constructed statically, entailing no parsing costs at run-time. The next step is to convert the Markup.ml tree to a TyXML tree to have the typechecker enforce the validity of the HTML tree.

### Philip
Automatic perforation is coming to the point where it could be ready for more users. I have slowly started to focus on providing a good user interface.

This week I ran my auto perforation tool on two sets of inputs for kmeans with the goal of showing that results from a run of the automatic perforation program can be used to approximate further inputs. That is, running kmeans with the automatic perforator gives you a result on how to best perforate your loops. Using this result with future data sets previously unseen gives you just as good results. For this experiment I trained the perforation using 10 inputs with 100,000 points. I then ran the resulting perforated program on 10 other inputs of 1,000,000 points and achieved very similar results (a 5x speedup with only a 10% loss in accuracy).

This week I've written a blog post about the troubles with writing generic approximate computing frameworks (found at: http://phfilip.com/the-difficulty-in-a-general-approximate-computing-framework.html)

This week I've also discussed with KC at lengths about a use-case of approximate computing. The general idea is to add approximate reasoning to programs which work over distributed key-value stores. Programs in this domain are usually already written to handle consistency anomalies. The addition of a dynamic system to track and handle the levels of approximation could be a good fit for my approximate computing work.

### Ciaran
**Monday**
- Experimenting with Notty to make the shell interactive, for things like tab completion.
- Notty doesn't seem to support applications that aren't full screen terminal when capturing key presses. For example utop allows tab completion while still being scrollable. Notty generally seems to be more for graphics. lambda-term should support this but also has a lot of stuff that I probably don't need.
- Notty also doesn't appear to clean up the terminal after ctrl + c, leaves mouse interaction on etc. And ctrl c can't be intercepted.
- Actually it does allow capturing scrolling events and mouse position, so maybe I can implement scrolling manually instead, but not ideal.

**Tuesday**
- Would be good to handle unterminated input - e.g. if string doesn't have a closing quote or if the line ends in a backslash then go to the next line. Requires some support in the lexer.
- Notty assumes unicode throughout so I will too. Supporting unicode by storing input as an int list and using that when lexing and printing back to the terminal.
- I'm currently lexing and parsing the entire input on each keystroke, as I need to know the meaning of the input to be able to do prediction. Not really ideal but usually commands are so short that it might not matter. I might have a go at making it more efficient anyway.

**Wednesday**
- I spent today trying to figure out a better way of supporting completions by trying to only lex the part of the input that changes and swap out the affected tokens. I got it sort of working but it was buggy and had lots of mutable state so I gave up on it, at least for now.

**Thursday**
- Notty will only capture input events when using a single screen (not scrollable) terminal application, so using print doesn't work as it's quickly overwritten when redrawing the screen. This would be fine as I could just return a string and handle printing elsewhere, but as a lot of the stuff with ocaml-9p is asynchronous I might want to print during executing the command to let the user know what's happening. Which means I might have to take another look at Lambda-term.
- In terms of supporting completions, I had a look at Cmdliner as it parses the arguments and automatically checks if an arg is a file or an int etc, which would be useful information for prediction. Would be cool to be able to pass the Cmdliner data to this shell and have prediction done automatically, but unfortunately not really possible.
- I can add a small amount of stuff to add prediction to an existing program that uses Cmdliner (or something else). Basically just two functions (one for named args and one for positional args) that map a prefix to a list of possibilities.

**Friday**
- Got most things working together today, commands now work properly. Still haven't actually got the actual interface working yet though...

### Philip
Automatic perforation is coming to the point where it could be
ready for more users. I have slowly started to focus on providing a
good user interface.

This week I ran my auto perforation tool on two sets of inputs for
kmeans with the goal of showing that results from a run of the
automatic perforation program can be used to approximate further
inputs. That is, running kmeans with the automatic perforator gives
you a result on how to best perforate your loops. Using this result
with future data sets previously unseen gives you just as good
results. For this experiment I trained the perforation using 10
inputs with 100,000 points. I then ran the resulting perforated
program on 10 other inputs of 1,000,000 points and achieved very
similar results (a 5x speedup with only a 10% loss in accuracy).

This week I've written a blog post about the troubles with writing
generic approximate computing frameworks (found at:
http://phfilip.com/the-difficulty-in-a-general-approximate-computing-framework.html)

This week I've also discussed with KC at lengths about a use-case
of approximate computing. The general idea is to add approximate
reasoning to programs which work over distributed key-value stores.
Programs in this domain are usually already written to handle
consistency anomalies. The addition of a dynamic system to track
and handle the levels of approximation could be a good fit for my
approximate computing work.

## Week 30: July 25th-July 31st

### Romain
* I just improved (again!) the interface of MrMime:
  - So the design of the API is approved by Daniel and I wait a feedback of Richard to know if we will release a new version or not
* After, I did go to docker to meet Thomas and prepare a TODO list for ocaml-git. Now, I have a clear idea to what I need to do for this project.

Not a big week so, but a good week to clarify some points about MrMime and ocaml-git.

### Ciaran
**Monday**
- Rewrote a lot of the code as I was using quite a bit of mutable state. For example, using an array to store the current input. Now storing it as two int lists (ints as characters are unicode), the first representing the input before the cursor (stored in reverse), and the second representing the input after the cursor. Lots of other changes as well.
**Tuesday**
- Some more rewriting. Code a lot terser and almost no mutability.
- Managed to get Notty working with scrolling etc by disabling canonical mode myself then passing the input from stdin into the notty module to filter escape sequences. A bit of a hack but it means I can use notty and have proper scrolling etc, and don't have to redraw everything each time.
- Still a few things that are only half working. For example tab completion is kind of there but not actually 'wired up'.
**Wednesday**
- Not much to log, just starting to get the shell working with ocaml-9p, rather than just the couple of small examples I've been using so far.
- I've written the shell to be synchronous at the moment, which won't work well with things like ocaml-9p, so I'm going to change it to use Lwt throughout.

### Joel

Discussed with KC some interesting ideas I've been having related to making GUI programming less painful. Possible direction for Part II research. I need to investigate the existing literature and write up a brief explanation of what I'm looking at. Also, in the context of this summer, need to see if I can integrate it with the work I'm doing at Docker / OCaml Labs. KC suggested working on same as Ciaran: build 9P client, to develop these principles and test them.

Summary:

 * Motivation comes from building games, where the rule is reinventing the GUI wheel every time.
 * GUIs are systems of lots of interacting components. Difficult to code and organise.
 * Immediately tied up with graphics and layout: naive, ad-hoc solutions based on fixed, pixel coords and sizes commonplace.
 * Want graphical systems that automatically adjust to different constraints eg window shape/size.
 * iOS uses Cassowary constraint solver... potentially solved problem, but need expertise in linear prog / optimisation to implement...
 * The other broad problem area: specifying interaction.
 * Java Swing approach: add event listeners to everything. Asynchronous imperative programming: not scalable with complexity.
 * Reinventing for Game N: take similar approach. Sick of it
 * My ideas: related to DSLs, formal languages, grammars, parsers.
 * Fundamental hypothesis: Parser generators convert language specs into parsers - state machines which accept / reject (and, structure) linear sequences of tokens. Usually thought of as text, but my insight is this: the inputs (mouse, keyboard) that the user submits to an interface are a just such a linear sequence; simply in the time dimension. What if: when we write horrible imperative Java Swing ActionListeners, we are actually painstakingly and unwittingly constructing, by hand, the state machine for a parser of the UI's language? And if so, could it be easier to write UIs as formal grammars of some sort, and then automatically generate the parser (application code) from them? Just as you would enlighten a newbie to CS who has not heard of grammars and who writes all their parsing code in an ad-hoc manner. And furthermore - how useful would it be to view ALL programs (of the sort that depends on inputs from the outside world) as parsers - the language-vs-machine view; elaborate on the fact that, when we slog through the imperative state code for Turing machines, we're dually writing parsers for their [recursively enumerable] languages.
 * In one sense, a command-line utility that adds numbers together doesn't just do that - rather, it takes a bunch of characters from the command line and spits out more characters, which happen to correspond to numbers in a particular way.
 * Final facet: the principle of compositionality and abstraction. Context-free grammars; their benefits and limitations. Embedding semantics / context-sensitivity into grammars. CFGs let you elaborate in a top-down manner.

## Week 31: August 1st-August 7th

### Romain
* I talked with Christophe about the optimization, I have not yet advised Jeremy about the benchmark but I keep this thing when Jeremy will try to optimize Decompress
* I move Decompress to topkg because Anil wanted a Dockerfile inside the project
* Richard retested MrMime and I fixed some bugs and optimized some computations. Now, we compute 180 mails per second and MrMime fails on 500 emails with 815 000 emails! So it's not bad, we will fix the rest with Richard when he comes back
* I fixed a little bug for Qi Li on the Xen librairies
* I continue to document MrMime
* And I looked inside ocaml-git to understand where I need to start but I does not do revelant something for the moment.

### Enguerrand
* Worked on the ocaml-tls binding: Fixed a few memory leaks problems. Tried to run spacetime against the binding, to no avail Tried to run landmarks against the binding: not much success too.

### Ciaran
**Wednesday**  

Current state of the shell:
- Commands work, but I haven't actually added most of the commands. E.g. connecting doesn't actually work as it's asynchronous, so using Lwt throughout is top priority.
- Tab completion doesn't really work. It kind of did at one point, but I've changed quite a lot of stuff since then. Should be fairly easy to get working again though.
- Parsing the input works mostly fine, handles quotes / strings, allows escaping etc.
- Notty interface now works, which means I can continue using Notty, but it isn't perfect.

## Week 32: August 8th-August 14th

### Romain
* I continue to document MrMime, you can see the documentation at this link: http://oklm-wsh.github.io/MrMime/ (not very exciting)
* I started a new prototype for ocaml-git, the name is sirodepac, you can see the reopository at this link: https://github.com/dinosaure/sirodepac
For the sirodepac, the goal is to created a non-blocking encoder/decoder. So, Thomas follows the project and it's works for the moment despite some little bugs.

### Ciaran
**Monday + Tuesday**

Rewrote the lexer and parser to be able to understand more about the input, i.e. whether it's a positional arg, flag or optional arg etc. This also requires that the parser have access to the commands and their arguments so that required some more rewriting. This information can then be used for both predictions and syntax highlighting. It's also easier to extend.
Parsing optional arguments is tricky because it means the next positional value might actually be their value. Quite a few edge cases, and haven't added support for a few widely used conventions like using -- to denote that the next value is a positional value, or using = when specifying values.

**Wednesday**

Working on making predictions better using the additional information. Quite a lot of cases. Just doing the basic ones for now. Flags only need their name predicted. Non flags need their name predicted but can also predict their value. Positional arguments can be predicted based on their index.
Not working yet for optional arguments. Also not working for some other edge cases.

**Thursday**

Added syntax highlighting by traversing the raw input and the syntax tree together.
Some more work on prediction. Refactoring and separating out modules.

## Week 33: August 15th-August 21st

### Romain
* I continue to work on a prototype of ocaml-git. I just finished the decoder for the IDX file, I will try the implementation next week.
* I continue to document MrMime - Richard showed me some emails when MrMime fails. These emails are wrong and the thing is, if you use MrMime by the best effort way, you can extract all information from the email, so MrMime can parse these email by the hard way - not the simple way.

## Week 34: August 22nd-August 28th
## Week 35: August 29th-September 4th
## Week 36: September 5th-September 11th
## Week 37: September 12th-September 18th
## Week 38: September 19th-September 25th
## Week 39: September 26th-October 2nd

### Olivier
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

## Week 40: October 3rd-October 9th

### Olivier
* Monday (2016-10-10)  
: Added static modifiers where appropriate in reference files to fix three
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
: Fix the linker to guarantee that object files are linked in the same order as
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
: Two other fixes (see commit logs):
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
  The merge is at about 30 % progress (building and testing not included).

## Week 41: October 10th-October 16th

### Olivier
* Monday (2016-10-17)  
: I finished merging branch `4.04` into `macros`, but the repo is not functional
  yet: I get a segfault on `utils/clflags.ml` when bootstrapping. Strangely,
  printf-debugging pointed the segfault to happen on a call to `open_in_bin`
  inside `Bytelink.load_object`, although several successful calls have been
  made to `open_in_bin` during the execution. This suggests that the global data
  containing the Pervasives module has been somehow corrupt.
* Tuesday  
: A lot of time spent fighting with the built system and trying to find the
  cause of my bug(s), without success.
* Wednesday  
: Since `macros` was based on `trunk`, I shouldn't have used `merge` to rebase
  it on `4.04`, since changes from `trunk` have been introduced on `4.04`.
  In order to rebase macros on `4.04` without having to resolve conflicts on
  each commit (which would be necessary to keep the commit history), I had to
  squash all the macro-related commits into one commit, and cherry-pick that
  commit onto `4.04`.
* Thursday  
: Conflicts solved and `.depend` files updated. `make coreall` works but the
  segfault on `open_in_bin` is back. What's more, when trying to compile some
  dummy file with a static printf in it, the compiler segfaults in
  `Symtable.update_global_data`, more specifically on the operation:
  ~~~ {.ocaml}
  glob.(slot) <- transl_const cst
  ~~~
  where `glob` is `Meta.global_data ()`. I checked, it's not an out-of-bounds
  segfault.
  Another segfault I'm currently tracking is on a call to
  `Pervasives.output_string` (or `output_char`, one of the two).
* Friday  
: Today, meeting with Mort and Anil to check the progress of macros. I need to
  start writing down ideas of applications.
  The runtime segfaults on the following line while executing the instruction
  APPTERM2:
  ~~~ {.c}
  pc = Code_val(accu);
  ~~~
  Where `accu` has been set by the previous instruction:
  ~~~
  PUSHGETGLOBALFIELD Pervasives, 48
  ~~~

## Week 42: October 17th-October 23rd

### Olivier
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

## Week 43: October 24th-October 30th
## Week 44: October 31st-November 6th
## Week 45: November 7th-November 13th

### Olivier
* Monday (2016-11-07)  
: Laptop still in repair, spent all day trying to get a desktop PC as a
  replacement. Will use one of the lab shared computers from now on.  
* Tuesday  
: Added a new `value_kind` for macros and made the typechecker tag macros with
  it.
* Wednesday  
: Stopped keeping track of cross-stage identifiers in the typing environment.
  Instead, iterate through the typed tree to find them in a expression when
  needed.  
During the Compiler hacking event at Pembroke, paired with Maxime to work on
signatured opens (https://github.com/ocamllabs/compiler-hacking/wiki/Things-to-work-on#signatured-open-command); we're about halfway through it.
* Thursday  
: Add support (parser and typechecker) for macros in signatures.
* Friday  
: Add a closure argument to macros, yet unused.

## Week 46: November 14th-November 20th

### Olivier
* Monday (2016-11-14)    
: Specification of macro closures: the result of translating a macro into lambda
  code should be:  
  * if the target phase is 1: the code of the macro itself;  
  * if the target phase is 0: the closure, i.e. a block containing pointers to
    the cross-stage, phase-0 identifiers used in the macro's body.  

  Unrelatedly: discovered a bug in our early form of CSP. This "weak" CSP
  enabled the programmer to quote non-global identifiers *if* the quote was
  "trapped" inside a top-level splice.
  The current implementation is faulty, as it allows to quote simple identifiers
  like `y`, but not compound paths like `M.y`, e.g. the following does not work:

  ~~~ {.ocaml}
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
  ~~~

  Although this early form of CSP should be made redundant by path closures, I
  note this here for future reference.
  Improved printing of macros in signatures (`macro` instead of `static val`).
* Tuesday    
: Generation of `Lfrommacro` identifiers by macro expansion works. Now working
  to make the type-checker handle `Lfrommacro` properly. Quite nicely, there is
  no need to add a constructor to the `Path.t` type, since `Path.Pdot` already
  has an integer field that can be used to represent closure fields.
  Also, the compiler now shows the results of splicing when the options
  `-dsource` or `-dparsetree` are set.
* Wednesday    
: Note: when modifying `CamlinternalQuote` it might be necessary to do `make
  install` to have the changes taken into account in `Translquote`, since
  `Translquote` loads `^CamlinternalQuote` from the standard path unless
  otherwise specified.  
  First examples with path closures working. Deactivated all warnings during
  compilation of splices.  
  Nested macros now work as well.
* Thursday    
: Fix quoting of identifier so that globals are spliced as `Lglobal`. That
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
: Talked with Leo about future plans.  
  Banned quoting from outside of macros and splices. As a direct consequence,
  turned `Expr.of_*` functions into macros.

## Week 47: November 21st-November 27th
## Week 48: November 28th-December 4th

### Olivier
* Remove "zero" placeholders for other-phase values in the lambda code. This
  took me most of the week, as I had to phase information to `Path.t`, but also
  to `module_coercion`s.
  This modification should avoid over-approximating the static dependency tree
  as is currently the case. Currently, every run-time dependency is a static
  dependency. Since static dependencies must be compiled before there parent in
  the tree can be compiled, this limitation would break most OCaml projects.
  I expect this work to be finished, I'll do the tests later tonight.
* Talked with Leo about linking and side effects. Maybe, at some point, it will
  be necessary to ban the `static` keyword, unless the effect system is
  integrated into OCaml soon enough.
* In addition to switching the quoting library to producing lambda code, it
  would be good to detect scope extrusion. This would be done by passing
  `CamlinternalQuote.Var.t` to macros, instead of the current `Longident.t loc`.
* Note for later: rename `CamlinternalQuote.Ident` to
  `CamlinternalQuote.Global` and move `lfrommacro` to `Exp`.

## Week 49: December 5th-December 11th

### Olivier
**Compiler**

* The compiler "without placeholders" (and thus without useless static
  dependencies) now broadly works, i.e. I was able to bootstrap (necessary
  because adding an argument to one constructor of `Path.t` changed the cmi
  format) and compile `re` (a regexp library that previously didn't compile
  because of dependency issues).
* Fixed some tests, including `warnings/w53.ml` and other easy things. My
  changes appear to have broken recursive modules again (assertion failed in
  `CamlinternalMod`).
* Fixed some tests involving recursives modules, but not all of them, by fixing
  the `init_shape` function.
* Changed the lifting symbol to `~` (which unlike `^` should be non-breaking) in
  order to break less Opam packages.
* Fixed various issues and bugs with the new system of coercion. It seems quite
  robust, all tests are passed (except `no-alias-deps/aliases.cmo` but that's
  for a completely different reason, and was expected), and a lot of code from
  Opam compiles fine.
* Fixed priority of "illegal quoting" errors over phase errors after drup's
  remarks

**Examples using macros**  
* I try to make a fork of camlp4 compile again, but I encountered a bug that
  wasn't caught by the tests.
* A segfault occurs when running static code for the main source file of camlp4.
  Investigating on the issue.
* Started to look at the Flick network DSL, and its OCaml implementation Motto,
  and whether it can benefit from compile-time metaprogramming.
* Menhir is a dependency of motto, and doesn't compile because of wrong
  dependency tree — can be fixed by not translating type extensions into static
  code
* Talked with Mort about networking examples. It would be nice to be able to
  optimize a packet stream processor like POF or P4 using staging (maybe trying
  to use or get inspiration from strymonas).


## Week 50: December 12th-December 18th
## Week 51: December 19th-December 25th
## Week 52: December 26thJanuary 1st
