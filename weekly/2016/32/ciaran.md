**Monday + Tuesday**

Rewrote the lexer and parser to be able to understand more about the input, i.e. whether it's a positional arg, flag or optional arg etc. This also requires that the parser have access to the commands and their arguments so that required some more rewriting. This information can then be used for both predictions and syntax highlighting. It's also easier to extend.
Parsing optional arguments is tricky because it means the next positional value might actually be their value. Quite a few edge cases, and haven't added support for a few widely used conventions like using -- to denote that the next value is a positional value, or using = when specifying values.

**Wednesday**

Working on making predictions better using the additional information. Quite a lot of cases. Just doing the basic ones for now. Flags only need their name predicted. Non flags need their name predicted but can also predict their value. Positional arguments can be predicted based on their index.
Not working yet for optional arguments. Also not working for some other edge cases.

**Thursday**

Added syntax highlighting by traversing the raw input and the syntax tree together.
Some more work on prediction. Refactoring and separating out modules.
