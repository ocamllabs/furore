# Events

We regularly host community events based around functional programming and OCaml. 2016 was a busy year for us and we hosted lots of events including 4 compiler development sessions in Cambridge; the first MirageOS hackathon in Marrakech, followed by a local Cambridge MirageOS event; the 2016 OpenBSD summit; and the first International Metaprogramming Summer School at Robinson College.

Together with academic appearances, members of the OCaml Labs team present their work to the wider community including programming groups, students, financial groups and other development teams - most notably Facebook this year.

Encouraging community contribution and engagement has been a focus of this year, with consideration given to onboarding new users, surfacing and documenting small-scale projects, and developing strategies for efficient maintainership of our shared repositiories and code. We started the OCaml Labs Slack group to enable easy communication amongst our widely distributed group, and we have >100 active users.

## Compiler Hacking Sessions

_**February, May, June and November 2016**_

Initiated in 2013 by Leo White and Jeremy Yallop as a time and place to focus on their compiler projects, these events have continued every few months, with 4 evening sessions over 2016. The events are open to anyone with an interest in improving the OCaml toolchain, and there's always a handful of OCaml specialists to help new users get started and answer questions. We provide a list of [mini projects](https://github.com/ocamllabs/compiler-hacking/wiki/Things-to-work-on) for attendees to work on, and often host presentations of new releases and features.

During a recent push towards the upcoming MirageOS 3.0 release, we diversified by designating our [most recent session](https://ocamllabs.github.io/compiler-hacking/2016/11/01/fifteenth-compiler-hacking-evening.html) in November as a combination OCaml compiler/MirageOS hack evening. We followed up with an [activity summary](http://reynard.io/2016/11/16/CompHack.html) which displayed an encouraging mix of first-ever commits, and OCaml and MirageOS specific features from a range of users. Feedback was positive, and we will likely combine some of our future hack events in similar ways.

## MirageOS Hackathons

### Marrakech

_**11th-16th March 2016**_

OCaml Labs sponsored the first MirageOS hackathon - an international, community-organised event - at [Rihad Priscilla](http://queenofthemedina.com/en/index.html) in Marrakech, which provided a perfect venue for community building and hacking. Hannes Mehnert and David Kaloper started the [OCaml-TLS](https://mirage.io/blog/introducing-ocaml-tls) project at [Aftas beach house](https://berlin.ccc.de/~hannes/aftas2017.jpg) in [Mirleft](https://mirage.io/graphics/aftas-mirleft.jpg) back in 2014, and were keen to encourage others to experience Morocco for themselves. Hackathon attendees included the MirageOS core team, complete newcomers and long standing community members - many of whom wrote [trip reports](https://mirage.io/blog/2016-spring-hackathon) detailing their experiences.

Event outputs included:

* a dog-fooded network stack using DHCP on site served by [Charrua](https://github.com/mirage/charrua-core)
* a git-blogging unikernel called [Canopy](https://github.com/Engil/Canopy) built on existing libraries [Irmin](https://github.com/mirage/irmin), [tyXML](http://ocsigen.org/tyxml/), [COW](https://github.com/mirage/ocaml-cow) and [Mirage HTTP](https://github.com/mirage/mirage-http)
* an [OCaml adoption manifesto](https://github.com/fxfactorial/an-ocaml-adoption-manifesto)
* security and privacy features: specifically [cryptographic layer](https://github.com/mirleft/ocaml-nocrypto/pull/93) improvements; key-derivation function implementations \([Scrypt](https://github.com/abeaumont/ocaml-scrypt-kdf) and [PBKDF](https://github.com/abeaumont/ocaml-pbkdf)\); and an [IKEv2](https://github.com/isakmp/ike) implementation
* networking features: [SWIM](https://github.com/andreas/mirage-swim) membership protocol implementation; a [telnet](https://github.com/hannesm/telnet) protocol in OCaml; [SOCKS4](https://github.com/cfcs/ocaml-socks) packet handling; and [DNS wildcard](https://github.com/cfcs/ocaml-wildcard) matching
* general MirageOS development: running [AFL](http://lcamtuf.coredump.cx/afl/) against a MirageOS unikernel; [updates]((http://canopy.mirage.io/Posts/Errors)\) of and [improvements](https://github.com/verbosemode/syslogd-mirage) to error reporting; moving away from Camlp4 to PPX; and general documentation

### Cambridge

_**17th July 2016**_

Following the success of the Marrakech event, we ran a day-long MirageOS hack event at Darwin College, Cambridge.

Projects included:

* [integration](https://mirage.io/blog/introducing-solo5) of a new hypervisor target in the form of [Solo5](https://github.com/solo5/solo5) KVM-based backend
* software packager [topkg](https://github.com/dbuenzli/topkg), with an API template for managing configuration and package specifications
* onboarding improvements and [documentation changes](https://github.com/mirage/mirage-www/pull/468)
* developer experience improvements
* CPU portability: improved ARM support via an [implementation](https://gist.github.com/ijc25/612b8b7975e9461c3584b1402df2cb34) of Alpine Linux on Cubietrucks
* Windows support: [OCaml](https://github.com/djs55/ocaml-wpcap) bindings for [winpcap](http://www.winpcap.org/); OPAM-Windows support for older versions of OCaml
* error logging improvements [continued from Marrakech](https://github.com/mirage/functoria/pull/55)
* [ctypes 0.7.0](https://github.com/ocamllabs/ocaml-ctypes/releases/tag/0.7.0) release
* a [FastCGI connector](https://github.com/Chris00/ocaml-cohttp-fcgi) for CoHTTP

## International Summer School for Metaprogramming

_**8th-12th August 2016**_

Together with Microsoft Research and Facebook, OCaml Labs sponsored the first International Summer School for Metaprogramming which was held at Robinson College, Cambridge. The goal of the summer school was to explore the various forms of metaprogramming and its practical application. The school was aimed at graduate students of programming languages and related areas, but was open to researchers, practitioners interested in the subject.

Talks and speakers included:

* [Quoted DLSs](http://www.cl.cam.ac.uk/events/metaprog2016/everything-old-is-new-again.pdf): [Philip Wadler](http://homepages.inf.ed.ac.uk/wadler/)
* [Normalisation by evaluation](http://homepages.inf.ed.ac.uk/slindley/nbe/nbe-cambridge2016.pdf): [Sam Lindley](http://homepages.inf.ed.ac.uk/slindley/)
* [Embedding by normalisation](https://github.com/shayan-najd/NanoFeldspar/blob/master/Examples/MetaProg2016/Slides.pdf): [Shayan Najd](http://homepages.inf.ed.ac.uk/s1364660/)
* Type-safe embedding and optimising DSLs in the typed final style
* [Self-specialising interpreters and partial evaluation](http://chrisseaton.com/rubytruffle/metass16/metass.pdf): [Chris Seaton](http://chrisseaton.com/)
* Comparing approaches to generic programming - [A generic deriving mechanism of Haskell](http://www.cl.cam.ac.uk/events/metaprog2016/generic-deriving.pdf); [A formal comparison of approaches to datatype-generic programming](http://www.cl.cam.ac.uk/events/metaprog2016/generic-comparison.pdf). [José Pedro Magalhães](http://dreixel.net/)
* The highs and lows of macros in the modern language: [Laurence Tratt](http://tratt.net/laurie/)
* [Multi-stage programming Part 1](http://www.cl.cam.ac.uk/events/metaprog2016/psd1.pdf), [Multi-stage programming Part 2](http://www.cl.cam.ac.uk/events/metaprog2016/psd2.pdf): [Jeremy Yallop](http://www.cl.cam.ac.uk/~jdy22/)
* [Foundations of metaprogramming](http://www.cl.cam.ac.uk/events/metaprog2016/metaprogramming-martin-berger.pdf): [Martin Berger](http://users.sussex.ac.uk/~mfb21/)
* A reflection on types/Template Haskell 14 years on: [Simon Peyton Jones](http://research.microsoft.com/en-us/um/people/simonpj/)

Lightning talks from attendees:

* Mietek Bak: [Towards intentional analysis of syntax](https://mietek.github.io/metaprog2016/html/Metaprog2016.html)  
* Kwanghoon Choi: [SMLOG: an embedding of logic language in Standard ML](http://www.cl.cam.ac.uk/events/metaprog2016/kwanghoon-choi-MetaProg2016talk.pdf)  
* Artúr Poór: [Parallelization of Scala programs by refactoring](http://www.cl.cam.ac.uk/events/metaprog2016/parallelization-of-scala-programs.pdf)  
* Aggelos Biboudis: [Stream Fusion to perfection](http://www.cl.cam.ac.uk/events/metaprog2016/stream-fusion-to-perfection.pdf)  
* Martin Lester: [Static analysis for JavaScript-Style eval](http://www.cl.cam.ac.uk/events/metaprog2016/mml-talk-meta.pdf)  
* L. Thomas van Binsbergen: [Reusable components for formal and executable language specification \(from the PLanCompS project\)](http://www.cl.cam.ac.uk/events/metaprog2016/van-binsbergen-reusable-components.pdf)  
* Michael Ballantyne: [Modelling macro hygiene with scope graphs](http://www.cl.cam.ac.uk/events/metaprog2016/mpss-hygiene-presentation.pdf)  
* Paul Laforgue: [Codata types and copattern matching](http:/www.cl.cam.ac.uk/events/metaprog2016/codata-types-and-copattern-matching.pdf)  

## OpenBSD Summit

_**30th August-5th September 2016**_

Improving OCaml OS and distribution support is always on our agenda, and we decided to address this directly by hosting the 2016 OpenBSD summit at the Computer Laboratory, Cambridge. It coincided with the 6.0 release and the last release to be accompanied by original songs and pressed onto CD - future releases will be online only.

More needed here....

It was interesting to see 60+ volunteer developer team operate, and discuss distributed community management with them.

## OCaml Labs at ICFP

### OCaml Tutorial

_**22nd September 2016**_

We ran this year's OCaml Tutorial using [IOCaml Notepad](https://github.com/andrewray/iocaml) which provides a REPL within a browser with a friendly interface. The session lasted the afternoon and started with a brief introduction to OCaml followed by a tour through fundamental constructs needed to eventually write an implementation of the popular [2048 game](http://gabrielecirulli.github.io/2048/). 21 people attended the tutorial, with varying abilities and experience levels, including some Haskell developers and one person with no prior programming experience. It was an open atmosphere for questions and discussion with the resources remaining [available online](https://github.com/ocamllabs/2048-tutorial/blob/master/task.md) . Most people managed to complete the task, and had some form of working game at the end of the tutorial, and providing a follow up tutorial for those who have completed this would be a useful next step.

### OCaml Spacetime T-shirts

_**23rd September 2016**_

To celebrate the upcoming OCaml 4.04.0 release, we designed and printed some OCaml t-shirts featuring the new memory profiler [Spacetime](http://caml.inria.fr/pub/docs/manual-ocaml/spacetime.html). We hope this is the start of many adventures for our cartoon camel.

## Liveblogging

Towards the end of the summer we started using [Canopy](https://github.com/Engil/Canopy), the git-blogging unikernel to capture a range of talks that members of our team attended. It was a success on the whole, and we hope to continue using it for future events as a complement to videos and slides.

### ICFP and co-located workshops

_**18th-24th September**_

Knowing we would be unable to attend all of the talks, we distributed our team across the different topic tracks and ran a [liveblog unikernel](http://icfp2016.mirage.io/) to try and cover as many talks and workshops as we could. This would also allow others to enjoy talks they could not attend. There were some wifi issues, but we managed to log 54 talks, including:

* [9 talks](http://icfp2016.mirage.io/CUFP) from the [CUFP conference](http://cufp.org/2016/)
* [14 talks](http://icfp2016.mirage.io/OCaml) from the [OCaml workshop](http://ocaml.org/meetings/ocaml/2016/)
* [1 talk](http://icfp2016.mirage.io/HIW) from the [HIW workshop](http://conf.researchr.org/track/icfp-2016/hiw-2016-papers#program)
* [16 talks](http://icfp2016.mirage.io/ICFP) from the [ICFP main track](http://conf.researchr.org/track/icfp-2016/icfp-2016-papers)
* [7 talks](http://icfp2016.mirage.io/ML) from the [ML workshop](http://www.mlworkshop.org/ml2016)
* [4 talks](http://icfp2016.mirage.io/PLMW) at the [PLMW workshop](http://conf.researchr.org/track/icfp-2016/PLMW-ICFP-2016#program)
* [3 talks](http://icfp2016.mirage.io/TyDe) at the [TyDe workshop](http://conf.researchr.org/track/icfp-2016/tyde-2016-papers)

### Docker Distributed Summit

_**7th-8th October**_

The Docker for Mac and Windows application utilises 40+ OCaml libraries, many of which were developed by the Unikernel Systems team stemming from OCaml Labs.

We used Canopy to [liveblog](http://canopy.mirage.io/Liveblog) the Docker Distributed Summit in Berlin and covered all of the talks, with two talks specifically related to work at OCaml Labs and MirageOS:

* [Talking TUF - Securing Software Distribution](http://canopy.mirage.io/Liveblog/TUFDDS2016)  
  The Update Framework \([TUF](https://theupdateframework.github.io/)\) provides a specification and library that can be used universally to secure software update systems. Our OPAM signing proposal, [Conex](https://github.com/hannesm/conex-paper/blob/master/paper.pdf) is based on TUF with additional features specific to [OPAM](https://opam.ocaml.org/blog/Signing-the-opam-repository/).

* [Unikernels: The rise of the library hypervisor in MirageOS](http://canopy.mirage.io/Liveblog/MirageOSUnikernelsDDS2016)  
  This talk focused on the notion of breaking the hypervisor down into libraries and extending the "kit" model, whilst introducing the discrete components that form the Docker for Mac and Windows application: [HyperKit](https://github.com/docker/hyperkit), [DataKit](https://github.com/docker/datakit) and [VPNKit](https://github.com/docker/vpnkit) - all of which feature OCaml and MirageOS contributions.


# Talks and Workshops

## External Talks & Presentations

_**14th January 2016**_  
 UCL Security Group Presentation - London, UK  
**Unikernels: Rise of the library operating system, and how to engineer not-quite-so-broken software**  
_Anil Madhavapeddy_

_**22nd January 2016**_  
[CIF @ Scale14X](https://www.socallinuxexpo.org/scale/14x/presentations/knock-knock-unikernels-calling) - California, USA  
[**Knock, knock: Unikernels Calling!**](http://decks.openmirage.org/cif16-loops#/)  
_Richard Mortier_

_**23rd January 2016**_  
[/dev/winter](http://devcycles.net/2016/winter/) - Cambridge, UK  
[**Surfacing deep magic with library operating systems**](http://devcycles.net/2016/winter/sessions/index.php?session=70)  
_Mindy Preston_  
[**My first unikernel with MirageOS**](http://devcycles.net/2016/winter/sessions/index.php?session=71)  
_Matthew Gray_

_**28th January 2016**_  
Facebook TechTalk - California, USA  
[**Concurrent and Multicore OCaml: A deep dive**](http://kcsrk.info/slides/multicore_fb16.pdf)  
_KC Sivaramakrishnan & Stephen Dolan_

_**4th February 2016**_  
[Compose](http://www.composeconference.org/2016/program/) - New York, USA  
**Composing Network Operating Systems**  
_Mindy Preston_

_**19th February 2016**_  
MSR Seminar - Cambridge, UK  
_Anil Madhavapeddy_

_**19th February 2016**_  
[BobKonf](http://bobkonf.de/2016/mehnert.html) - Berlin, Germany  
**Jackline: A secure instant messaging application, functional from the ground up**  
_Hannes Mehnert_

_**21st February 2016**_  
[TRON Workshop @ NDSS](http://www.internetsociety.org/events/ndss-symposium-2016/tls-13-ready-or-not-tron-workshop-programme) - California, USA  
[**Not-quite-so-broken TLS 1.3: Mechanised Conformance Checking**](https://www.internetsociety.org/sites/default/files/T7-mehnert.pdf)  
_Hannes Mehnert_

_**14th June 2016**_  
[LDN Functionals](http://www.meetup.com/London-Functionals/) - Jane Street London, UK  
[**The functional innards of Docker for Mac and Windows**](https://youtu.be/zqFDEDl5Zes)  
_Anil Madhavapeddy_

_**2nd August 2016**_  
[LDN Functionals](http://www.meetup.com/London-Functionals/) - Jane Street London, UK  
[**OCaml Multicore and Programming with Reagents**](https://youtu.be/qRWTws_YPBA)   
_KC Sivaramakrishnan_

_**14th September 2016**_  
London Facebook Faculty Summit - Facebook London, UK  
[**Effective parallelism with Reagents**](https://ocaml.io/images/1/11/Effective_Parallelism_with_Reagents.pdf)  
_KC Sivaramakrishnan_

_**23rd September 2016**_  
OCaml Workshop - Nara, Japan  
**Improving the OCaml webstack: motivations and progress**  
_Spiros Eliopoulos_

_**29th September 2016**_  
Rustat Conference - University of Cambridge, UK  
**Inner workings of DataKit and DataBox**  
_Anil Madhavapeddy, KC Sivaramakrishnan_

_**4th November 2016**_  
[CodeMesh](http://www.codemesh.io/codemesh#programme) - London, UK  
[**Distributed Consensus: Making the Impossible Possible**](http://www.codemesh.io/codemesh/heidi-howard)  
_Heidi Howard_

_**8th November 2016**_  
LCFS - University of Edinburgh, UK  
[**Polymorphism, Subtyping and Type Inference in MLsub**](http://www.cl.cam.ac.uk/~sd601/lfcs_slides.pdf)     
_Stephen Dolan, Alan Mycroft_

_**9th November 2016**_  
[SPLS](https://msp-strath.github.io/spls-16/) - University of Edinburgh, UK  
**Irrelevant Classical Logic in Agda**  
_Stephen Dolan_

_**15th December 2016**_
[Opodis](http://opodis2016.etsisi.upm.es/program.html) - Madrid, Spain  
**Flexible Paxos: Quorum Intersection Revisited**  
_Heidi Howard, Dahlia Malkhi and Alexander Spiegelman_


## University Talks & Seminars

The following presentations take place at the Cambridge Computer Laboratory during term time.

_**Lent Term 2016**_    
University of Cambridge Computer Laboratory - Cambridge, UK   
[**Advanced Functional Programming**](https://www.cl.cam.ac.uk/teaching/1516/L28/)  
_Jeremy Yallop, Anil Madhavapeddy and guest lecturers Alan Mycroft, Leo White & KC Sivaramakrishnan_

_**28th January 2016**_  
[**An overview of Bigraphs, their applications and future research directions**](http://talks.cam.ac.uk/talk/index/64101)  
_Michele Sevegnani \(University of Glasgow\)_

_**2nd February 2016**_  
[**Unanimous Revisited: Distributed consensus for geo-replication**](http://talks.cam.ac.uk/talk/index/63953)  
_Heidi Howard_

_**10th February 2016**_  
[**Not-quite-so-broken TLS 1.3 mechanised conformance checking**](http://talks.cam.ac.uk/talk/index/64371)  
_Hannes Mehnert_

_**16th Feburary 2016**_  
[**Managing Infrastructure as code with Puppet**](http://talks.cam.ac.uk/talk/index/64293)  
_Gareth Rushgrove \(Puppet\)_

_**17th February 2016**_  
[**Compiling algebraic effects to JavaScript in js\_of\_ocaml**](http://talks.cam.ac.uk/talk/index/64551)  
_Armaël Guéneau_

_**25th February 2016**_  
[**Is every Java program a Unikernel? An introduction to IncludeOS' design and foundations**](http://talks.cam.ac.uk/talk/index/63150)  
_Alfred Bratterud \(HiOA\)_

_**17th March 2016**_  
[**On PCIe Performance**](http://talks.cam.ac.uk/talk/index/63075)  
_Rolf Neugebauer \(Docker\)_

_**26th April 2016**_  
[**Towards Compilation of Affine Algebraic Effect Handlers**](http://talks.cam.ac.uk/talk/index/66823) _Daniel Hillerström \(University of Ediburgh\)_

_**16th June 2016**_  
[**Ios: Why work when you can delegate?**](http://talks.cam.ac.uk/talk/index/66573)  
_Heidi Howard_

_**12th July 2016**_  
[**Unikernels and Beyond: The future of application containers in the cloud**](http://talks.cam.ac.uk/talk/index/66835)  
_Dan Williams \(IBM Research, NY\)_

_**19th July 2016**_  
[**Approximate Computing**](http://talks.cam.ac.uk/talk/index/66823)  
_Philip Dexter \(Binghamton University\)_

_**11th August 2016**_  
[**FlashBlade: Hardware and Software Co-design**](http://talks.cam.ac.uk/talk/index/66948)  
_Alex Ho \(Pure Storage\)_

_**4th October 2016**_  
[**Second Chances: Every second packet doesn't count**](http://www.cl.cam.ac.uk/~jac22/talks/)  
_Jon Crowcroft_

_**11th October 2016**_  
[**Trip Report from S-REPLS 4**](http://srepls4.doc.ic.ac.uk/)  
_Nik Sultana_

_**19th October 2016**_  
[**Unik: A platform for automating unikernel compilation and deployment**](http://talks.cam.ac.uk/talk/index/68620)  
_Idit Levine \(EMC\)_

_**10th November 2016**_  
[**Flexible Paxos: Reaching agreement without majorities**](http://talks.cam.ac.uk/talk/index/68505)  
_Heidi Howard_

_**15th November 2016**_  
[**Higher Network Performance on MirageOS**](http://talks.cam.ac.uk/talk/index/68997)  
_Takayuki Imada \(Hitachi\)_
