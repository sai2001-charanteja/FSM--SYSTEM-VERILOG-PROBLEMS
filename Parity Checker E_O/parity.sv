module parity(
input clk,
input reset,
input data_in,
input valid,
input mode,
output logic parity_ok

);

logic flag;
enum {VALID,INVALID,IDLE} state;

always @(posedge clk or posedge reset) begin
	if(reset) state<= IDLE;
	else begin
		case(state) 
			IDLE 	: state <= (valid)? VALID:state;
			VALID	: state <= (!valid)?INVALID : state;
			INVALID: state <= (valid)?VALID:IDLE;
		endcase
	end
end

always @(posedge clk or posedge reset) begin
	if(reset) flag <= 0;
	else begin
		case(state) 
			VALID : flag <= flag + data_in;
			IDLE,INVALID : flag <= 0;
		endcase
	end	
end

always_comb begin
	case(state)
		IDLE,VALID : parity_ok = 0;
		INVALID : parity_ok = (mode==flag); 
	endcase
end

endmodule