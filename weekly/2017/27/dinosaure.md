#### ocaml-git / sirodepac

##### About the mini-encoder

As I said previously, I re-implement a mini encoder to provide an API « à la
Faraday » but this API was constrained by the memory. In fact, Faraday is a
encoder which one has no limit to save what you want to encode. The internal
buffer can growth and, if we don't have an other concurrency thread to consume
the internal buffer of the Faraday state, we will have a problem with the memory
consumption for some cases (like when we want to digest a huge blob).

So, in the previous week, I finished the implementation and now, all is good.
The mini encoder works perfectly.

##### About the Smart protocol

In previous week, I spoke about the Smart protocol with Git to clone/fetch/push
a PACK file and test my implementation. I said than the current implementation
of the Smart protocol in ocaml-git does not provide a good API to play with it -
it's like some common operation but you can manipulate in the details what is
going on the exchange with a Git daemon.

So, I decided to re-implement the Smart protocol in other way and I finished the
implementation with a close user-friendly operation with my PACK decoder.

More precisely, I catch a memory bug when we try to clone a big repository.
Indeed, in a specific (but common) context, we need to undelta-ify some objects
stored in the PACK file received. The big problem is, for each delta-ification,
we need to save a list of hunk to re-construct the requested object.

So, previously, for each hunk, I allocate a little string and keep all as long
as we deserialize the object. At the end, I use these hunks to reconstruct the
current object. However, the base of the requested object can be delta-ified
too. Finally, we can have 50 level of delta-ification and to reconstruct the
final object, we need to keep all hunks at each level of each base object. And,
we literally use a lot of memory for that.

So, I decided to undelta-ify the object against an heuristic described in the
technical document of git. The point is, the base of an object must be before
the object (inside the PACK file). So, I can calculate for the first pass the
biggest depth of the PACK file. Then, in the second pass, when we delta-ify the
rest of the object, I allocate n buffer (n = max_depth) and for each
undelta-ification, I used these buffer to store hunks (instead to allocate).

So, we allocate, one time, a big buffer, and re-use this buffer as long as we
undelta-ify the delta-ified objects.

This is needed to calculate the hash for each object and produce an IDX file,
which will be saved in the file-system.

I tested this approach and, to clone ocaml-git for example, I use 1~2 % of my
memory (4 GB) to deserialize all object of the PACK file received. However the
process is little bit slow. Another point is, when I try to clone a repository
with a huge file, I use lot of memory but all the time, the OCaml GC can compact
the area and we are not close to the [Out_of_memory] problem now.

Now, I focus on the push command.
