onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top/tb/clk
add wave -noupdate /top/tb/reset
add wave -noupdate /top/tb/keypad_input
add wave -noupdate /top/tb/enter
add wave -noupdate /top/tb/unlocked
add wave -noupdate /top/tb/attempts_left
add wave -noupdate /top/tb/locked_out
add wave -noupdate /top/dut/next_attempts_left
add wave -noupdate /top/dut/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {71 ns} 0}
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
WaveRestoreZoom {0 ns} {250 ns}
