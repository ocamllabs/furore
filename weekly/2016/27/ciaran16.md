**Monday**   
- Background reading. Refreshing how git works in more detail. Looking at irmin, datakit.
- Reading articles from Thomas Leonard's blog.

**Tuesday**   

Setting up opam / ocaml.
- Installing opam using brew. Following RWO setup guide. Installing core, utop etc via opam. Configuring utop to #require core packages.
- Setting up vim. Installing merlin and creating .merlin file. Installing ocp-indent-vim. Sorting out .vimrc. Installed syntastic, setup to use merlin.

Docker tutorial
- Installed docker. Followed the basic docker tutorial - the basics of images, containers etc.

OCaml
- Reading some more of Thomas Leonard's articles. Reading  RWO.

**Wednesday**  
- Finished reading most of part 1 of RWO. Read some of the later chapters as well, but part 1 covers most of the language features.

Dependencies and utop
- utop doesn't load the init file (.ocamlinit) when loading an ml file from the command line. Using #use loads the init file.
- I expected utop to work with a file that used other modules in the same directory, but it doesn't. It is possible by building first using ocamlbuild and then using #load_rec on the cmo file. Useful for interacting / quickly testing a bit of code split across multiple files.

Lexing and Parsing
- Read the chapter about parsing in RWO and managed to get the very basics working.

**Thursday**  

IOCaml and Hydrogen
- Setting up Hydrogen for Atom as explained on the website. Working with python (although requires running atom via terminal), need to get working with IOCaml. Installed OCaml support for atom using apm install language-ocaml.
- Doesn't work on 4.03 for some reason, requires < 4.03.0. Switching to 4.02.3. (Later on - after updating opam I can install on 4.03)
- Trying to opam install IOCaml fails as it depends on gmp, which it isn't installing automatically. Installed manually with homebrew.
- Still failing as ctypes won't compile - The compilation of ctypes failed at "make XEN=disable libffi.config".
- Installed libffi manually using brew. opam install IOCaml now works.
- IOCaml doesn't work. Jupyter says 0 active kernels. Hydrogen works with python even if jupyter notebook isn't running, so I guess it's using its own instance. IOCaml works by itself from the command line, just not sure how to link with Jupyter or Hydrogen.
- Jupyter doesn't have a kernel spec for IOCaml. I have no idea how to add one.

* There are pages on the IOCaml wiki for adding the kernel spec, but I can't figure it out.

Lexing and Parsing  
- Messing around with ocamllex and Menhir in the afternoon, trying to create a simple template language.
- Decided to try sedlex instead as it supports unicode.
- sedlex won't install for 4.03. Latest version does work on 4.03 but opam isn't seeing it. Trying to figure out how to refresh the repo.
- Can't find much (Later on - did I actually try opam update?). The latest version listed by opam is 1.99.2, but the opam repository online gives 1.99.3.
- Adding PKG sedlex to my .merlin file causes 'Error while running external preprocessor'. Can't figure out what exactly is the problem for now, something to do with the fact sedlex uses ppx?

Sedlex  
- Just trying to lex for now, the template language consists of text and logic parts which need to be lexed differently, so the lexer needs some contextual infomation.
- Managed to get lexing working pretty well for the template language, by using some mutable state. Don't think there is any other way really.

**Friday**

Sedlex  
- I'm currently testing my lexer by building, then going into utop and doing

```
    #directory "_build";;
    #load_rec "_build/lexer.cmo";;
```

  This lets me quickly test it with different strings without having to rebuild, and lets me see the returned list of tokens.

* Sedlex doesn't let you define regexps using
    `let lid =
      let lid1 = [%sedlex.regexp? R] in
      [%sedlex.regexp lid1]
  as they will be unbound. Currently doing:
    let lid1 = [%sedlex.regexp? R]
    let lid = [%sedlex.regexp lid1]`
  They have their own scope anyway.

* Does defining a function within a function that is called often have a significant performance penalty to defining it outside the function?

**Weekend**
- Messed around with lexing a bit more, got parsing working as well using Menhir. Requires using MenhirLib.Convert API as Menhir is made to work with ocamllex.
