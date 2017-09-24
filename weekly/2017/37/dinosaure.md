#### Decompress

I just started to test decompress with afl, we found 41 tests cases
where decompress fails. So we can start to fix bugs. See the PR:

https://github.com/mirage/decompress/pull/35

#### Angstrom

When I tried to produce a dot file for a git repository, I found a bug
in Angstrom available in this issue:

https://github.com/inhabitedtype/angstrom/pull/104

#### Digestif

I just finished the implementation of the RIPEMD160 hash algorithm
(asked by @vbmithr) in C and in OCaml. The implementation is available
in this PR:

https://github.com/mirage/digestif/pull/12

@hannesm points a problem about the license, so I wait a response from
Antoon Bosselaers to use freely the C implementation.

#### OCaml Git

The PR#227 continues. I move the core library to `jbuilder`, implement
a top-level and a program which produce a dot file of a Git
repository - to test the current implementation.

With these, I found some bugs and fixed all - bugs from the PR when I
polished warnings.

I found a segfault (which show me the bug in Angstrom) in
ocaml+4.03.0. It's about a non-exhaustive pattern-matching on
exceptions. Then, Angstrom raises an `Index out of bounds` and,
because the pattern-matching is not exhaustive, we have an undefined
behaviour (instead an exception from the OCaml runtime) and we finish
to a segfault with a block with the tag 1002 (which should not appear
after 3.11).

I met Pierre Chambart and we discussed about that. When I handle the
exhaustiveness of the pattern-matching, all is ok in ocaml+4.03.0 and
in 4.04.0, OCaml raises a runtime exception about the exhaustiveness
of the pattern-matching.

Finally, I put an new issue in OCaml about warnings and the PPX, see
#MPR7624.

#### type-beat

I updated type-beat to use the last version of Angstrom.
