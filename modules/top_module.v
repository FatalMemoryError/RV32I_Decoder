module top_module (
  input clk,
  input [3:0] funct,
  input [6:2] opcode,
  input [31:0] dataA,
  input [31:0] dataB,
  output PCSel,
  output [2:0] ImmSel,
  output RegWEn,
  output ASel,
  output BSel,
  output [3:0] ALUSel,
  output [1:0] DataWSel,
  output MemRW,
  output [2:0] DataRSel,
  output [1:0] WBSel
  );
  wire R, I_L, I_C, JALR, S, B, LUI, AUIPC, JAL;
  wire BrEq, BrLT, work;
  wire [1:0] ALUOp;
  wire PCSel_temp, RegWEn_temp, ASel_temp, BSel_temp, MemRW_temp;
  wire [2:0] DataRSel_temp, ImmSel_temp;
  wire [1:0] DataWSel_temp, WBSel_temp;
  wire [3:0] ALUSel_temp;
  main_decoder main_decoder(
            .opcode(opcode),
            .R(R),
            .I_L(I_L),
            .I_C(I_C),
            .JALR(JALR),
            .S(S),
            .B(B),
            .LUI(LUI),
            .AUIPC(AUIPC),
            .JAL(JAL),
            .ImmSel_temp(ImmSel_temp),
            .ALUOp(ALUOp)
  );
  ALU_control ALU_control(
            .funct(funct),
            .ALUOp(ALUOp),
            .ALUSel_temp(ALUSel_temp)
  );
  branch_comp branch_comp(
            .funct(funct[2:1]),
            .dataA(dataA),
            .dataB(dataB),
            .B(B),
            .BrEq(BrEq),
            .BrLT(BrLT),
            .work(work)
  );
  sub_decoder sub_decoder(
            .funct(funct[2:0]),
            .R(R),
            .I_L(I_L),
            .I_C(I_C),
            .JALR(JALR),
            .S(S),
            .B(B),
            .LUI(LUI),
            .AUIPC(AUIPC),
            .JAL(JAL),
            .work(work),
            .BrEq(BrEq),
            .BrLT(BrLT),
            .PCSel_temp(PCSel_temp),
            .RegWEn_temp(RegWEn_temp),
            .ASel_temp(ASel_temp),
            .BSel_temp(BSel_temp),
            .DataWSel_temp(DataWSel_temp),
            .MemRW_temp(MemRW_temp),
            .DataRSel_temp(DataRSel_temp),
            .WBSel_temp(WBSel_temp)         
  );
  out_buffer out_buffer(
            .clk(clk),
            .PCSel_temp(PCSel_temp),
            .RegWEn_temp(RegWEn_temp),
            .ASel_temp(ASel_temp),
            .BSel_temp(BSel_temp),
            .MemRW_temp(MemRW_temp),
            .DataRSel_temp(DataRSel_temp),
            .ImmSel_temp(ImmSel_temp),
            .DataWSel_temp(DataWSel_temp),
            .WBSel_temp(WBSel_temp),
            .ALUSel_temp(ALUSel_temp),
            .PCSel(PCSel),
            .RegWEn(RegWEn),
            .ASel(ASel),
            .BSel(BSel),
            .MemRW(MemRW),
            .DataRSel(DataRSel),
            .ImmSel(ImmSel),
            .DataWSel(DataWSel),            
            .WBSel(WBSel),
            .ALUSel(ALUSel)       
  );
endmodule