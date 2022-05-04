module pipeline_reg (
  input clk,
  input BrEq_in,
  input BrLT_in,
  input [3:0] funct_in,
  input [1:0] ALUOp_in,
  input [2:0] ImmSel_in,
  input R_in,
  input I_L_in,
  input I_C_in,
  input JALR_in,
  input S_in,
  input B_in,
  input LUI_in,
  input AUIPC_in,
  input JAL_in,
  output reg BrEq_out,
  output reg BrLT_out,
  output reg [3:0] funct_out,
  output reg [1:0] ALUOp_out,
  output reg [2:0] ImmSel_out,
  output reg R_out,
  output reg I_L_out,
  output reg I_C_out,
  output reg JALR_out,
  output reg S_out,
  output reg B_out,
  output reg LUI_out,
  output reg AUIPC_out,
  output reg JAL_out
);
  always @(posedge clk) begin
    BrEq_out<=BrEq_in; BrLT_out<=BrLT_in; funct_out<=funct_in; ALUOp_out<=ALUOp_in; ImmSel_out<=ImmSel_in;
    R_out<=R_in; I_L_out<=I_L_in; I_C_out<=I_C_in; JALR_out<=JALR_in; S_out<=S_in; B_out<=B_in;
    LUI_out<=LUI_in; AUIPC_out<=AUIPC_in; JAL_out<=JAL_in;
  end
endmodule