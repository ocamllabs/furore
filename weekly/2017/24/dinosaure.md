#### ocaml-git / sirodepac

I continue to integrate my work in ocaml-git. So, the integration of the
decoding is close to be done. Indeed, I can read any object from any PACK file
with the same API. I decided to provide an *easy-to-use* API (same as the
previous API of ocaml-git) and a more complex API to control precisely the
allocation. With this API, we can compute in a parallel way the git object if we
have some specific buffers available, otherwise, we can compute step by step
each objects with a *global* buffer.

So, now, I need to integrate the serialization inside ocaml-git and think about
a good API.

I continue to check my work step by step, try with `decompress` and `camlzip` to
keep the compatibility. I put a documentation for all and describe some complex
process inside the ML file to keep an understable code for other user.

So, for this moment, all seems to be good and, I think, we will have a good API.

#### CUFP

I send my proposal after a review with Thomas, Gemma, Anil and KC, at the next
CUFP, I'm waiting now the response :) !

#### OCaml network

I'm currently in Singapore and met all people from Ahrefs. Obviously, I met
Enguerrand (and he is good) but I met other people from this corporation and
speak about ICFP, OCaml and other stuff.

A good news, some people from this corporation keep an eye in the MirageOS
project - and think that the unikernel is the future!
