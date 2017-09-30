#### Decompress

I launched the afl test and fixed the bug founded. It's about a
special case of decompress when it deflates a data. Indeed, when we
deflates a input lowest than 12 bytes, we launched a specific
algorithm which does not need some assumptions to work.

The bug appears in this case and I fixed it easily. Then, I relaunched
the afl test and, now from 4 days, alf did not catch an error yet.

#### Digestif

@hannesm showed me a code which is freely licensed (public domain)
about the implementation of the RIPEMD160 hash algorithm. So, I
integrated this code in Digestif, passed all tests and merge it in
master. It's ready for a next release.

However, @cfcs asked me to implemente the BLAKE2s hash algorithm. So,
when I finish this implementation, I will do a benchmark and release
it.

In fact, at the same time, I asked to Louis some benchmark to compare
with `ocp-sha`. I did not look the implementation but I keep it in my
TODO list of Digestif.

#### OCaml Git

Polishing and debugging. In fact, the `git` core library did not
change a lot but I figure about the API all the time. I worked to
provide the git-unix implementation, a git-http implementation which
uses `cohttp` (but it can use `cohttp-js`) and reorganize the project
under the @samoht's advise.

In the details, I integrated `read_inflated` and `write_inflated` as a
part of the shared API between the memory back-end and the file-system
back-end.

I linted the API of the web abstraction needed by the git-http
implementation - I think about cohttp/httpaf. The point is, git-http
uses the cohttp-lwt implementation but not the cohttp-lwt-unix
implementation. git-unix/ogit-http-clone uses the cohttp-lwt-unix but
we can use with the memory back-end (which restricted with the minimal
interface) the cohttp-js implementation.

Finally, sync_http, the main module which implements the Smart HTTP
protocol (encode/decode) does not need `cohttp` but a implementation
which respects the interface `s.web`.

Finally, I found 2 bugs about the sync_http implementation:
* The first is a _sattelite_ bug. I mean, it's about how to use cohttp
  with the Smart HTTP protocol. Indeed, the POST request which
  _negociates_ with the server need to not be chunked.
* The second bug it's about a missing implementation of the side-band
  but it's not so big.
