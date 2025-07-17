program testbench(
input clk,
output logic reset,
output logic data_in,
output logic valid,
output logic mode,
input parity_ok

);

int temp;

task apply_reset();
	$display("[Reset] Started at time: %0t",$time);
	reset <= 1;
	repeat(2) @(posedge clk);
	reset <= 0;
	$display("[Reset] Completed at time: %0t",$time);
	
endtask

initial begin
	
	apply_reset();
	valid = 1;
	repeat(100) begin
		
		temp = $urandom_range(0,20);
		{valid,mode}= $random;
		
		repeat(temp) begin
		data_in = $random;
		@(posedge clk);
		end
	end
end

endprogram