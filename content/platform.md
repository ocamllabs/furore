# OCaml Platform

The Platform combines the core OCaml compiler with a coherent set of libraries, tools and documentation. We look to large-scale users of OCaml to guide the direction of development in this area, including Jane Street, MirageOS, Docker and Facebook. 2016 has seen a focus on the developer experience; tooling improvements around packaging, build and test infrastructure; and support for different operating systems and infrastructures.


Mention users of Platform:

Unikernel Systems formed in 2016 and built on work initiated by the OCaml Labs group over the last 5 years. Unikernel Systems was successfully acquired by container giant Docker, and progress on those original components and libraries has continued throughout the year.

_Mention Jane Street, ARM, Microsoft, Citrix, Facebook, Aesthetic Integration, Hitachi_

The OCaml Platform is a collaborative effort across the OCaml community led by OCaml Labs, Jane Street and OCamlPro. The goal of the Platform is to provide an integrated development environment with a comprehensive set of tooling and support for a wide range of operating systems and infrastructures to allow for the fun and efficient development of OCaml.

## Developer Experience & Tooling

### OPAM

Opam 2.0 preview release: September 2016 with details of additions - link to work with FB on Reason that led to discussions and subsequent changes

Compilers as packages

Command wrappers

File installation tracking

Migrating the OCaml repository

Virtual OCaml packages

Continuous Integration

### Conex - OPAM signing

### Merlin

The defacto editor tool for OCaml providing support for Emacs, Vim, VSCode, Atom, Eclipse and Sublime Text.

### Packaging and Build

What will go here? - topkg in mirage section...

### Documentation

Documentation has been a focus for the past few years, with direct effort made in 2016 by OCaml Labs and Jane Street to provide a working implementation for full documentation support.

Work on improving the documentation toolchain started in 2015 with the [alpha release](http://opam.ocaml.org/blog/codoc-0-2-0-released/) of [codoc 0.2.0](https://github.com/dsheets/codoc). The Platform team outlined the different stages of documentation and the difficulties in providing a feature-complete implementation. 2016 saw further development in the form of [odoc](https://github.com/ocaml-doc/odoc), an OCaml API documentation tool that takes interface files and outputs cross-referenced module documentation.

The aim is that odoc will work correctly on functor-heavy code bases \(where ocamldoc has previously struggled\) and will link identifiers across packages. Once the rendering is improved it will replace ocamldoc as the default documentation path used by [odig](https://github.com/dbuenzli/odig) \(a library to mine installed OCaml packages\).

* An example of [documentation](http://docs.mirage.io/) generation from all of the installed packages using only `cmti` files using `odig ocamldoc`
* A current best effort example of [documentation]((http://docs.mirage.io/odoc/) as a current best effort with cross referenced links.

[Odoc](https://github.com/ocaml-doc/odoc) the documentation generator is comprised of:  
[doc-ock](https://github.com/ocaml-doc/doc-ock) to extract documentation from OCaml files; [doc-ock-html](https://github.com/ocaml-doc/doc-ock-html) for HTML generation; [doc-ock-xml](https://github.com/ocaml-doc/doc-ock-xml) and XML printer and parser; and [Octavius](https://github.com/ocaml-doc/octavius) an ocamldoc syntax parser.

## Operating Systems & Infrastructure

Windows

* OPAM Windows Port
* OPAM repo: migration of "own" packages, fdopen -&gt; opam-repository

ARM
