The initial objective of the internship was to provide a CPS translation for algebraic effects and handlers in order to compile OCaml code which uses effects to Javascript. Starting from Armael Gueneau's CPS translation we wanted to find a selective CPS translation and implement it in the js_of_ocaml toolchain.

On the technical side we had some discussions with Kaycee, Stephen and Leo about the possibility of implementing the CPS translation in the ocaml-multicore compiler itself and the pros and cons of this approach. The main advantages would be the direct availability of typing information at the TypedTree level and the possibility to compare the CPS translation to the stack based implementation which is used in ocaml-multicore. We may also use this translation to enable multi-shot continuations in handlers. The problem is that the maintenance cost of a transformation from the typedtree level to lambda is quite high as the typedtree is not stable. Another advantage of relegating the transformation to js_of_ocaml is that it is a whole program compiler and separate compilation introduces some complications with the selective CPS translation where pure and effectful functions have different signatures.

The choice was made to lower the useful type information to the bytecode level and implement everything else as part of js_of_ocaml.

I spent the first weeks familiarizing myself with the semantics of effects and handlers and talking with Armael to understand the CPS translation. There are a few points which make this translation hard to understand :

* It is based on the `alloc_stack` and `resume` primitives which are used for the stack based implementation of effects in the ocaml-multicore compiler but do not exactly correspond to the `handle` and `continue` primitives that appear in programs

* It is untyped because at the time there was no type and effect system for multicore-ocaml and as we realized even with a type and effect system, it is not straightforward to give a type to the CPS translation of a term. One of the issues we quickly run into is that in order to write interesting programs such as a scheduler we need some form of recursive effects which end up as recursive types in the CPS translation.

* The translation is a composition of two steps : first the effects and handlers are translated to delimited continuations (which involves a kind of local CPS transformation inspired by [this](https://gist.github.com/sebfisch/2235780) which are then CPS translated. While the second step is well understood, according to Armael and to the best of my knowledge there is no literature on the second step.

The result is that even if the translation as implemented in [Armael's prototype](https://github.com/Armael/lam/tree/refactor-new) seems to behave correctly we have no guarantee of its correctness.

My first contribution was to rewrite the translation for the `handle` and `continue` primitives:

`[handle e (v -> e_v) (v_e v_k -> e_f)] := [e](\_ v. [e_v])(\v_e v_k.[e_f])`
`[perform e] := \k. [e](\e' h_f. h_f e' (\x. x k h_f)`
`[continue c e] := \k. [c](\c'. [e](\e'. c' e' k))`
`[|e|] := [e](\x _ k. k x)(\_ _. fail)(\x.x)`

where `[e]` is the cps translation of `e` and `[|e|]` is the toplevel translation which fails if an effect is unhandled and returns the value of a successful computation.

The result is actually nicer than I hoped for and there seems to be an intuitive interpretation for it: In a CPS translation a term is given its continuation a an argument, here the continuation is an alternating list of value continuations and effect handlers corresponding to the stack of installed handlers. `handle` extends the current stack, perform calls the handler and stores the current context in a continuation. `continue` restores the suspended continuation.

The translation is still untyped but we can clearly see the problem here : if we wish to use a "simple" type system we will have issues with `perform` where the type of `h_f` should be recursive.

In parallel to this I have been working on a typed CPS translation for the simply typed lambda calculus based on [this paper](http://dl.acm.org/citation.cfm?id=99608). The implementation relies on an embedding into OCaml types using GADTs to ensure that the CPS translation produces a term of the right type. GADTs and polymorphism constraints on the cps function ensure that it would be very hard to produce an incorrect term for the CPS translation.

Given the time it took us to convince ourselves that the translation makes sense we chose to focus on finding a typed cps translation for effects. The plan is to find a class of programs for which the cps translation can be typed with simpler types and extend the typed cps translation in OCaml which would be a convincing argument that the translation is correct through the type constraints and extensive testing. Then we can either try to reintroduce some features to the type and effect system and try to handle them or move back to the implementation of the selective CPS transform.

We would like to work in a strongly normalizing calculus and give a simple correspondence between the type of a term and its CPS translation. Deep handlers with the current type and effect system can introduce type and term level recursion so a first attempt would probably involve shallow handlers. We can then recover the expressivity of deep handlers with term-level recursion.
