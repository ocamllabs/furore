- databox-export-service
  - bug fixes and working arounds to make the demo work for the launch, mainly tied to macaroons-related stuff
  - disabled the tests on dockerhub autobuild, refer to [PR](https://github.com/me-box/databox-export-service/pull/14)
  - NB: impression was that the image from autobuild could be corrupted? *Output like: Illegal Instruction (core dumped), through gdb found that the binaries tried to disable address space randomization?*

- databox-bridge:
  - such unstable that could make it for the launch event, will keep persuing this end later
  - should figure out the right timing and order of network creating and connection
  - should provide better failure control within inner libs
