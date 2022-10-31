module seven_segment_decoder(
	input wire [3:0] in_4bit, 
	output wire [6:0] out_seven_segment);
	//
	function [6:0] led_decoder;
		//
		input [3:0] in_number;
		//
		begin
			case (in_number)
				4'h0:
					led_decoder = 7'b1000000;
				4'h1:
					led_decoder = 7'b1111001;
				4'h2:
					led_decoder = 7'b0100100;
				4'h3:
					led_decoder = 7'b0110000;
				4'h4:
					led_decoder = 7'b0011001;
				4'h5:
					led_decoder = 7'b0010010;
				4'h6:
					led_decoder = 7'b0000010;
				4'h7:
					led_decoder = 7'b1111000;
				4'h8:
					led_decoder = 7'b0000000;
				4'h9:
					led_decoder = 7'b0011000;
				4'ha:
					led_decoder = 7'b0001000;
				4'hb:
					led_decoder = 7'b0000011;
				4'hc:
					led_decoder = 7'b0100111;
				4'hd:
					led_decoder = 7'b0100001;
				4'he:
					led_decoder = 7'b0000110;
				4'hf:
					led_decoder = 7'b0001110;
				default:
					led_decoder = 7'b1111111;
			endcase
		end
	endfunction
	//
	assign out_seven_segment[6:0] = led_decoder(in_4bit);
	//
endmodule