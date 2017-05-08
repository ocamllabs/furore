- Submitted a paper on concurrent programming with effect handlers to TFP. Draft
  is [here](kcsrk.info/papers/system_effects_may_17.pdf)
- As a part of the submission, benchmarked http/af with async and effects and
  compared it against a Go webserver. The results are included in the paper.
- We discovered that effects version was leaking memory, which was down to the
  program leaking bigstrings due to finalizers not being implemented on
  Multicore. Finalizers for custom objects should be easy to fix. 
