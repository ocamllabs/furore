## opam
- PR#2912 merged
- Discussions with Louis on file format features required for Windows
  * Improved mechanism for detecting undefined variables.
      Presently, you can use "%{foo}%" which expands to "" if foo is undefined.
      New proposal adds operator ? so that ?foo returns false if foo is not defined.
  * Allow variables in ternary operator in string expansion.
      Presently, you can use "%{foo?bar:baz}%".
      New proposal requires strings to be single quoted and interpret the rest as variables.
      So far, so hacky, but unfortunately you can't use scoped variables
        e.g. what should "%{foo?bar:path:lib}%" mean?
      Shelved, as there are other workarounds for this.
  * Mechanism for initialising switch global variables by extending /etc/opamrc
- Upstreaming PR#2915 to fix issues with debugging failed updates
- Upstreaming PR#2923 to fix issues with renaming the test and doc variables in opam-repository
- Upstreaming PR#2921 to implement the defined operator ? described above
