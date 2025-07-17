program testbench(
input clk,
output logic reset,
output logic [3:0]keypad_input,
output logic enter,
input unlocked,
input logic [1:0] attempts_left,
input locked_out
);


task apply_reset();
	$display("[Reset] Started at time: %0t",$time);
	reset <= 1;
	repeat(2) @(posedge clk);
	reset <= 0;
	$display("[Reset] Completed at time: %0t",$time);
	
endtask

initial begin
	
	
	apply_reset();
	
	repeat(50) begin
		enter = $random;
		keypad_input <= $urandom_range(0,9);
		@(posedge clk);
		
	end
	apply_reset();
	enter =1;
	for(int idx=0;idx<10;idx++) begin
		
		keypad_input <= idx; 
		@(posedge clk);
	end
	
	
	repeat(2) @(posedge clk);
end

endprogram