#### Digestif

I did the release but I spoke with daniel about the interface and the
organization of the library. So I just change the API. I reimplemented the SHA1
and the SHA256 in OCaml. I will push all the next monday.

We moved this repository in mirage organization.

#### Decompress

I did the release of 0.6. This release fixed a bug about the decompression but
nothing change about the API.

We moved this repository in mirage organization.

#### TypeBeat

Nothing to do.

#### Farfadet

Nothing to do.

#### ocaml-git / sirodepac

With Thomas, we push some PRs like the integration of decompress by default and
the integration of digestif by default - but we keep all functors. Then, I fixed
some bugs in sirodepac about the memory and integrate the optionnal usability of
a cache (like a LRU cache) and an access of a hash by the offset.

Thomas sended me a huge PACK file (~ 4 000 000 commits, 10 Go), so I will try to
generate a new PACK file from this source. However, the compute is very low and
may be crash because I launched the process in my server (and it's not my best
machine).

I wrote a documentation about `sirodepac` but only in french. When I finish, I
will ask to fix some errors (in french), then I will try to translate to
english - and publish an article :) !

Finally, with Thomas, we think about an abstraction and apply the generation of
the PACK for something different than `git` object and I think it's possible, I
have an idea about that. But I'm focus to integrate my work in ocaml-git for the
moment.
