mojo-simple-visualizer
======================

Straightforward example for setting individual LEDs on the Mojo FPGA visualizer shield.

I recently acquired a Mojo FPGA and visualizer shield.
I'm new to this kind of thing, and everything is strange is confusing.
It took me literally days to figure out how to individually address the LEDs.
If anyone else is having similar difficulties, hopefully this will help.

Just replace the `mojo_top.v`, `mstr_ctrl.v`, and `mojo.ucf` files in the Mojo-Clock project with the files from this project and you are set.

(The reason that this is not a complete project is that the licence blob at the top of some of those Xilinx files is scary.)
