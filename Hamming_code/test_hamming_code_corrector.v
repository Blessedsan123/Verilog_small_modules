module test();
  reg [4:1] data_in;
  reg parity_type;
  wire [7:1] code_out;
  wire [4:1] data_out;
  wire error_d;
  wire [3:1]parity_out;
  
  hamming_top ham_top (
    .data_in(data_in),
    .parity_type(parity_type),
    .code_out(code_out),
    .data_out(data_out),
    .error_d(error_d),
    .parity_out(parity_out)
  );
  
  initial
    begin
      $dumpfile("wave.vcd");
      $dumpvars(0,test);
    end
  
  
  initial
    begin
      $monitor("data_in : %b || data_out : %b || code_out : %b || parity_out : %b || error_d : %b",data_in,data_out,code_out,parity_out,error_d);
      data_in = 4'b0101;
      parity_type = 0;
      #10;
      data_in = 4'b1101; 
      parity_type = 0;
      #10;
      data_in = 4'b0111;
      parity_type = 0;
      #10;
      data_in = 4'b0000;
      parity_type = 0;
      #10 $finish;
    end
endmodule
