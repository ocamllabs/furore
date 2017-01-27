A user cannot zealously apply approximate computing strategies to every line of every program they write. This week I have looked through three OCaml programs which I believe can benefit from approximation: 1. A ray tracer 2. A H.261 video decoder 3. The black--scholes algorithm for option pricing

Not all three programs have explicit for-loops---OCaml programmers tend to favor recursion---but all three have perforation opportunity.

My next step is to implement an interactive system which will guide a user in approximating their programs. It will first identify all potential loops/recursive calls in a program which allow perforation. Given this set it will then attempt to find the /best/ combination of perforation. Testing all possible combinations of loop perforation is unfeasible so some heuristics must be developed.

I also spent some time this week working on multicore OCaml. I wet my feet by writing a recursive lock implementation. The code can be found on [github] along with the [issue] requesting the implementation.

[github](https://github.com/ocamllabs/reagents/compare/master...philipdexter:recursive)

[issue](https://github.com/ocamllabs/reagents/issues/2)
