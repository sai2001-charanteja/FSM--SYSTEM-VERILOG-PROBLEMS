vlib work
vdel -all
vlib work

vlog traffic_simulation.sv +acc
vlog testbench.sv +acc

vsim work.tb
#add wave -r *
do wave.do
run -all