Discussed with KC some interesting ideas I've been having related to making GUI programming less painful. Possible direction for Part II research. I need to investigate the existing literature and write up a brief explanation of what I'm looking at. Also, in the context of this summer, need to see if I can integrate it with the work I'm doing at Docker / OCaml Labs. KC suggested working on same as Ciaran: build 9P client, to develop these principles and test them.

Summary:

 * Motivation comes from building games, where the rule is reinventing the GUI wheel every time.
 * GUIs are systems of lots of interacting components. Difficult to code and organise.
 * Immediately tied up with graphics and layout: naive, ad-hoc solutions based on fixed, pixel coords and sizes commonplace.
 * Want graphical systems that automatically adjust to different constraints eg window shape/size.
 * iOS uses Cassowary constraint solver... potentially solved problem, but need expertise in linear prog / optimisation to implement...
 * The other broad problem area: specifying interaction.
 * Java Swing approach: add event listeners to everything. Asynchronous imperative programming: not scalable with complexity.
 * Reinventing for Game N: take similar approach. Sick of it
 * My ideas: related to DSLs, formal languages, grammars, parsers.
 * Fundamental hypothesis: Parser generators convert language specs into parsers - state machines which accept / reject (and, structure) linear sequences of tokens. Usually thought of as text, but my insight is this: the inputs (mouse, keyboard) that the user submits to an interface are a just such a linear sequence; simply in the time dimension. What if: when we write horrible imperative Java Swing ActionListeners, we are actually painstakingly and unwittingly constructing, by hand, the state machine for a parser of the UI's language? And if so, could it be easier to write UIs as formal grammars of some sort, and then automatically generate the parser (application code) from them? Just as you would enlighten a newbie to CS who has not heard of grammars and who writes all their parsing code in an ad-hoc manner. And furthermore - how useful would it be to view ALL programs (of the sort that depends on inputs from the outside world) as parsers - the language-vs-machine view; elaborate on the fact that, when we slog through the imperative state code for Turing machines, we're dually writing parsers for their [recursively enumerable] languages.
 * In one sense, a command-line utility that adds numbers together doesn't just do that - rather, it takes a bunch of characters from the command line and spits out more characters, which happen to correspond to numbers in a particular way.
 * Final facet: the principle of compositionality and abstraction. Context-free grammars; their benefits and limitations. Embedding semantics / context-sensitivity into grammars. CFGs let you elaborate in a top-down manner.
