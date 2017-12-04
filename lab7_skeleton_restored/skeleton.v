module skeleton(resetn, 
	ps2_clock, ps2_data, 										// ps2 related I/O
	debug_data_in, debug_addr, leds, 						// extra debugging ports
	lcd_data, lcd_rw, lcd_en, lcd_rs, lcd_on, lcd_blon,// LCD info
	seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8,		// seven segements
	VGA_CLK,   														//	VGA Clock
	VGA_HS,															//	VGA H_SYNC
	VGA_VS,															//	VGA V_SYNC
	VGA_BLANK,														//	VGA BLANK
	VGA_SYNC,														//	VGA SYNC
	VGA_R,   														//	VGA Red[9:0]
	VGA_G,	 														//	VGA Green[9:0]
	VGA_B,															//	VGA Blue[9:0]
	CLOCK_50,
	switch0, switch1, switch2);  													// 50 MHz clock
	
	
	/* 
	
	##		CHANGELOG: 
	
	
	
	
	
	*/ 
		
	////////////////////////	VGA	////////////////////////////
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK;				//	VGA BLANK
	output			VGA_SYNC;				//	VGA SYNC
	output	[7:0]	VGA_R;   				//	VGA Red[9:0]
	output	[7:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[7:0]	VGA_B;   				//	VGA Blue[9:0]
	input				CLOCK_50;
	input switch0, switch1, switch2;

	////////////////////////	PS2	////////////////////////////
	input 			resetn;
	inout 			ps2_data, ps2_clock;
	
	////////////////////////	LCD and Seven Segment	////////////////////////////
	output 			   lcd_rw, lcd_en, lcd_rs, lcd_on, lcd_blon;
	output 	[7:0] 	leds, lcd_data;
	output 	[6:0] 	seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8;
	output 	[31:0] 	debug_data_in;
	output   [11:0]   debug_addr;
	
	
	
	
	
	wire			 clock;
	wire			 lcd_write_en;
	wire 	[31:0] lcd_write_data;
	wire	[7:0]	 ps2_key_data;
	wire			 ps2_key_pressed;
	wire	[7:0]	 ps2_out;	
	
	// clock divider (by 5, i.e., 10 MHz)
	pll div(CLOCK_50,inclock);
	assign clock = CLOCK_50;
	
	// UNCOMMENT FOLLOWING LINE AND COMMENT ABOVE LINE TO RUN AT 50 MHz
	//assign clock = inclock;
	
	// your processor
	processor myprocessor(clock, ~resetn, /*ps2_key_pressed, ps2_out, lcd_write_en, lcd_write_data,*/ debug_data_in, debug_addr);
	
	// keyboard controller
	PS2_Interface myps2(clock, resetn, ps2_clock, ps2_data, ps2_key_data, ps2_key_pressed, ps2_out);
//	reg [7:0] ps2_out_mod;
	wire [7:0] text;
	wire a, b, c, d;
	assign a = (ps2_out == 8'h1C);
	assign b = (ps2_out == 8'h32);
	assign c = (ps2_out == 8'h21);
	assign d = (ps2_out == 8'h23);
//	and and_a(a, ps2_out, 8'h1C);
//	and and_b(b, ps2_out, 8'h32);
//	and and_c(c, ps2_out, 8'h21);
//	and and_d(d, ps2_out, 8'h23);
	assign text = a ? 8'h61 : (b ? 8'h62 : (c ? 8'h63 : (d ? 8'h64 : 8'h65)));
//	always @(posedge ps2_clock)
//	begin
//		if (ps2_out == 8'h1C)
//		begin
//			ps2_out_mod <= 8'h61; 
//		end
//		else if (ps2_out == 8'h32)
//		begin
//			ps2_out_mod <= 8'h62;
//		end
//		else if (ps2_out == 8'h21)
//		begin
//			ps2_out_mod <= 8'h63;
//		end
//		else if (ps2_out == 8'h23)
//		begin
//			ps2_out_mod <= 8'h64;
//		end
//		else
//		begin
//			ps2_out_mod <= ps2_out;
//		end
//	end
//	assign text = ps2_out_mod;
	
	// lcd controller
	lcd mylcd(clock, ~resetn, 1'b1, text, lcd_data, lcd_rw, lcd_en, lcd_rs, lcd_on, lcd_blon);
	
	// example for sending ps2 data to the first two seven segment displays
	Hexadecimal_To_Seven_Segment hex1(ps2_out[3:0], seg1);
	Hexadecimal_To_Seven_Segment hex2(ps2_out[7:4], seg2);
	
	// the other seven segment displays are currently set to 0
	Hexadecimal_To_Seven_Segment hex3(4'b0, seg3);
	Hexadecimal_To_Seven_Segment hex4(4'b0, seg4);
	Hexadecimal_To_Seven_Segment hex5(4'b0, seg5);
	Hexadecimal_To_Seven_Segment hex6(4'b0, seg6);
	Hexadecimal_To_Seven_Segment hex7(4'b0, seg7);
	Hexadecimal_To_Seven_Segment hex8(4'b0, seg8);
	
	// some LEDs that you could use for debugging if you wanted
	assign leds = 8'b00101011;
	
	
	
	wire[17:0] amp, temptempamp; // strength of audio signal 
	wire[8:0] tempamp;
	up_counter counter1(tempamp, clock); // 
	assign temptempamp = {9'b0,tempamp};
	assign amp = temptempamp;
		reg[17:0] previous;
	
	wire isup, isdown;
	assign isup = ((ps2_out[7:4] == 4'd7)&&(ps2_out[3:0] == 4'd5));
	assign isdown = ((ps2_out[7:4] == 4'd7)&&(ps2_out[3:0] == 4'd2));
	
	
	
	// VGA
	Reset_Delay			r0	(.iCLK(CLOCK_50),.oRESET(DLY_RST)	);
	VGA_Audio_PLL 		p1	(.areset(~DLY_RST),.inclk0(CLOCK_50),.c0(VGA_CTRL_CLK),.c1(AUD_CTRL_CLK),.c2(VGA_CLK)	);
	vga_controller vga_ins(.iRST_n(DLY_RST),
								 .iVGA_CLK(VGA_CLK),
								 .switch1(switch0),
								 .switch2(switch1),
								 .switch3(switch2),
								 .oBLANK_n(VGA_BLANK),
								 .oHS(VGA_HS),
								 .oVS(VGA_VS),
								 .b_data(VGA_B),
								 .g_data(VGA_G),
								 .r_data(VGA_R),
								 .amplitude(amp),
								 .color(8'd85));

	always @ (posedge clock) previous = amp;
	
endmodule

module up_counter    (
		out     ,  // Output of the counter // enable for counter
  clk     ,  // clock Input
  );
  //----------Output Ports--------------
      output [8:0] out;
  //------------Input Ports--------------
       input clk;
  //------------Internal Variables--------
      reg [8:0] out;
  //-------------Code Starts Here-------
  always @(posedge clk)
  if (out == 9'd480 ) begin
    out <= 9'b0 ;
  end else begin
    out <= out + 1;
  end
  
  
  endmodule 

  
 