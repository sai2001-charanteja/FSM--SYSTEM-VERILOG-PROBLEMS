program testbench(
input clk,
output logic reset,
output logic [7:0] rfid_data,
output logic valid,

input door_unlock,
input access_granted,
input access_denied
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
		
		valid = 1;
		rfid_data = $random;
		@(posedge clk) valid = 0;
		
		wait(door_unlock||access_granted||access_denied);
		
		repeat(2)@(posedge clk);
	end
end

endprogram