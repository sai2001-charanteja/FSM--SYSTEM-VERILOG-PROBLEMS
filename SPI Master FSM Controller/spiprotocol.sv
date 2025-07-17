module spiprotocol(

input clk,
input reset,
input start_tx,
input [7:0] data_in,

output logic sclk, // slave clock
output logic mosi, // Master out slave in
output ss, // Slave Select
output tx_done // transaction
);


enum {IDLE,LOAD,SHIFT,DONE} state;
logic [7:0] shift_reg;
logic clk_en;
logic [2:0] icnt;

always @(clk or posedge reset) begin
	if(reset) sclk <= 0;
	else begin
		if(clk_en) sclk <= clk;
		else sclk <= 0;
	end
end


always @(posedge clk or posedge reset) begin
	if(reset) icnt <= 3'd0;
	else begin
		if(state == SHIFT) icnt <= icnt+1;
		else if(state == DONE) icnt <= 0;
		else icnt <= 3'd0;
	end
end

always @(posedge clk or posedge reset) begin
	if(reset) state <= IDLE;
	else begin
		case(state)
			IDLE: state <= (start_tx)?LOAD: state;
			LOAD: state <= SHIFT;
			SHIFT: state <= (icnt == 7)? DONE: state;
			DONE: state <= IDLE;
		endcase
	end
end

always @(posedge clk or posedge reset) begin
	if(reset) shift_reg <= 8'bx;
	else begin
		if(state== IDLE) shift_reg <= (start_tx)?data_in:shift_reg;
		else shift_reg <= shift_reg;
	end
end

assign tx_done = (state == DONE);
assign clk_en = (state != IDLE);
assign ss = (state != IDLE);


always @(posedge clk or posedge reset) begin
	if(reset) mosi <= 1'bx;
	else begin
		mosi <= (state == SHIFT)?shift_reg[icnt]:1'bx;
	end

end



endmodule



/* module spiprotocol (
    input  logic        clk,
    input  logic        reset,
    input  logic        start_tx,
    input  logic [7:0]  data_in,

    output logic        SCLK,
    output logic        MOSI,
    output logic        SS,
    output logic        tx_done
);

    // FSM States
    typedef enum logic [1:0] {
        IDLE,
        LOAD,
        SHIFT,
        DONE
    } state_t;

    state_t state, next_state;

    logic [7:0] shift_reg;
    logic [2:0] bit_cnt;
    logic       sclk_en;
    logic       clk_div;
    logic       clk_phase;

    // SCLK generation: divide clock by 2
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            clk_div <= 0;
        else if (sclk_en)
            clk_div <= ~clk_div;
        else
            clk_div <= 0;
    end

    assign SCLK = (state == SHIFT) ? clk_div : 1'b0;

    // FSM State Register
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // FSM Transitions
    always_comb begin
        next_state = state;
        case (state)
            IDLE:  next_state = start_tx ? LOAD : IDLE;
            LOAD:  next_state = SHIFT;
            SHIFT: next_state = (bit_cnt == 3'd7 && clk_div && clk_phase) ? DONE : SHIFT;
            DONE:  next_state = IDLE;
        endcase
    end

    // Control Signals and Logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 0;
            bit_cnt   <= 0;
            MOSI      <= 0;
            SS        <= 1;
            tx_done   <= 0;
            sclk_en   <= 0;
            clk_phase <= 0;
        end else begin
            tx_done <= 0;

            case (state)
                IDLE: begin
                    SS      <= 1;
                    sclk_en <= 0;
                end
                LOAD: begin
                    shift_reg <= data_in;
                    bit_cnt   <= 0;
                    SS        <= 0;
                    sclk_en   <= 1;
                end
                SHIFT: begin
                    // Toggle phase on each clk_div edge
                    clk_phase <= ~clk_phase;

                    if (clk_phase == 0) begin
                        MOSI <= shift_reg[7];  // Output MSB
                    end else begin
                        shift_reg <= {shift_reg[6:0], 1'b0};  // Shift left
                        if (bit_cnt < 3'd7)
                            bit_cnt <= bit_cnt + 1;
                    end
                end
                DONE: begin
                    SS      <= 1;
                    sclk_en <= 0;
                    tx_done <= 1;
                end
            endcase
        end
    end

endmodule */

