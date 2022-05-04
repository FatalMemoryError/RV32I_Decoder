module out_buffer (
  input clk,
  input PCSel_temp, RegWEn_temp, ASel_temp, BSel_temp, MemRW_temp,
  input [2:0] DataRSel_temp, ImmSel_temp,
  input [1:0] DataWSel_temp, WBSel_temp,
  input [3:0] ALUSel_temp,
  output reg PCSel, RegWEn, ASel, BSel, MemRW,
  output reg [2:0] DataRSel, ImmSel,
  output reg [1:0] DataWSel, WBSel,
  output reg [3:0] ALUSel
  );
always @(posedge clk) begin
    PCSel<=PCSel_temp; RegWEn<=RegWEn_temp; ASel<=ASel_temp; BSel<=BSel_temp; MemRW<=MemRW_temp;
    DataRSel<=DataRSel_temp; ImmSel<=ImmSel_temp;
    DataWSel<=DataWSel_temp; WBSel<=WBSel_temp;
    ALUSel<=ALUSel_temp;
end

endmodule