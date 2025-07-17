module digitallocksystem(
input clk,reset,
input [3:0]keypad_input,
input enter,
output unlocked,
output logic [1:0] attempts_left,
output locked_out
);


logic [1:0]next_attempts_left;

enum {ACCESS_GRANTED,LOCKED_OUT,D1,D2,D3,D4,D2N,D3N,D4N} state;

always_ff @(posedge clk or posedge reset) begin
	if(reset) state <= D1;
	else begin
			case(state)
			D1: if(enter) state <= (keypad_input == 4)?D2:D2N;
			D2: if(enter) state <= (keypad_input == 5)?D3:D3N;
			D3: if(enter) state <= (keypad_input == 6)?D4:D4N;
			D4: if(enter) state <= (keypad_input == 7)?ACCESS_GRANTED:((next_attempts_left==0)?LOCKED_OUT:D1);
			D2N:if(enter) state<= D3N;
			D3N:if(enter) state<= D4N;
			D4N:if(enter) state<= ((next_attempts_left==0)?LOCKED_OUT:D1);
			LOCKED_OUT : state <= state;
			ACCESS_GRANTED : state <= state;
		endcase
	end
end

assign next_attempts_left = (attempts_left == 0)?0:attempts_left-1;

always@(posedge clk or posedge reset) begin
	if(reset) attempts_left <= 3;
	else begin
		if(enter) begin
			case(state)
			D4: attempts_left <= (keypad_input == 7)?attempts_left:next_attempts_left;
			D4N: attempts_left<= next_attempts_left;
			default : attempts_left <= attempts_left;
		endcase
		end
	end
end

assign unlocked = (state == ACCESS_GRANTED);
assign locked_out = (state == LOCKED_OUT);


endmodule