# MirageOS

MirageOS is a library operating system written in OCaml that can be used to build unikernels for secure, high-performance network applications across a variety of cloud computing and mobile platforms.

MirageOS applications are highly portable since they are parameterised across their operating environment. Rather than making assumptions about the presence of an operating system, they can depend on a set of small OCaml module signatures. These signatures provide services such as consoles, network or block devices or entropy. The `mirage` CLI tool parses a configuration file that assembles concrete implementations of these signatures to generate an executable.  MirageOS supports targets ranging from standard POSIX ELF binaries to x86\_64/ARM Xen and KVM unikernels, and more experimental targets such as QubesOS, JavaScript and hardware FPGAs.

There is a vibrant and growing ecosystem around constructing libraries for MirageOS that are built in pure OCaml with minimal external dependencies. This unlocks that functionality in all of the target architectures that MirageOS supports.  OCaml Labs has contributed to this effort via several projects that use MirageOS.

## Core Project

* topkg, odig -- user of Platform
* Functoria
* Ctypes
  * libtls \(inverted stubs\)

* Mirage \(do they need to  be separate?\) Should we mention perf improvements for next year \(taka?\)
* AFL testing

## Web services

The web ecosystem has steadily been improving in OCaml, and OCaml Labs has made contributions towards the various protocol implementations, as well higher level frameworks to make web programming more pleasant. Most of these libraries are in pure OCaml and so directly compatible with MirageOS.

* webstack: webmachine, session, angstrom, faraday \(spiros\)
* canopy \(xref to internship page\)
* uutf, etc: all the unicode libraries, and jsonm

## Datascience

Databox, UCN, personal data

* TLS
* Irmin

* **Mr Mime: Email Parsing**  
  [Repo](https://github.com/oklm-wsh/MrMime) \| [Paper](http://din.osau.re/mrmime.pdf)  
  [Mr Mime](https://github.com/oklm-wsh/MrMime) is a pure OCaml library that targets parsing multipart email. It uses the Continuation Passing Style \(CPS\) to assemble small parser combinators on-the-fly to build a parser based on the mail header contents. This can be combined with MirageOS unikernels that send, receive, store and process emails. Future work may include unikernel deployments such as SMTP proxies and spam filters.

* **OWL: Data Analysis**  
  [Docs](http://www.cl.cam.ac.uk/~lw525/owl/) \| [Repo](https://github.com/ryanrhymes/owl) \| [Tutorial](https://github.com/ryanrhymes/owl/wiki/Tutorial:-How-to-Plot-in-Owl%3F) \| _Under development_  
  [Owl](https://github.com/ryanrhymes/owl) is an OCaml numerical library that supports both dense and sparse matrix operations, linear algebra, regressions, and many advanced mathematical and statistical functions. Owl is still in its infancy and under current development, with dense and sparse matrix functions and advance mathematical and statistical functions close to completion. [Future work](https://github.com/ryanrhymes/owl/wiki/Future-Plan) will feature support for linear algebra, regression functions and machine learning.


## Docker

* 9p shell
* ANSI term parser
* Daniel Spencer https:\/\/github.com\/danielspencer\/secure\_log\_lib \(UROP\)



