module main_decoder (
        input [6:2] opcode,
        output [3:0] mini_Op, //表示指令类型的操作码，0000→R, 0001→I_L, 0010→I_C, 0011→JALR, 0100→S, 0101→B,
                              //                    0110→LUI, 0111→AUIPC, 1000→JAL
        output [2:0] ImmSel_temp, //立即数生成模式，按照R,I,S,B,U,J递增
        output [1:0] ALUOp //ALU控制码
  );
  assign mini_Op[0]=opcode[6]&opcode[5]&~opcode[2]|~opcode[5]&~opcode[4]|~opcode[5]&opcode[2]|~opcode[4]&~opcode[3]&opcode[2];
                    //~opcode[5]&~opcode[4]|~opcode[4]&~opcode[3]&opcode[2]|
                    //opcode[6]&opcode[5]&~opcode[2]|~opcode[5]&opcode[4]&opcode[2]               
  assign mini_Op[1]=~opcode[5]&opcode[4]|opcode[4]&opcode[2]|~opcode[3]&opcode[2];
                    //~opcode[5]&opcode[4]&~opcode[2]|~opcode[4]&~opcode[3]&opcode[2]|
                    //opcode[5]&opcode[4]&opcode[2]|~opcode[5]&opcode[4]&opcode[2]
  assign mini_Op[2]=opcode[6]&opcode[5]&~opcode[2]|~opcode[6]&opcode[5]&~opcode[4]|opcode[4]&opcode[2];
                    //~opcode[6]&opcode[5]&~opcode[4]|opcode[6]&opcode[5]&~opcode[2]|
                    //opcode[5]&opcode[4]&opcode[2]|~opcode[5]&opcode[4]&opcode[2]
  assign mini_Op[3]=opcode[3];
  assign ALUOp[0]=~mini_Op[3]&~mini_Op[2]&~mini_Op[0]|~mini_Op[2]&mini_Op[1]&~mini_Op[0];
                  //~mini_Op[3]&~mini_Op[2]&~mini_Op[1]&~mini_Op[0]|~mini_Op[2]&mini_Op[1]&~mini_Op[0]
  assign ALUOp[1]=mini_Op[1]&~mini_Op[0];
  assign ImmSel_temp[0]=mini_Op[2]&mini_Op[1];
  assign ImmSel_temp[1]=mini_Op[2]&mini_Op[1]|mini_Op[2]&~mini_Op[0];
                        //mini_Op[2]&mini_Op[1]|mini_Op[2]&~mini_Op[1]&~mini_Op[0]
  assign ImmSel_temp[2]=mini_Op[3];                        
  /*if(R) ALUOp=2'b01; //表示ALU模式与功能码有关
    else if(LUI) ALUOp=2'b10; //表示ALU模式与功能码无关，为直连B选择器
    else if(I_C) ALUOp=2'b11; //表示ALU模式与功能码有关，且为I型
    else ALUOp=2'b00; //表示ALU模式与功能码无关，为ADD
  if(S) ImmSel_temp=3'b001; //立即数生成模式为S型
    else if(B) ImmSel_temp=3'b010; //立即数生成模式为B型
    else if(LUI|AUIPC) ImmSel_temp=3'b011; //立即数生成模式为U型
    else if(JAL) ImmSel_temp=3'b100; //立即数生成模式为J型
    else ImmSel_temp=3'b000; //立即数生成模式为I型
  end*/
endmodule