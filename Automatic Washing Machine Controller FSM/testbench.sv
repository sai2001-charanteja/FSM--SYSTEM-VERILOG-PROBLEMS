program testbench(
input clk,
output logic reset,
output logic start,
output logic pause,

input [2:0] stage,
input done

);

integer temp;
task apply_reset();
	$display("[Reset] Started at time: %0t",$time);
	reset <= 1;
	repeat(2) @(posedge clk);
	reset <= 0;
	$display("[Reset] Completed at time: %0t",$time);
	
endtask

initial begin
	
	apply_reset();
	
	repeat(5) begin
	
		start = 1;
		pause = 0;
		temp = $urandom_range(5,20);
		repeat(temp) @(posedge clk);
			
		start = 0;
		pause = 1;
		temp = $urandom_range(5,20);
		repeat(temp) @(posedge clk);
		
	end
end

endprogram