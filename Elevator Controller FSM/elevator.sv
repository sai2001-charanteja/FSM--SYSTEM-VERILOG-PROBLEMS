module elevator(
input clk,reset, 
input [3:0]floor_requested, // one hot signal
output logic [1:0]current_floor,
output logic move_up,move_down,door_open
);

enum {F0,F1U,F1D,F2U,F2D,F3} state;

enum {MOVING_UP,MOVING_DOWN,OPEN,IDLE} mov_state;

	always_ff @(posedge clk or posedge reset) begin
		if(reset) state<=F0;
		else begin
			case(state)
				F0	:
					case(1)
						floor_requested[0] : state <= F0; 
						floor_requested[1] : state <= F1U;
						floor_requested[2] : state <= F2U;
						floor_requested[3] : state <= F3; 
					endcase
				F1U	:
					case(1)
						floor_requested[1] : state <= F1U; 
						floor_requested[2] : state <= F2U;
						floor_requested[3] : state <= F3;
						floor_requested[0] : state <= F0;  
					endcase
				F1D	:
					case(1)
						floor_requested[1] : state <= F1D; 
						floor_requested[0] : state <= F0;  
						floor_requested[2] : state <= F2U; 
						floor_requested[3] : state <= F3;  
					endcase
				F2U	:
					case(1)
						floor_requested[2] : state <= F2U; 
						floor_requested[3] : state <= F3;  
						floor_requested[1] : state <= F1D; 
						floor_requested[0] : state <= F0;  
					endcase
				F2D	:
					case(1)
						floor_requested[2] : state <= F2U; 
						floor_requested[1] : state <= F1D; 
						floor_requested[0] : state <= F0;  
						floor_requested[3] : state <= F3;  
					endcase
				F3	:
					case(1)
						floor_requested[3] : state <= F3;  
						floor_requested[2] : state <= F2U; 
						floor_requested[1] : state <= F1D; 
						floor_requested[0] : state <= F0;  
					endcase
			endcase
		end
	end
	
	always_ff @(posedge clk or posedge reset) begin
		if(reset) mov_state<=IDLE;
		else begin
			case(state)
				F0	:
					case(1)
						floor_requested[0] : mov_state <= OPEN; //open
						floor_requested[1] : mov_state <= MOVING_UP;
						floor_requested[2] : mov_state <= MOVING_UP;
						floor_requested[3] : mov_state <= MOVING_UP; //up
					endcase
				F1U	:
					case(1)
						floor_requested[1] : mov_state <= OPEN; //open
						floor_requested[2] : mov_state <= MOVING_UP;
						floor_requested[3] : mov_state <= MOVING_UP;
						floor_requested[0] : mov_state <= MOVING_DOWN;// down
					endcase
				F1D	:
					case(1)
						floor_requested[1] : mov_state <= OPEN; //open //down
						floor_requested[0] : mov_state <= MOVING_DOWN;  // down
						floor_requested[2] : mov_state <= MOVING_UP; //up
						floor_requested[3] : mov_state <= MOVING_UP;  //up
					endcase
				F2U	:
					case(1)
						floor_requested[2] : mov_state <= OPEN; //open //up
						floor_requested[3] : mov_state <= MOVING_UP;  //up
						floor_requested[1] : mov_state <= MOVING_DOWN; //down
						floor_requested[0] : mov_state <= MOVING_DOWN;  //down
					endcase
				F2D	:
					case(1)
						floor_requested[2] : mov_state <= OPEN; //open //down
						floor_requested[1] : mov_state <= MOVING_DOWN; //down
						floor_requested[0] : mov_state <= MOVING_DOWN;  //down
						floor_requested[3] : mov_state <= MOVING_UP;  //up
					endcase
				F3	:
					case(1)
						floor_requested[3] : mov_state <= OPEN;  //open //up
						floor_requested[2] : mov_state <= MOVING_DOWN; //down
						floor_requested[1] : mov_state <= MOVING_DOWN; //down
						floor_requested[0] : mov_state <= MOVING_DOWN;  //down
					endcase
			endcase
		end
	end
	
	
	always_comb begin
		case(mov_state) 
			IDLE		:
						begin
							move_up 	= 0;
							move_down 	= 0;
							door_open		= 0;
						end
			OPEN		: 
						begin
							move_up 	= 0;
							move_down 	= 0;
							door_open		= 1;
						end
			MOVING_UP	:
						begin
							move_up 	= 1;
							move_down 	= 0;
							door_open		= 0;
						end
			MOVING_DOWN	:
						begin
							move_up 	= 0;
							move_down 	= 1;
							door_open		= 0;
						end
			
		endcase
	end
	
	always_comb begin
		case(state) 
			F0		: current_floor = 0;
			F1U,F1D	: current_floor = 1;
			F2U,F2D	: current_floor = 2;
			F3		: current_floor = 3;
		endcase
	end
	

endmodule
