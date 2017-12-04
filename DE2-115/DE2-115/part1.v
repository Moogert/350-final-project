module part1 (CLOCK_50, CLOCK2_50, KEY, I2C_SCLK, I2C_SDAT, AUD_XCK, 
		        AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK, AUD_ADCDAT, AUD_DACDAT);

				  input CLOCK_50, CLOCK2_50;
	input KEY;
	// I2C Audio/Video config interface
	output I2C_SCLK;
	inout I2C_SDAT;
	// Audio CODEC
	output AUD_XCK;
	input AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK;
	input AUD_ADCDAT;
	output AUD_DACDAT;
	
	
	
	wire sink_VALID, wink_EOP, source_VALID; 
	assign source_VALID = go; // valid if we're writing 
	assign sink_VALID = read_ready; 
	assign sink_EOP = 1'b0; // no data, end of frame
	wire [1:0] sink_ERROR; 
	assign sink_ERROR = 2'b0; // we're assuming we have no errors ever 
	wire [23:0] fft_real_wire, fft_imag_wire, fft_exp_wire; 
	reg [23:0] fft_real, fft_imag, fft_exp; 
	
	
	// Local wires.
	wire read_ready, write_ready, read, write;
	wire [23:0] readdata_left, readdata_right;
	wire [23:0] writedata_left, writedata_right;
	reg [5:0] source_EXP; 
	wire reset = ~KEY;
	reg source_ERROR; 
	wire source_READY; 
	assign source_READY = 1'b1; // we're always ready to read data from FFT.	
	
	wire go;
	 assign go = write_ready; 
	/////////////////////////////////
	// Your code goes here 
	/////////////////////////////////
	
	
	// read changes samples, deletes the old one 
	assign writedata_left = go ? readdata_left : 24'd0; // z or 0? 
	assign writedata_right = go ? readdata_right : 24'd0; // ^^ 
	assign read = read_ready; // if we can take more data, we should get more data  
	assign write = write_ready; // derp 
	reg [23:0] left_data; 
	reg [23:0] right_data; 
	
	always @(posedge AUD_XCK) begin // DEBUGMARK - *this may be the wrong clock*
		left_data <= readdata_left; 
		right_data <= readdata_right; 
		fft_real <= fft_real_wire; 
		fft_imag <= fft_imag_wire; 
		fft_exp <= fft_exp_wire; // store output values into a register @ every clock cycle 
	end
	
/////////////////////////////////////////////////////////////////////////////////
// Audio CODEC interface. 
//
// The interface consists of the following wires:
// read_ready, write_ready - CODEC ready for read/write operation 
// readdata_left, readdata_right - left and right channel data from the CODEC
// read - send data from the CODEC (both channels)
// writedata_left, writedata_right - left and right channel data to the CODEC
// write - send data to the CODEC (both channels)
// AUD_* - should connect to top-level entity I/O of the same name.
//         These signals go directly to the Audio CODEC
// I2C_* - should connect to top-level entity I/O of the same name.
//         These signals go directly to the Audio/Video Config module
/////////////////////////////////////////////////////////////////////////////////
	clock_generator my_clock_gen(
		// inputs
		CLOCK2_50,
		reset,

		// outputs
		AUD_XCK
	);

	audio_and_video_config cfg(
		// Inputs
		CLOCK_50,
		reset,

		// Bidirectionals
		I2C_SDAT,
		I2C_SCLK
	);

	audio_codec codec(
		// Inputs
		CLOCK_50,
		reset,

		read,	write,
		writedata_left, writedata_right,

		AUD_ADCDAT,

		// Bidirectionals
		AUD_BCLK, // assuming this to be the clock source we want 
		AUD_ADCLRCK,
		AUD_DACLRCK,

		// Outputs
		read_ready, write_ready,
		readdata_left, readdata_right,
		AUD_DACDAT
	);
	
/*


* which clock? 
// big guns 
	fft u0 (
		.clk          (AUD_BCLK),          //    clk.clk
		.reset_n      (reset),      //    rst.reset_n
		.sink_valid   (<connected-to-sink_valid>),   //   sink.sink_valid
		.sink_ready   (<connected-to-sink_ready>),   //       .sink_ready
		.sink_error   (<connected-to-sink_error>),   //       .sink_error
		.sink_sop     (<connected-to-sink_sop>),     //       .sink_sop
		.sink_eop     (<connected-to-sink_eop>),     //       .sink_eop
		.sink_real    (<connected-to-sink_real>),    //       .sink_real
		.sink_imag    (24'd0),    //       .sink_imag
		.inverse      (1'b0),      //       .inverse
		.source_valid (source_VALID), // source.source_valid
		.source_ready (<connected-to-source_ready>), //       .source_ready
		.source_error (<connected-to-source_error>), //       .source_error
		.source_sop   (<connected-to-source_sop>),   //       .source_sop
		.source_eop   (<connected-to-source_eop>),   //       .source_eop
		.source_real  (fft_real_wire),  //       .source_real
		.source_imag  (fft_imag_wire),  //       .source_imag
		.source_exp   (fft_exp_wire)    //       .source_exp
	);


*/
endmodule


