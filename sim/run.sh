#!/bin/bash

rm -f a.lst a.out dump.vcd
#sed -i 's/TIME_SIM #b[0-9]b/TIME_SIM #$1/g' ../bench/tb_top.sv
iverilog -g2012 -s tb_top ../bench/tb_top.sv
vvp -l a.lst -n a.out -vcd
