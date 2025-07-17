module vending(
input clk,reset,
input [1:0]coin, 
output logic product_dispence,
output logic [2:0]return_change
);

logic [2:0] accumulator;
logic [2:0] next_ttl;
enum {EMPTY,PAR,EQUAL,EXCEED} state;


always_ff @(posedge clk or posedge reset) begin
	if(reset) state <= EMPTY;
	else begin
		case(state)
			EMPTY : state <= ((next_ttl>0)?PAR : EMPTY); 
			PAR   :  state <= ((next_ttl==5)? EQUAL: ((next_ttl>5)?EXCEED:state)); 
			EQUAL,EXCEED : state <= EMPTY;
		endcase
	end
end

always_ff @(posedge clk or posedge reset) begin
	if(reset) accumulator<=0;
	else begin
		case(state)
			EMPTY,PAR 	: accumulator <= next_ttl;
			EQUAL,EXCEED: accumulator <= 0;
		endcase
	end
end

assign next_ttl = accumulator + {1'b0,coin};


always_comb begin
	case(state)
		EMPTY,PAR 	: begin
						product_dispence = 0;
						return_change = 0;
					end	
		EQUAL,EXCEED: 
					begin
						product_dispence = 1;
						return_change = accumulator - 3'd5;
					end
	endcase
end


endmodule