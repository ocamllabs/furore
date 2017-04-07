#### Decompress

I fixed the bug in Canopy about Decompress. As I said, the problem is come from
the implementation of `inflator.ml`. It's a good new, that means than Decompress
has no discovery bug.

This assumption is come from `sirodepac`. Indeed, I use a lot Decompress to
deserialize/serialize the PACK file and I did not find a bug.

I created some issues in Decompress to show what is my goal for the next release.

#### BLAKE2B / Digestif

Nothing to do.

#### Farfadet

I released the first version of Farfadet (after the release of Faraday). I
looked the implementation provided by @Drup and I choose this one. This
implementation is more confortable for any futur extension (we don't need to
create a new GADT constructor to add a new writer).

So, I provided a good example, a serializer of JSON. It's just a example, I
don't about the standard but the usability of Farfadet is very powerful!

@Drup told me to add a PPX then, I will think but not yet.

And, I provided a good documentation (I think). So, it's usable now.

#### TypeBeat

Good news, @seliopou improved a lot `TypeBeat` and remove redundant code (came
from Mr. MIME). I created a suit test. So, all is ok. I will do a new release in
few weeks.

I improved the documentation and nothing else.

I asked to @dbuenzli if he wants a RFC822 date parser but I said no (and I know why :D).
So, TypeBeat is finished.

#### sirodepac / ocaml-git

After the release of Farfadet, I decide to use it in `sirodepac`. Obviously,
it's not a mandatory part of the serializer/deserializer and, when I finish, we
will talk about these dependancies.

The point is the deserialization/serialization of a git object is provided by
Angstrom and Faraday/Farfadet library. It's an easiest way for me to maintain
the serialization/deserialization, the code is much cleaner and we respect,
again, the non-blocking assumption.

However, as I said, it's not mandatory to use it. In fact, I don't use the
non-blocking assumption for the git object in my algorithm - I can but, it's not
necessary (and may be not good about the performance).

I create a PoC of a function to get directly the git object without any compute
with delta thing. So, you have directly the git object. I need to improve this
function again (about the allocation) but it seems to be good as an API
*easy-to-use*. Indeed, you just need the hash and some temp buffer to make the
git object - but internnally, I create a big buffer and I think it's not
mandatory so I will delete that and improve the performance (and the
allocation).

I start the serialization. After the talk with @samoth, I have a global and
precise view of what we need to do. I implemented the *Window* other thing (not
like my precedent report) and start the serialization without the delta thing
for this moment.

But I sorted correctly the collection of the git object and compress correctly
the git object with Decompress. I just need to know the politic treatment about
the level of the compression. Indeed, I saw the git object was not compressed in
the uniq and same way, it's depends on the kind of the git object and the size
may be. I will look in `git` how to do this choice.

#### PS

This week, I took a plane to Ho Chi Minh in Vietnam to go then to Cambodia (as
you know), so I did not work this Thuesday (a little but not a lot, I was so
tired by the plane). It's why I was not so productive this week. Voilà!
