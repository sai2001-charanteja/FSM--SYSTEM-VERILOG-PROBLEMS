enum {GO_MODE,CAUTION_MODE} time_mode;
module tb;

bit clk,reset;
reg [3:0] emergency;
wire [1:0] current_free_path;

traffic_simulation dut(clk,reset,emergency,current_free_path);

always #5 clk = ! clk;

task apply_reset();
	reset <= 1;
	repeat(3)@(posedge clk);
	reset <= 0;
endtask

initial begin
	apply_reset();
	emergency <=0;
	repeat(10) begin
		#100;
		emergency  <= $urandom_range(0,15);
		wait(dut.time_mode == CAUTION_MODE);
	end
	#10000
	$finish;

end

endmodule