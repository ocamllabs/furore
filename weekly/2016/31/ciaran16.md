**Wednesday**  

Current state of the shell:
- Commands work, but I haven't actually added most of the commands. E.g. connecting doesn't actually work as it's asynchronous, so using Lwt throughout is top priority.
- Tab completion doesn't really work. It kind of did at one point, but I've changed quite a lot of stuff since then. Should be fairly easy to get working again though.
- Parsing the input works mostly fine, handles quotes / strings, allows escaping etc.
- Notty interface now works, which means I can continue using Notty, but it isn't perfect.
