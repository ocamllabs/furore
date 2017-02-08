# Maintenance releases

October: release 2.5.1, fix support for 4.03.
November: release 2.5.2, introduce support for 4.04.

# New developments: work on merlin-next

This will be the next major version of Merlin (Merlin 3.0).
It will revisit the idea of behaving like a shell/toplevel.

Existing versions of Merlin all behave like a shell to which a master
process (the editor) writes queries and reads answers.
This architecture made it incredibly complex to behave well with Emacs
editor.  Concurrency support under Emacs is minimal and not well
specified, leading to plenty of bugs; on Vim side, we relied on python
which worked well but caused unnecessary complexities.

## Synchronous calls for editors

With the next version, editors can choose a new "synchronous protocol".
Merlin is split in two binaries: "ocamlmerlin", "ocamlmerlin-server".

The first is a small wrapper in C, is platform dependent.  It is ran
synchronously by the editors, answering a single query.
Under the hood queries are handled by an instance of
ocamlmerlin-server selected by the proxy.

On Unix systems, the server listens on a Unix Domain Socket.
The client sends its commandline and stdin/out/err to the server via
fd-passing, wait for an return code from the server and terminates.
This way logic in the wrapper is minimal, just mimicking the behavior
of a unix command.

On Windows systems, Unix Domain Socket is replaced by a Named Pipe and
fd-passing is replaced by appropriate calls to DuplicateHandle.
The protocol is slightly adjusted but control flow is essentially the
same.

From the editor invocation is the same.  This effectively shifts
complexity from the editors to the main binary; retrospectively it
should have been like that since the beginning, but I didn't
anticipate concurrency would be so hard to handle in each editors...
meh.

Emacs mode is ported to new protocol.  Vim mode has been ported this
week (January).

## Refactoring architecture

A lot of code had to be rewritten/adjusted, so I tried to apply a more
principled approach.  New code essentially behave like a batch
compiler, producing semantic information rather than object code.

Efficiency is achieved by introducing memoization at relevant points
in the compiler pipeline.  As of today, it is limited to the bare
minimum, but profiling should reveal more opportunities.


### Lowering maintenance cost

Merlin embeds its own version of typecheckers -- 4.02, 4.03 and 4.04
in latest version.  The patchset over typecheckers was rewritten to be
much smaller:
* to avoid a maintenance hell, where every move introduced
  regressions... which were not tracked
* it should be easier to upstream

The cleaner architecture makes it easy to run a testsuite or even some
sanity checks at runtime.  The testsuite already contains ~ 60 tests
and proved useful in porting 4.04 without (too much) pain.

# Ongoing work: easier introspection

A major issue we had maintaining Merlin is that, seen from the editor,
it acted as a blackbox.
When a problem is observed, there are no tools to track the cause.
Common causes can be found in Merlin itself, the editor mode (or other
editor modes (!)), ppx rewriting, build environment, ...

Before october, the first attempt at solving that was "sturgeon",
which exposes monitoring UI to observe Merlin tasks and state.  It is
successful but still a proof-of-concept.

The second approach is to expose a richer logging interface which
records a trace of Merlin execution, detailing decision at each
branches.  This work is still in its infancy.

# Future work: new features

The refactoring above came with a feature freeze -- some being
developed on side branches, but nothing in the main binary.

Features to be done soon:
- path remapping for Docker & Tramp
- interactive search API -- à-la OCamloscope / Hoogle (POC available)
- support all namespaces for identifier renaming, cover with testcases
- completion with spellchecking (broken POC available)
- introducing a notion of code-action (refactoring suggested by Merlin)

# Future work: more documentation

Documentation centered on editor modes: editors have different ways of
achieving each features, so most explanations are editor specific,
especially for newcomers.

Minimal documentation for Merlin itself -- just what is necessary to
setup editor-agnostic features.
