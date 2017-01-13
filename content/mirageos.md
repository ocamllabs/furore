# MirageOS

**Overview**

[MirageOS](https://mirage.io) is a library operating system written in OCaml that can be used to build unikernels for secure, high-performance network applications across a variety of cloud computing and mobile platforms.

MirageOS applications are highly portable since they are parameterised across their operating environment. Rather than making assumptions about the presence of an operating system, they can depend on a set of small OCaml module signatures. These signatures provide services such as consoles, network or block devices or entropy. The `mirage` CLI tool parses a configuration file that assembles concrete implementations of these signatures to generate an executable.  MirageOS supports targets ranging from standard POSIX ELF binaries to x86\_64/ARM Xen and KVM unikernels, and more experimental targets such as QubesOS, JavaScript and hardware FPGAs.

There is a vibrant and growing ecosystem around constructing libraries for MirageOS that are built in pure OCaml with minimal external dependencies. This unlocks that functionality in all of the target architectures that MirageOS supports.

MirageOS depends on a number of components that are developed and maintained by OCaml Labs, some of which are detailed below.

**2016 Changes**

Mirage 3.0 is set for release in early 2017 and provides the groundwork for increased flexibility and stability of unikernels in production.

## Core Project

### Irmin

**Overview**

[Irmin](https://github.com/mirage/irmin) provides Git-like distributed, branchable storage. It was first released in 2013, but the first [post](https://mirage.io/blog/introducing-irmin) detailing its features was in 2014. Irmin is a library component of MirageOS and seeks to provide an OS-independent, portable structure for data persistence.

**2016 Changes**

2016 saw a large API change to allow easier use of new and efficient Irmin backends, increased Windows support, new functors for metadata, improved documentation and the release of [Irmin 0.12](https://mirage.io/blog/irmin-0.12) which includes <code>irmin-watcher</code> to replace the slow and resource-intensive default polling.

Previous watches on the datastore had latency issues and were expensive as they scanned the full storage directory every second to detect changes. Applications relying on Irmin such as [DataKit](https://github.com/docker/datakit) which has thousands of tags and [Canopy](https://github.com/engil/Canopy) which requires low latency are examples of the user-driven changes that took place this year.

### Packaging and Release

Previous attention given to OCaml's package and release story was diverted from Assemblage to a more flexible system with a strong build-system model. The result is a combination of components that improve the process significantly, and which are used with the vast majority of our OCaml and MirageOS packages.
<!--do we have evidence of this? -->

**Overview**

* [Topkg](http://erratique.ch/software/topkg) is a packager for distributing OCaml software that provides an API to describe the conventions applied to given build configurations, distribution creation and publication procedures. It is a library that is added as a build dependency and comes with an optional tool (<code>topkg-care</code>) to help manage your package and releases.

* [Odig](http://erratique.ch/software/odig) is a library and command line tool to mine installed OCaml packages which supports metadata lookups and package description documentation. When used together with <code>ocamldoc</code> or <code>odoc</code> it generates per-package API documentation sets with inter-package cross-references. See the OCaml [platform](./platform.md) section for more details on documentation.

* Framework for building directory structures: the next piece of the package and build puzzle will focus on making it quick and easy to set up new software projects and provide licensing and source boilerplate code during program development.

### Functoria

**Overview**

[Functoria](https://github.com/mirage/functoria) is a DSL to organise functor applications. Using Functoria, you can describe a set of modules and functors, their types and their application. It uses keys to define parameters and to switch implementation at configure time.

**2016 Changes**

Functoria was [released](https://mirage.io/blog/introducing-functoria) in February 2016, with a new release due in 2017.

### Ctypes and FFI
- include libtls

### AFL

### Continuous Integration

----

* topkg, odig -- user of Platform
* Functoria
* Ctypes
  * libtls \(inverted stubs\)
* AFL testing

## Docker Contributions

* Docker for Mac and Windows - uses a variety of libraries: TCP/IP etc
* 9p shell
* ANSI term parser
* Daniel Spencer https:\/\/github.com\/danielspencer\/secure\_log\_lib \(UROP\)

## Web services

The web ecosystem has steadily been improving in OCaml, and OCaml Labs has made contributions towards the various protocol implementations, as well higher level frameworks to make web programming more pleasant. Most of these libraries are in pure OCaml and so directly compatible with MirageOS.

* webstack: webmachine, session, angstrom, faraday \(spiros\)
* canopy \(xref to internship page\)
* uutf, etc: all the unicode libraries, and jsonm

## Datascience

Databox, UCN, personal data

* TLS
* Irmin
* CueKeeper

* **Mr Mime: Email Parsing**  
  [Repo](https://github.com/oklm-wsh/MrMime) \| [Paper](http://din.osau.re/mrmime.pdf)  
  [Mr Mime](https://github.com/oklm-wsh/MrMime) is a pure OCaml library that targets parsing multipart email. It uses the Continuation Passing Style \(CPS\) to assemble small parser combinators on-the-fly to build a parser based on the mail header contents. This can be combined with MirageOS unikernels that send, receive, store and process emails. Future work may include unikernel deployments such as SMTP proxies and spam filters.

* **OWL: Data Analysis**  
  [Docs](http://www.cl.cam.ac.uk/~lw525/owl/) \| [Repo](https://github.com/ryanrhymes/owl) \| [Tutorial](https://github.com/ryanrhymes/owl/wiki/Tutorial:-How-to-Plot-in-Owl%3F) \| _Under development_  
  [Owl](https://github.com/ryanrhymes/owl) is an OCaml numerical library that supports both dense and sparse matrix operations, linear algebra, regressions, and many advanced mathematical and statistical functions. Owl is still in its infancy and under current development, with dense and sparse matrix functions and advance mathematical and statistical functions close to completion. [Future work](https://github.com/ryanrhymes/owl/wiki/Future-Plan) will feature support for linear algebra, regression functions and machine learning.
