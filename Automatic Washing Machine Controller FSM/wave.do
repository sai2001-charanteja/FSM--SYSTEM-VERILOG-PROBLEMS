onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top/clk
add wave -noupdate /top/reset
add wave -noupdate /top/start
add wave -noupdate /top/pause
add wave -noupdate /top/stage
add wave -noupdate /top/done
add wave -noupdate /top/dut/state
add wave -noupdate /top/dut/icnt
add wave -noupdate /top/dut/NEXT_STAGE_TIME
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {599 ns} 0}
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
WaveRestoreZoom {0 ns} {310 ns}
