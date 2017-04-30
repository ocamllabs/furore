#### Decompress

Nothing to do.

#### BLAKE2B / Digestif

Nothing to do.

### Farfadet

Nothing to do.

#### TypeBeat

Nothing to do.

#### sirodepac / ocaml-git

Previously, I told about the final implementation of serialization and try to
find a good heuristic to make a small PACK file.

I have some goods results and now, I produce a PACK file with ~5MB when git
produces ~2MB. So we are very close to git but not yet. At this time, it's
complex to find a good way because git use an heuristic to compress the PACK
file. I don't use the same because I can't reproduce exactly what git doing on
the PACK file.

So, for this week, it's a deep introspection and a reverse engineering about
what git do. And I'm focus on two problems:

- the sort algorithm. I follow the description of the sort in the git's
  documentation and, if I understand correctly, it's a lexicocagraphic compare
  between the kind of the object, the basename and, finally the size. I
  copy/paste the code from git to my project but my production of the sorted
  list object is different. This is a big problem because it's the main
  assumption to compress a PACK file
  
- the compression method. To produce a 5MB pack file, I re-implemented the
  patience diff from the Jane Street library patience_diff (to avoid the
  dependency with Core). But git don't use the patience diff when it computes a
  PACK file. And I know why: because it's slow. Indeed, when I try to generate a
  PACK file, I maked a (patience) diff between 2 files by the line because if I
  try to diff by character, the algorithm is __very__ slow. However, when I diff
  by line, the compression is not optimal for thow reason:
  
  * a diff by line is only relevant for a blob (which contains the file) but
    it's unoptimal for tree, commit and tag because these are not organized by
    line (but by LF character). I try to specialize the split and I produce a
    PACK file with 4.3MB but I can't do a better.
  
  * for a blob, sometimes, is not relevant to split by line because sometimes,
    only one character change between these files.
  
Finally, git does not split by line to produce a diff. So, I looked what git do
to compress and he uses a rabin's fingerprint to make an `index` and uses this
`index` to make a diff with another file.

Now, I produce the same `index`, so I implemented the rabin's fingerprint and
try to implement the delta-ification between an `index` and a file. But, just to
notice, it's a clever solution for 2 reasons:

- we do a real compression like Decompress but with another algorithm (not the
  Lz77 algorithm - but I can use it to compress ...)

- we can reuse the index for multiples files and it's what git do. When I
  computed some PACK files, I see the delta-ification for some file with one
  same file/`index`. It's to make the serialization more faster because, to make
  an `index` we need a time.
  
So, I continue to implement the rabin's fingerprint and the compression with
this - and continue to follow what git do.

Good news, git can recognize my PACK file with no problem (I fixed a bug about
the hash). So we can considere than the project works but Thomas want a project
which produces the same PACK file (in size terms). So, I continue to optimize
`sirodepac`.
