This project shows the generation differences between CMake's "Unix Makefile" and "Ninja" generator.

It is expected that both produce the same binary. However, the two binaries’ "NEEDED" entries, which reference shared libraries, differ. As a result, the "Ninja" based version is not executable.

Start the "build.sh" script to run the demo.

A workaround for this bug is to add a "IMPORTED_NO_SONAME ON" in the "set_target_properties" statement of the used shared library.
