program testbench(
input clk,
output logic reset, 
output logic [3:0]floor_requested,
input [1:0]current_floor,
input move_up,move_down,door_open
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
		
		floor_requested <= 1<<$urandom_range(0,3);
		@(posedge clk);
	end
	
	repeat(2) @(posedge clk);
end

endprogram