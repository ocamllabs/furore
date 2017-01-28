- work done for Databox
  - meeting with mort and Liang to clarify the functionalities/patterns of interactions for the new system components to be developped: storage and bridge.
  - for storage, it will provide tamper-proof, append-only logging of each store operations, and it will support different data types: Json, Timeseries, Blob, etc. Later, we could be more high-level features like model based compression on this
  - for bridge, still needs more discussion and thinking, for the first step, we could build it with "redirect point" style, which allows third parties to register/update their services, look up the others' services, and also allows internal components to insert/delete their own plug-in functions.

- supervision
  - IB course CompNet
