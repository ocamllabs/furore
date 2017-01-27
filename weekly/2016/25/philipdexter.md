Our perforation system allows programmers to annotate looping constructs which they believe can benefit from perforation. Compiling an annotated program into an optimized program which uses loop perforation is not straghtforward.

The most difficult task of this system is in finding the optimal perforation configuration. One solution is to profile every possible permutation of configurations. As this is entirely unfeasible the most truly difficult task is finding a heuristic which allows us to prioritize configurations.

After running some subset of all configurations, there will be a smaller subset of optimal configurations which form a time-error tradeoff curve. Our end result would present this graph to the user, allowing them to choose which tradeoff works best for them.

My time this week has been split between converting a black--scholes C implementation to OCaml and a first draft of our perforation program. The perforation program can successfully run different perforation configurations however there are no heuristics involved yet.
