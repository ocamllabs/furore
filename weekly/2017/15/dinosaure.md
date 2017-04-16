#### Decompress

I found a bug in Decompress about a far distance and the window. It's about the
`blit` function and the `Inflate` algorithm (the good news is that the `Deflate`
algorithm has no error). Indeed, when we have a distance we can have 3 cases:

 * the first is when the content of the window overlap the result. That means:
   the byte is not set yet, but when we advance in the window to write the new
   byte (from a old byte in window), we set the futur byte in the window. So,
   the all pattern is available only at the end of the `blit`.
   
   In this case, it's why we can't use `memmove` but `memcpy`.
   
 * the second is when it's a far distance. When we `blit`, may be we delete some
   bytes considered as a pattern and these bytes was not saved in the output.
   It's happen because the result overlap the content of the window. In this
   case, we need to write at the same time in the window and in the output.
   
   So, we create a function `blit2` and write from a `src` to 2 `dst` (in this
   case, the window and the output).
   
A good news is that, when I fixed this bug, I fixed another bug. Indeed, in the
`Deflate` algorithm, I avoid a compute of a far pattern because, when I try to
inflate the result, I had some errors. Now, because I fixed the `Inflate`, I
don't have error with a far pattern.

So, I need to do a new release now. But not yet, if I find a new bug, I don't
want to release all the time. So, when I will make the PR in `ocaml-git`, I will
release Decompress.

#### BLAKE2B / Digestif

Nothing to do but need to be released.

#### Farfadet

Nothing to do.

#### TypeBeat

Merge some PR from @seliopou, need to be released but not very important.

#### sirodepac / ocaml-github

So the serialization is done as the half. Indeed, we produce a PACK file with
the IDX file and we can recompute these (so, it's a big check to see if all is
ok). I add some check like the hash of the IDX file and the hash of the PACK
file.

I took my patience diff algorithm to try to apply a delta. I implement the
window (in an optimal way) and compute the diff between 2 git objects by the
line - before, I computed by the character but it's very slow.

So some good news:
 * the heuristic about the sort of the git object works! Indeed, when I try to
   apply a delta in a git object with the previous computed git object, I have
   some good ratio.
 * The performance is not killed. I don't say, I'm faster than git but the
   compute take a average time to make the PACK file.
 * The deserialization of the serialization of a PACK file produce the same
   result, we lost nothing when we deserialize and when we serialize.
   
So, I will implement the Hunk thing now to write the delta applied in the PACK
file and optimize the size of this file. But the core of the serialization is
already done.

Then, I will do some bench and make a PR to ocaml-git and, it's done :) ! But
need a time to do all correctly :p !

#### PS

I'm in Cambodia, I miss one day this week (the bus) but I will work this week
end. it's the cambodia new year so all people come to home.
