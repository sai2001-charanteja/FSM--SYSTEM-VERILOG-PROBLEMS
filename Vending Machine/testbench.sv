program testbench
(input clk,
output logic reset,
output logic [1:0]coin,
input produt_dispence,
input [2:0]return_change
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
	
	repeat(100) begin
		
		coin <= $urandom_range(1,2);
		@(posedge clk);
	
	end
	repeat(2)@(posedge clk);
end


endprogram