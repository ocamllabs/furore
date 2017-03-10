- The GSL dependency has been removed from the core components in Owl.
- Current modules (partly) rely on GSL are Maths, Stats, FFT. I am currently wrapping up Cephes to replace GSL-based modules.
- I spend some time in refining the AD interface. The following code show how to build a trival neural network with AD (from scratch).
<script src="https://gist.github.com/ryanrhymes/582e1d1a5f3cd47a6b96fe5bed4914e8.js"></script>
- However, I noticed the memory consumption grows really fast in the previous naive neural network experiment. The allocated memory did not seem to be correctly released after usage. I still try to identify the (possible) memory leak issue. Let me know if anyone has any idea about this.
