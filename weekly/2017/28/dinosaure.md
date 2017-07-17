#### ocaml-git / sirodepac

##### About fetch a repository

So, first, I re-implement a negotiation engine about fetch. It follows the
current non-optimal implementation of Git. I saw the paper about the bloom
filter to optimize the negotiation but I don't have a time to implement this.

The good point is the modularization of the fetch compute in ocaml-git. Indeed,
we can change the negotiation engine by another engine easily.

About the PACK file received, with Thomas Gazagnaire, we catch a weird compute
from Git. In fact, when we receive a _thin-pack_ (which contains some externals
references), Git took it and make a new canonical PACK file (which does not
contain any external reference). Then, Git saves it in the store.

It's weird because if we store directly the _thin-pack_ and avoid the next
compute, all works. So, Thomas and me decide to let the choice to avoid the next
compute and store directly the _thin-pack_ or generate a new canonical PACK
file. This is prove my implementation of the encoder of the PACK file.

##### About push to a repository

I continue to focus my work on the push command. When I try to understand what
Git does, I saw a little DSL about set of commits (we can see this DSL with `git
parse-rev`). This DSL is a key of which commit we need to send to the server.
So, I implement this and some other stuff about reference. 

Then, I implement the smart protocol about the push command but I did not yet
test the command. I think, it's done today or tomorrow :) !
