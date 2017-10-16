- Refactor the CBLAS interface, the number of functions is significantly reduced by providing a generic interface for S/D/C/Z types.
- Optimise the core functions in Ndarray. I did some experiments trying to unifying matrix and ndarray types. It is doable but the current concern is then performance. Some operations like broadcast is faster in Matrix module than in Ndarray module.
- Tune the interface between Actor and Owl, did some distributed learning experiments.