Our perforation system is ready for initial testing so this week I've mostly worked on running experiments. I translated a swaptions program into OCaml. A lot of time was spent fixing bugs in the translation but once everything was set up I ran it through our loop perforation system and have some initial results.

We haven't quite reproduced the results from the C perforation system in the paper I'm referring to. They show results where a 5x speedup is achieved with only a 1% loss in accuracy. Our system can only produce a 1.2x speedup while losing 5% accuracy. We can get to 2x speedup but we have to sacrifice 40% accuracy. We do not perform the same state space searching as the paper version does so when that is all set up we may be able to reproduce the results.

I'm confident that once we perform the same sort of searches as the C version we can gain similar speedups. This will be an immediate goal of next week.
