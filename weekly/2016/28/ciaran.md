**Monday**

IOCaml on 4.03
- Requires ctyptes. ctypes fails due to requiring libffi. There is a message about needing to brew install libffi but I missed it at first. Installed after that.
- Forked and cloned iocaml, followed wiki post on iocaml github to create kernelspec for jupyter:
  `{
  "display_name": "OCaml",
  "language": "ocaml",
  "argv": [
    "<full path to iocaml>/iocaml.top",
    "-object-info",
    "-completion",
    "-connection-file",
    "{connection_file}"
  ]
  }`  
  Had to use the full path to get it to work.    
  Then run "jupyter kernelspec install --name iocaml-kernel `pwd`" inside that directory.  
  And run  
    `DYLD_LIBRARY_PATH= pwd :$DYLD_LIBRARY_PATH && eval opam config env && jupyter notebook --Session.key= --notebook-dir=notebooks`  
  to get jupyter running (again inside the iocaml directory).
- Actually just `jupyter notebook --Session.key=` seems to work fine?
- Hydrogen connects directly to the kernels without going through Jupyter (even though it uses jupyter for the kernelspecs). In atom, trying to use Hydrogen with ocaml code causes it to hang. Running just `jupyter notebook without --Session.key=` causes the server to repeatedly connect and disconnect to the kernel, so this is probably the issue.

**Tuesday**  

IOCaml    
- Used 'apm develop hydrogen' to clone hydrogen as a development plugin, so I can modify it. To use my version I have to start atom with atom --dev.
- Trying to figure out where exactly in Hydrogen the key stuff is set. Adding lots of console.log statements.
- The connection to a kernel is created in kernel.coffee, which uses the config passed in by kernel-manager.coffee.
- KernelManager either generates the config or loads it from ./hydrogen/connection.json in the atom project directory. So you can set key: "" and signature_scheme: "" in the json file, but then every option must be set. This means ports aren't found automatically etc, they must be set manually.
* For now, I'm just hardcoding in the key and scheme into kernel.coffee.
- Trying to do more with iocaml. Need to #require various things, but #use "topfind" doesn't work. That can be fixed by adding a .iocamlinit file to ~, starting it with
```
  `let () =
    try Topdirs.dir_directory (Sys.getenv "OCAML_TOPLEVEL_PATH")
    with Not_found -> ()
  ;;
  #use "topfind";;
  #thread;;
  #require "iocaml-kernel.notebook";;
```
* The actual ocamlinit doesn't need the above to come before adding other things like #use "topfind". Shouldn't IOCaml load the toplevel path itself?
(Some of Monday and Tuesday is summarised in a gist on github)

**Wednesday**  
- Trying to figure out how iocaml displays data but I can't figure it out. There's something about adjustable type definitions.
- Trying to figure out how hmac stuff works in zmq, but I don't think I'm going to get anywhere. IOCaml is difficult to figure out. Sockets are opened in sockets.ml, messages are sent and received though message.ml only?
- Following datakit quick start. Managed to get the basics working.
- Trying to get ocaml 9p working, currently a dependency bug.
- Can't connect to the docker container yet, trying to figure out.

**Thursday**  

Datakit    
- I can run it in docker but I can't actually connect to it. Trying to connect ocaml-9p just eventually results in a timeout.
- Got it connecting, had to expose the port to the host using -p 5640:5640.
(Most of Thursday was spent reading about docker networking or looking at datakit or ocaml-9p, so not much to log.)

**Friday**  

Shell for ocaml-9p or datakit    
- Writing a quick lexer and parser for the commands so that things like strings and ids are actually handled properly.
- Works pretty well, quite resilient. Parses input into an AST of commands with their arguments. Also handles strings properly, plus relatively easy to extend.
- I'm writing this in such a way that tab completion should be fairly easy to add.
- To interact with Datakit I will need to install it properly rather than through docker so I can use it in my program. But currently it won't make - getting error during linking, undefined symbols for x86_64.
- Experimenting with Notty to make the shell interactive, for things like tab completion.
- Notty doesn't seem to support applications that aren't full screen terminal when capturing key presses. For example utop allows tab completion while still being scrollable. Notty generally seems to be more for graphics. lambda-term should support this but looks more low level and depends on Camomile.
- Notty also doesn't appear to clean up the terminal after ctrl + c, leaves mouse interaction on etc. And ctrl c can't be intercepted.
