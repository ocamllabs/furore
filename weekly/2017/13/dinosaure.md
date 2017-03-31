#### Decompress

Polish the documentation.

#### BLAKE2B / Digestif

I just fixed the problem with `Bytes.t` in `Digestif`. So, I let the projet in
my side but I keep in my head to implement the hashes functions in pure OCaml.

#### sirodepac / ocaml-git

I move the internal structure to `Cstruct.t` to move my work in `ocaml-git`
easily. The patience diff worked (without any other dependancies). I need to
optimize a part of the algorithm (about the implementation of Dequeue from Simon
Cruanes) but we can use it to serialize the PACK file.

Then, I looked a long time in `git` to understand the serialization. I talked
with @samoth about some informations and now all was clear to implement the
serialization. My question was about the order of the git object before the
serialization. Indeed, git has an heuristic to order the git object inside the
PACK file and believe than this order is the best to apply a diff between the
git objects. 

`sirodepac` (and `ocaml-git`) will follow this heuristic obviously.

Another good point was: I fixed the big bug about the limitation of OCaml for
the huge PACK file. It's a complex point because it's about the architecture (32
/ 64 bits) and the limitation of the native integer in the OCaml's runtime. I
followed the implementation in `git` and it works! The solution is to map only a
limited area of the PACK file, save this area as a *Window* and compute the
object. If the requested object was not available in the current, we create a
new *Window* and *map* a new area of the PACK file (and, obviously, this area
contains the requested object).

Then, we keep a fixed-size bucket of *Window*s (that means, if we need a new
window and the bucket is full, we will remove the oldest window) and we can
compute any git object without any limitation!

So all continue to work and I will move my implemenation of the serialization of
the git object to `Faraday` (because @seliopou will do a release).

#### Farfadet

I will do a release of `Faradet` and check the PR of @Drup.

#### Mr. MIME

Nothing to do.

#### TypeBeat

So, it's new library to respond about @dsheet and a problem in `cohttp`.
TypeBeat is a ligth library to parse the value of the `Content-Type`. This
project was just a part of Mr. MIME but with the `Angstrom` dependancy.

However, I can't use `TypeBeat` in Mr. MIME. In fact, I need to know the
implementation of the type `Angstrom.t` to do some mandatory optimisations.

I released the library, so I let @rgrinberg or @dsheet to use it in `cohttp`. I
don't have a time to insert `TypeBeat` in `cohttp`.

Voilà!
