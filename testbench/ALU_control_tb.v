`timescale 1ps/1ps
module ALU_control_tb;
  reg [3:0] funct;
  reg [1:0] ALUOp;
  wire [3:0] ALUSel;
  ALU_control ALU_control(
             .funct(funct),
             .ALUOp(ALUOp),
             .ALUSel(ALUSel)
  );
  initial begin
        ALUOp<=2'b10; funct<=4'b1001;
    #10 ALUOp<=2'b00; funct<=4'b1011;
    #10 ALUOp<=2'b01; funct<=4'b0000;
    #10 ALUOp<=2'b01; funct<=4'b1000;
    #10 ALUOp<=2'b01; funct<=4'b1001;
    #10 ALUOp<=2'b01; funct<=4'b0010;
    #10 ALUOp<=2'b01; funct<=4'b0011;
    #10 ALUOp<=2'b01; funct<=4'b1100;
    #10 ALUOp<=2'b01; funct<=4'b0101;
    #10 ALUOp<=2'b01; funct<=4'b1101;
    #10 ALUOp<=2'b01; funct<=4'b0110;
    #10 $stop;
  end
endmodule