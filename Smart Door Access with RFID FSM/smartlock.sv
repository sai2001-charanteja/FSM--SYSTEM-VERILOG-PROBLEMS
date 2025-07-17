module smartlock
(
input clk,
input reset,
input [7:0] rfid_data,
input valid,

output door_unlock,
output access_granted,
output access_denied
);

enum {IDLE,CHECK_ACCESS,ACCESS_GRANTED,DOOR_UNLOCK,ACCESS_DENIED} state;
parameter [7:0] mem = 129;
logic [7:0] temp_rfid;
logic check_status;
always @(posedge clk or posedge reset) begin
	if(reset) state <= IDLE;
	else begin
		case(state) 
		IDLE: state <= (valid)? CHECK_ACCESS:state;
		CHECK_ACCESS: state <= (check_status)?ACCESS_GRANTED:ACCESS_DENIED;
		ACCESS_GRANTED: state<= DOOR_UNLOCK;
		DOOR_UNLOCK : state <= IDLE;
		ACCESS_DENIED: state <= IDLE;
		endcase
	end
end

always @(posedge clk or posedge reset) begin
	if(reset) temp_rfid <= 0;
	else begin
		case(state) 
			IDLE : temp_rfid <= (valid)?rfid_data:temp_rfid;
			default : temp_rfid <= temp_rfid;
		endcase
	end
end	

assign check_status  =  (state == CHECK_ACCESS)?(mem==temp_rfid):0;
assign access_granted = (state == ACCESS_GRANTED);
assign door_unlock = (state== DOOR_UNLOCK);
assign access_denied = (state == ACCESS_DENIED);


endmodule