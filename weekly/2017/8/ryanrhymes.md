- The first version of backward AD was implemented in Algodiff module. I overloaded most of the commonly used math operators.
- I added another sub-module in Algodiff which is able to provide numerical differentiation. This can be used to cross-validate the results from Algodiff.AD module.
- I added more functions (softplus, softsign, sigmoid, softmax, etc.) to Owl to provide better support for machine learning algorithms.
- I have been doing experiment for Paar paper, and at the same time we have been trying to make ARM-based docker image for Owl so that we can run it on Raspberry Pi.