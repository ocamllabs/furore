* Macro support has been implemented in `ocamlc.opt` (bytecode compiler running on the native back-end), after various bug corrections. The execution of macros is as follows:  
  1. static code is compiled to bytecode and written to a temporary `.cmm` file  
  2. that `.cmm` file is linked with its dependencies to make a temporary bytecode executable  
  3. using `Sys.command`, `ocamlrun` is called on that file. The executable runs and writes the top-level splices to the file passed as a command-line
     argument.  
  4. The untyped parse trees are unmarshalled and spliced into the run-time code.
* I pushed further the idea of HTML templates using the Markup.ml library. An example of a code that can be run (and that includes run-time strings in the template) is:

```
open Markup
open Htmltemplate
let par =
  Printf.printf "Please enter a string: ";
  read_line ()
let () =
  $(template [Lit {|
    <!DOCTYPE html>
    <html>
      <head>
        <title>Some page</title>
      </head>
      <body>
        <h1>Some page</h1>
        <p>|}; Var <<par>>; Lit {|</p>
      </body>
    </html>
  |} ])
    |> of_list |> pretty_print |> write_html |> to_string
    |> print_endline
```

The HTML tree is constructed statically, entailing no parsing costs at run-time. The next step is to convert the Markup.ml tree to a TyXML tree to have the typechecker enforce the validity of the HTML tree.
