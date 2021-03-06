//Edistance
module DE1_SoC (image, test, distance);
	input logic [783:0][7:0] image;
	input logic [783:0][7:0] test;
	output logic [31:0] distance; //26 bits

	logic [783:0][15:0] pdiff;
  
  // compute each component
  genvar gi;
  generate
    for (gi = 0; gi < 784; gi = gi + 1) begin : each
		getDiff pd(.diff(pdiff[gi]), .pixel1(image[gi]), .pixel2(test[gi]));
    end
  endgenerate
  
  // add up
  addDiff td(.sum(distance), .pdiff);
endmodule 

module DE1_SoC_testbench();
  logic [783:0][7:0] image; 
  logic [783:0][7:0] test;
  logic [31:0] distance;

  DE1_SoC dut (.image, .test, .distance);

  integer i;
  initial begin
    for(i = 0; i < 784; i++) begin
      image[i] = 8'b00000000; 
	   test[i] = 8'b10001001;
    end
    #10;
  end
endmodule 