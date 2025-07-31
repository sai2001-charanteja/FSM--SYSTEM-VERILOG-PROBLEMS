module traffic_simulation(input clk,reset, input [3:0]emergency, output logic [1:0]current_free_path);

typedef enum {RED,GREEN,YELLOW} signals;

typedef enum {EAST, WEST, NORTH, SOUTH} dir;

enum {GO_MODE,CAUTION_MODE} time_mode;

signals dir_signals[3:0]; 

parameter [4:0] GO_TIME_LIMIT = 5'd30;
parameter [3:0] CAUTION_TIME_LIMIT = 4'd5;

logic [4:0] timer_cnt;
logic [4:0] time_limit;
logic [1:0]prev_free_path;
dir cur_dir;
dir next_dir;
dir prev_dir;


always_ff @(posedge clk or posedge reset) begin 	// CURRENT DIRECTION BASED ON THE TIMER COUNT
	if(reset) begin
		cur_dir <= EAST;
		prev_dir <= EAST;
	end else begin
		if(timer_cnt == GO_TIME_LIMIT) begin
			prev_dir <= cur_dir;
			if(emergency == 0) cur_dir <= next_dir;	//EMERGENCY HANDLING AT THE END OF THE GO_LIMIT
			else begin
				case(cur_dir) // Algorithmic State Machine 
					EAST	:	
						if(emergency[2]) cur_dir <= next_dir;
						else if(emergency[1]) cur_dir <= WEST;
						else if(emergency[0]) cur_dir <= SOUTH;
						else cur_dir <= next_dir;
 					NORTH	:
						if(emergency[1]) cur_dir <= next_dir;
						else if(emergency[0]) cur_dir <= SOUTH;
						else if(emergency[3]) cur_dir <= EAST;
						else cur_dir <= next_dir;
					WEST	:
						if(emergency[0]) cur_dir <= next_dir;
						else if(emergency[3]) cur_dir <= EAST;
						else if(emergency[2]) cur_dir <= NORTH;
						else cur_dir <= next_dir;
					SOUTH	:
						if(emergency[3]) cur_dir <= next_dir;
						else if(emergency[2]) cur_dir <= NORTH;
						else if(emergency[1]) cur_dir <= WEST;
						else cur_dir <= next_dir;
				endcase
			 end
		end 
	end
end


always_comb begin	// NEXT DIRECTION INDEX
	case(cur_dir) 
	EAST	: current_free_path = 0;
	NORTH	: current_free_path = 1;
	WEST	: current_free_path = 2;
	SOUTH	: current_free_path = 3;
	endcase
end

always_comb begin	// PREV DIRECTION
	case(prev_dir) 
	EAST	: prev_free_path = 0;
	NORTH	: prev_free_path = 1;
	WEST	: prev_free_path = 2;
	SOUTH	: prev_free_path = 3;
	endcase
end

always_comb begin	// NEXT DIRECTION
	case(cur_dir) 
	EAST	: next_dir = NORTH;
	NORTH	: next_dir = WEST;
	WEST	: next_dir = SOUTH;
	SOUTH	: next_dir = EAST;
	endcase
end



always_ff @(posedge clk or posedge reset) begin
	if(reset) timer_cnt <= 1;
	else begin
		timer_cnt <= (timer_cnt >= time_limit)?1:timer_cnt+1;
	end
end


always_ff @(posedge clk or posedge reset) begin
	if(reset) time_mode <= GO_MODE;
	else begin
		case(time_mode) 
		GO_MODE	: time_mode <= (timer_cnt==GO_TIME_LIMIT)?CAUTION_MODE:time_mode;
		CAUTION_MODE: time_mode <= (timer_cnt==CAUTION_TIME_LIMIT)?GO_MODE:time_mode;
		endcase
	end
end

always_comb begin
	case(time_mode)
		GO_MODE	: time_limit = GO_TIME_LIMIT;
		CAUTION_MODE: time_limit = CAUTION_TIME_LIMIT;
	endcase
end

always_ff @(posedge clk or posedge reset) begin
	if(reset) begin
		dir_signals[0] <= GREEN;
		for(int i=1;i<4;i++) dir_signals[i] <= RED;
	end else begin
		case(time_mode)
		GO_MODE: 
			if(timer_cnt == 1) begin
				dir_signals[current_free_path] <= GREEN;
				dir_signals[prev_free_path] <= RED;
			end	
		CAUTION_MODE : 
			if(timer_cnt == 1) begin
				dir_signals[current_free_path] <= YELLOW;
				dir_signals[prev_free_path] <= YELLOW;
			end	
		endcase
	end
end

endmodule