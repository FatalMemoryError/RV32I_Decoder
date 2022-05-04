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
  wire R, I_L, I_C, JALR, S, B, LUI, AUIPC, JAL,
       R_out, I_L_out, I_C_out, JALR_out, S_out, B_out, LUI_out, AUIPC_out, JAL_out;
  wire BrEq, BrLT,
       BrEq_out, BrLT_out;
  wire [1:0] ALUOp, ALUOp_out;
  wire PCSel_temp, RegWEn_temp, ASel_temp, BSel_temp, MemRW_temp;
  wire [2:0] DataRSel_temp, ImmSel_temp, ImmSel_out;
  wire [1:0] DataWSel_temp, WBSel_temp;
  wire [3:0] ALUSel_temp;
  wire [3:0] funct_out;
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
            .funct(funct_out),
            .ALUOp(ALUOp_out),
            .ALUSel_temp(ALUSel_temp)
  );
  branch_comp branch_comp(
            .funct(funct[2:1]),
            .dataA(dataA),
            .dataB(dataB),
            .BrEq(BrEq),
            .BrLT(BrLT)
  );
  pipeline_reg pipeline_reg(
            .clk(clk),
            .BrEq_in(BrEq),
            .BrLT_in(BrLT),
            .funct_in(funct),
            .ALUOp_in(ALUOp),
            .ImmSel_in(ImmSel_temp),
            .R_in(R),
            .I_L_in(I_L),
            .I_C_in(I_C),
            .JALR_in(JALR),
            .S_in(S),
            .B_in(B),
            .LUI_in(LUI),
            .AUIPC_in(AUIPC),
            .JAL_in(JAL),
            .BrEq_out(BrEq_out),
            .BrLT_out(BrLT_out),
            .funct_out(funct_out),
            .ALUOp_out(ALUOp_out),
            .ImmSel_out(ImmSel_out),
            .R_out(R_out),
            .I_L_out(I_L_out),
            .I_C_out(I_C_out),
            .JALR_out(JALR_out),
            .S_out(S_out),
            .B_out(B_out),
            .LUI_out(LUI_out),
            .AUIPC_out(AUIPC_out),
            .JAL_out(JAL_out)  
  );
  sub_decoder sub_decoder(
            .funct(funct_out[2:0]),
            .R(R_out),
            .I_L(I_L_out),
            .I_C(I_C_out),
            .JALR(JALR_out),
            .S(S_out),
            .B(B_out),
            .LUI(LUI_out),
            .AUIPC(AUIPC_out),
            .JAL(JAL_out),
            .BrEq(BrEq_out),
            .BrLT(BrLT_out),
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
            .ImmSel_temp(ImmSel_out),
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