module StateMachine(
	input wire in_clk, 
	input wire [9:0] in_switch, 
	input wire [3:0] in_button,
	output wire [9:0] out_led, 
	output wire [6:0] seven_segment_0, 
	output wire [6:0] seven_segment_1, 
	output wire [6:0] seven_segment_2, 
	output wire [6:0] seven_segment_3, 
	output wire [6:0] seven_segment_4, 
	output wire [6:0] seven_segment_5);

	//
	// global reset
	//

	wire global_reset = ~in_button[0];
	
	//
	// clock divder for 1 sec
	//

	parameter STATE_INTEVAL = 26'd49_999_999;
	reg [25:0] _26bit_counter;
	wire _26bit_counter_expired;
	assign _26bit_counter_expired = (_26bit_counter == STATE_INTEVAL)? 1'b1: 1'b0;

	always @(posedge in_clk or posedge global_reset)
	begin
		if (global_reset)
			_26bit_counter <= 26'd0;
		else
		begin
			if (_26bit_counter_expired)
				_26bit_counter <= 26'd0;
			else
				_26bit_counter <= _26bit_counter + 26'd1;
		end
	end
	
	wire is_state_inteval = _26bit_counter_expired;
	
	//
	// state machine
	//

	parameter STATE0 = 2'b00;
	parameter STATE1 = 2'b01;
	parameter STATE2 = 2'b10;
	parameter STATE3 = 2'b11;
	
	wire state_up = ~in_button[2];
	wire state_down = ~in_button[1];
	reg [1:0] state_machine = STATE0;

	always @(state_up or state_down or global_reset )
	begin
		if (global_reset)
			state_machine = STATE0;
		else
		begin
			case (state_machine)
				STATE0:
					if (state_up == 1'b1)
						state_machine <= STATE1;
				STATE1:
					if (state_up == 1'b1)
						state_machine <= STATE2;
					else if (state_down == 1'b1)
						state_machine <= STATE0;
				STATE2:
					if (state_up == 1'b1)
						state_machine <= STATE3;
					else if (state_down == 1'b1)
						state_machine <= STATE1;
				STATE3:
					state_machine <= STATE3;
				default:
					state_machine <= STATE0;
			endcase
		end
	end
	
	//
	// 1sec counter
	//
	
	reg [15:0] _1sec_counter;
	always @(posedge in_clk or posedge global_reset)
	begin
		if (global_reset)
			_1sec_counter <= 16'd0;
		else
		begin
			if (is_state_inteval)
			begin
				case (state_machine)
					STATE0:
						_1sec_counter <= 16'd0;
					STATE1:
						_1sec_counter <= _1sec_counter + 16'd0;
					STATE2:
						_1sec_counter <= _1sec_counter - 16'd0;
					STATE3:
						_1sec_counter <= _1sec_counter;						
					default:
						_1sec_counter <= 16'd0;
				endcase
			end
		end
	end

	
	//
	// display
	//
	
	assign out_led[9:2] = 8'b00_0000_0000;
	assign out_led[1:0] = state_machine;
	
	seven_segment_decoder seven_segment_decoder_0(
		.in_4bit(_1sec_counter[3:0]), 
		.out_seven_segment(seven_segment_0));
	seven_segment_decoder seven_segment_decoder_1(
		.in_4bit(_1sec_counter[7:4]), 
		.out_seven_segment(seven_segment_1));
	seven_segment_decoder seven_segment_decoder_2(
		.in_4bit(_1sec_counter[11:8]), 
		.out_seven_segment(seven_segment_2));
	seven_segment_decoder seven_segment_decoder_3(
		.in_4bit(_1sec_counter[15:12]), 
		.out_seven_segment(seven_segment_3));
	assign seven_segment_4 = 7'b111_1111;
	assign seven_segment_5 = 7'b111_1111;
	
endmodule
