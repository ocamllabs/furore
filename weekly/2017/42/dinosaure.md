#### Decompress

Find a way to provide a JS API of Decompress with a mutable state.

```ocaml
type inflator = { mutable contents : (B.st, B.st) Inflate.t }
```

So, the code is specialized to manipulate only a bytes (but still ok
where the JS world does not provide an equivalent of Bigarray - in
performance).

#### Digestif

Find a new way to test the C implementation and the OCaml
implementation with travis.

Fixed a bug about the RIPEMD160 implementation in OCaml.

Put some other tests (from the BLAKE2{b,s} reference implementation,
and the RIPEMD160).

Benchmark on the C implementation and the OCaml implementation with
`core_bench`. However, I did not compare with `ocp-sha`, firstly
because I lost my time to make a package for ocp-sha (Louis provides
only a Makefile). And because ocp-sha was thinked to hash a file (not
a stream or a buffer) and tricks on to be fast - however, I can not
say ocp-sha is faster than digestif when ocp-sha uses some syscall
like lseek.

So, if we want to compare digestif and ocp-sha, it's about program
which take a file but it's not very relevant when ocp-sha map the file
and digestif could compute a stream of this file.

Finally, make a release.

#### OCaml Git

Try to move the test implementation on the new API. Nothing change a
lot, I missed some conveniences accessors and use infix operator of
Lwt_result instead Lwt.
