onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/clk
add wave -noupdate /tb/reset
add wave -noupdate /tb/emergency
add wave -noupdate /tb/current_free_path
add wave -noupdate /tb/dut/clk
add wave -noupdate /tb/dut/reset
add wave -noupdate -radix binary /tb/dut/emergency
add wave -noupdate /tb/dut/current_free_path
add wave -noupdate /tb/dut/time_mode
add wave -noupdate /tb/dut/timer_cnt
add wave -noupdate -radix unsigned /tb/dut/time_limit
add wave -noupdate /tb/dut/prev_free_path
add wave -noupdate /tb/dut/cur_dir
add wave -noupdate /tb/dut/next_dir
add wave -noupdate /tb/dut/prev_dir
add wave -noupdate {/tb/dut/dir_signals[0]}
add wave -noupdate {/tb/dut/dir_signals[1]}
add wave -noupdate {/tb/dut/dir_signals[2]}
add wave -noupdate {/tb/dut/dir_signals[3]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {314 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {253 ns} {679 ns}
