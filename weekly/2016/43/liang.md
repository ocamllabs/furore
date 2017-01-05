1. I have implemented complex number support in Owl. The Dense module now have two submodules: Real and Complex which support dense matrices of real number and complex number respectively.

2. I also split the current Sparse module into two parts to support both real and complex sparse matrices. The real number is already supported but the complex number support in Sparse module is still missing.

3. I removed the dependency on Ctypes.Foreign module in Owl and change completely to stub generation as suggested by Yallop. So the interface to GSL is supposed to be faster and type safer.

4. I tested using functor to generalise some matrix operation, it worked fine but caused some performance penalty in certain operations that I am still trying to figure out the reason.

5. I gave a pitch of my kvasir project last night in Petershouse last night, since it entered into Cambridge Enterprise Business Plan competition. However, I didn’t win the first prize in the end but nice experience and received a lot of publicity.
