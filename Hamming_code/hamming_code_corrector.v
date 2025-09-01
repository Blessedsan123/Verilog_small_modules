// Code your design here
module hamming_encoder(
  input [4:1] data_in,
  input parity_type,
  output [7:1] data_out,
  output [3:1] parity_out
);
  
  wire p1,p2,p3;
  
  assign p1 = data_in[1]^data_in[2]^data_in[3]^parity_type;
  assign p2 = data_in[1]^data_in[3]^data_in[4]^parity_type;
  assign p3 = data_in[2]^data_in[3]^data_in[4]^parity_type;
  
  assign data_out = {data_in[4],data_in[3],data_in[2],p3,data_in[1],p2,p1};
  
  assign parity_out = {p3,p2,p1};
  
endmodule

module hamming_decoder(
  input [7:1] code_in,
  input parity_type,
  output reg [7:1]corrected_code,
  output [4:1] data_out,
  output reg error_d,
  output [2:0] error_pos
);
  
  wire s1,s2,s3;
  
  assign s1 = code_in[1]^code_in[3]^code_in[5]^code_in[7]^parity_type;
  assign s2 = code_in[2]^code_in[3]^code_in[6]^code_in[7]^parity_type;
  assign s3 = code_in[4]^code_in[5]^code_in[6]^code_in[7]^parity_type;
  
  
  assign error_pos = {s3,s2,s1};
  
  
  always @(*)
    begin
      corrected_code = code_in;
      if(error_pos != 3'b000)
        begin
          corrected_code[error_pos] = ~corrected_code[error_pos];
          error_d = 1;
        end
      else
        error_d = 0;
    end
  
  assign data_out = {corrected_code[7],corrected_code[6],corrected_code[5],corrected_code[3]};
endmodule


module hamming_top(
  input [4:1] data_in,
  input parity_type,
  output [7:1] code_out,
  output [4:1] data_out,
  output error_d,
  output [7:1] corrected_code,
  output [2:0] error_pos,
  output [3:1] parity_out
);
  
  hamming_encoder ham_enc(.data_in(data_in),
                          .parity_type(parity_type),
                          .data_out(code_out),
                          .parity_out(parity_out)
                         );
  
  hamming_decoder ham_dec(.code_in(code_out),
                          .parity_type(parity_type),
                          .corrected_code(corrected_code),
                          .data_out(data_out),
                          .error_d(error_d),
                          .error_pos(error_pos)
                         );
  
endmodule
