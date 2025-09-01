// Code your testbench here
// or browse Examples
module test();
  reg [4:1] data_in;
  reg parity_type;
  wire [7:1] code_out;
  wire [4:1] data_out;
  wire error_d;
  wire [3:1]parity_out;
  wire [7:1] corrected_code;
  wire [2:0] error_pos;
  
  hamming_top ham_top (
    .data_in(data_in),
    .parity_type(parity_type),
    .code_out(code_out),
    .data_out(data_out),
    .error_d(error_d),
    .parity_out(parity_out),
    .corrected_code(corrected_code),
    .error_pos(error_pos)
  );
  
  initial
    begin
      $dumpfile("wave.vcd");
      $dumpvars(0,test);
    end
  
  
  initial
    begin
      $monitor("data_in : %b || data_out : %b || code_out : %b || corrected_code : %b || parity_out : %b || error_d : %b || error_pos : %b ",data_in,data_out,code_out,corrected_code,parity_out,error_d,error_pos);
      data_in = 4'b0101;
      parity_type = 0;
      #10;
      data_in = 4'b1101; 
      parity_type = 0;
      #10;
      data_in = 4'b0001;
      parity_type = 0;
      #10;
      data_in = 4'b0000;
      parity_type = 0;
      #10 $finish;
    end
endmodule
