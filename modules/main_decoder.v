module main_decoder (
        input [6:2] opcode,
        output R, //R型指令
        output I_L, //I型装载指令
        output I_C, //I型算术指令
        output JALR, //JALR指令
        output S, //S型指令
        output B, //B型指令
        output LUI, //LUI型指令
        output AUIPC, //AUIPC型
        output JAL, //JAL指令
        output [2:0] ImmSel_temp, //立即数生成模式，按照R,I,S,B,U,J递增
        output [1:0] ALUOp //ALU控制码
  );
  assign R=opcode[5]&opcode[4]&~opcode[2];
  assign I_L=~opcode[5]&~opcode[4];
  assign I_C=~opcode[5]&opcode[4]&~opcode[2];
  assign JALR=~opcode[4]&~opcode[3]&opcode[2];
  assign S=~opcode[6]&opcode[5]&~opcode[4];
  assign B=opcode[6]&opcode[5]&~opcode[2];
  assign LUI=opcode[5]&opcode[4]&opcode[2];
  assign AUIPC=~opcode[5]&opcode[2];
  assign JAL=opcode[3]&opcode[2];
  assign ALUOp[0]=R|I_C, 
         ALUOp[1]=LUI|I_C;
  assign ImmSel_temp[0]=S|LUI|AUIPC, 
         ImmSel_temp[1]=B|LUI|AUIPC, 
         ImmSel_temp[2]=JAL; 
  /*
  always @(*) begin
  if(R) ALUOp=2'b01; //表示ALU模式与功能码有关
    else if(LUI) ALUOp=2'b10; //表示ALU模式与功能码无关，为直连B选择器
    else if(I_C) ALUOp=2'b11; //表示ALU模式与功能码有关，且为I型
    else ALUOp=2'b00; //表示ALU模式与功能码无关，为ADD
  if(S) ImmSel_temp=3'b001; //立即数生成模式为S型
    else if(B) ImmSel_temp=3'b010; //立即数生成模式为B型
    else if(LUI|AUIPC) ImmSel_temp=3'b011; //立即数生成模式为U型
    else if(JAL) ImmSel_temp=3'b100; //立即数生成模式为J型
    else ImmSel_temp=3'b000; //立即数生成模式为I型
  end
  */
endmodule