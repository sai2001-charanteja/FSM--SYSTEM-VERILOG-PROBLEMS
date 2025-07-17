module washingMachine
(
input clk,
input reset,
input start,
input pause,

output logic [2:0] stage,
output done
);

parameter [3:0] FILL_TIME = 3;
parameter [3:0] WASH_TIME = 3;
parameter [3:0] RINSE_TIME = 3;
parameter [3:0] SPIN_TIME = 3;

enum {IDLE,FILL,WASH,RINSE,SPIN,STOP} state;

logic [3:0] icnt; 
logic [3:0] NEXT_STAGE_TIME;


always @(posedge clk or posedge reset) begin
	if(reset) state<= IDLE;
	else begin
		if(start) begin
			case(state)
				IDLE	: state <= FILL;
				FILL	: state <= (icnt==0)?WASH:state;
				WASH	: state <= (icnt==0)?RINSE:state;
				RINSE	: state <= (icnt==0)?SPIN:state;
				SPIN	: state <= (icnt==0)?STOP:state;
				STOP	: state <= IDLE;
			endcase
		end else state <= state;
	end
end


always_comb begin
	
	case(state)
	IDLE	: NEXT_STAGE_TIME = FILL_TIME;
	FILL	: NEXT_STAGE_TIME = WASH_TIME;
	WASH	: NEXT_STAGE_TIME = RINSE_TIME;
	RINSE	: NEXT_STAGE_TIME = SPIN_TIME;
	SPIN	: NEXT_STAGE_TIME = 1;
	STOP	: NEXT_STAGE_TIME = 1;
	endcase
	
end

always_comb begin
	
	case(state)
	IDLE	: stage = 0;
	FILL	: stage = 1;
	WASH	: stage = 2;
	RINSE	: stage = 3;
	SPIN	: stage = 4;
	STOP	: stage = 5;
	endcase
end

assign done = (state == STOP);

always @(posedge clk or posedge reset) begin
	if(reset) icnt<= 0;
	else begin
		if(start) begin
			icnt <= (icnt == 0)?NEXT_STAGE_TIME-1:icnt-1;
		end else icnt <= icnt;
	end
end


endmodule