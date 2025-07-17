program testbench(
input clk,
output logic reset,
output logic start_tx,
output logic [7:0] data_in,

input sclk,
input mosi,
input ss,
input tx_done

);

logic flag ;

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
		
		start_tx = 1;
		data_in = $random;
		@(posedge clk) start_tx = 0;
		while(!tx_done) @(posedge clk);
		repeat(2)@(posedge clk);
	end
end

endprogram