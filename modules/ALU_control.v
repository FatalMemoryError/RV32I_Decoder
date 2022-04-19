module ALU_control (
  input [3:0] funct,
  input [1:0] ALUOp,
  output [3:0] ALUSel_temp
  );
    assign ALUSel_temp[3]=(ALUOp[1]&~ALUOp[0])|(ALUOp[0]&funct[2]&funct[1]);
    assign ALUSel_temp[2]=ALUOp[0]&((funct[2]&~funct[1])|(~funct[2]&funct[1]&funct[0]));
    assign ALUSel_temp[1]=(ALUOp[1]&~ALUOp[0])|(ALUOp[0]&((~funct[2]&funct[1]&~funct[0])|(~funct[1]&funct[0])));
    assign ALUSel_temp[0]=(ALUOp[1]&ALUOp[0]&~funct[2]&~funct[1]&~funct[0]) ? 1'b0 : ALUOp[0]&(funct[3]&~funct[2]&~funct[1]&~funct[0]|(funct[3]&funct[2]&~funct[1]&funct[0])|(~funct[2]&funct[1]&~funct[0])|(funct[2]&~funct[1]&~funct[0])|(funct[2]&funct[1]&funct[0]));
endmodule