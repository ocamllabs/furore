- Implementation (Netmap on Solo5-ukvm)
  - Trying to identify what factor affects the performance degradation. I found that GC related statistics under the solo5 with Netmap environment under single/concurrent send-recv pair(s) has not changed.
  - Started implementing an OCaml module for rdtsc() which is used to measure the execution time of a OCaml function on Solo5/ukvm.
