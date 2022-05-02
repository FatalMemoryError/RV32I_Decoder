module sub_decoder (
      input [2:0] funct,
      input [3:0] mini_Op,
      input BrEq, //分支比较器设置不工作或异常时，BrEq与BrLT均为1
      input BrLT, //因此可通过判断BrEq&BrLT等于0决定对PCSel_temp进行输入
      output reg PCSel_temp, //PC写入数据选择器，1代表选取ALU值，0代表选取PC+4值
      output reg RegWEn_temp, //32位通用寄存器写使能
      output reg ASel_temp, //ALU输入数据选择器A，1代表选取PC值，0代表选取通用寄存器dataA
      output reg BSel_temp, //ALU输入数据选择器B，1代表选取Imm值，0代表选取通用寄存器dataB
      output reg [1:0] DataWSel_temp, //内存写入数据生成器，共3种模式
      output reg MemRW_temp, //内存读写模式，0代表读，1代表写
      output reg [2:0] DataRSel_temp, //内存读取数据生成器，共5种模式
      output reg [1:0] WBSel_temp //写回通用寄存器数据选择器，00代表选取内存数据，01代表选取ALU值，02代表选取PC+4值
);
  always @(*) begin
    case (mini_Op)
    4'b0011: PCSel_temp=1'b1;
    4'b1000: PCSel_temp=1'b1;
    4'b0101: begin
        case ({funct[2],funct[0]})
          2'b00: PCSel_temp=BrEq;
          2'b01: PCSel_temp=~BrEq;
          2'b10: PCSel_temp=BrLT;
          2'b11: PCSel_temp=~BrLT;
          default: PCSel_temp=1'b0;
        endcase
      end
    default: PCSel_temp=0;
    endcase
    RegWEn_temp=mini_Op[2]&~mini_Op[1];
    ASel_temp=~mini_Op[3]&mini_Op[2]&mini_Op[0]|mini_Op[3]&~mini_Op[2];
    BSel_temp=mini_Op[3]|mini_Op[2]|mini_Op[1]|mini_Op[0];
    if(mini_Op[2]&~mini_Op[1]&~mini_Op[0]) begin
      if(~funct[1]&~funct[0]) DataWSel_temp=2'b01; //内存写入数据生成器模式为字节
        else if(funct[0]) DataWSel_temp=2'b11; //内存写入数据生成器模式为半字
        else DataWSel_temp=2'b00; //内存写入数据生成器模式为字（相当于直通）
    end else DataWSel_temp=2'b00; //内存写入数据生成器模式为字（相当于直通）
    MemRW_temp=mini_Op[2]&~mini_Op[1]&~mini_Op[0];
    if(~mini_Op[2]&~mini_Op[1]&mini_Op[0]) begin
      if(~funct[2]&~funct[1]&~funct[0]) DataRSel_temp=3'b001; //内存读取数据生成器模式为字节
        else if(~funct[2]&funct[0]) DataRSel_temp=3'b010; //内存读取数据生成器模式为半字
        else if(funct[2]&~funct[0]) DataRSel_temp=3'b011; //内存读取数据生成器模式为无符号字节
        else if(funct[2]&funct[0]) DataRSel_temp=3'b100; //内存读取数据生成器模式为无符号半字
        else DataRSel_temp=3'b000; //内存读取数据生成器模式为字（相当于直通）
    end else DataRSel_temp=3'b000; //内存读取数据生成器模式为字（相当于直通）
    if(~mini_Op[2]&~mini_Op[1]&mini_Op[0]) WBSel_temp=2'b00;
      else if(~mini_Op[2]&mini_Op[1]&mini_Op[0]|mini_Op[3]) WBSel_temp=2'b10;
      else WBSel_temp=2'b01;
  end
    /*
    if(JALR|JAL) PCSel_temp=1;
      else if(B&work) begin
        if(~funct[2]&~funct[0]) PCSel_temp=BrEq;
        else if(~funct[2]&funct[0]) PCSel_temp=~BrEq;
        else if(funct[2]&~funct[0]) PCSel_temp=BrLT;
        else if(funct[2]&funct[0]) PCSel_temp=~BrLT;
        else PCSel_temp=0;
      end else PCSel_temp=0;
    RegWEn_temp=(S|B==1) ? 1'b0 : 1'b1;
    ASel_temp=(B|AUIPC|JAL==1) ? 1'b1 : 1'b0;
    BSel_temp=~R;
    if(S) begin
      if(~funct[1]&~funct[0]) DataWSel_temp=2'b01; //内存写入数据生成器模式为字节
        else if(funct[0]) DataWSel_temp=2'b11; //内存写入数据生成器模式为半字
        else DataWSel_temp=2'b00; //内存写入数据生成器模式为字（相当于直通）
    end else DataWSel_temp=2'b00; //内存写入数据生成器模式为字（相当于直通）
    MemRW_temp=S;
    if(I_L) begin
      if(~funct[2]&~funct[1]&~funct[0]) DataRSel_temp=3'b001; //内存读取数据生成器模式为字节
        else if(~funct[2]&funct[0]) DataRSel_temp=3'b010; //内存读取数据生成器模式为半字
        else if(funct[2]&~funct[0]) DataRSel_temp=3'b011; //内存读取数据生成器模式为无符号字节
        else if(funct[2]&funct[0]) DataRSel_temp=3'b100; //内存读取数据生成器模式为无符号半字
        else DataRSel_temp=3'b000; //内存读取数据生成器模式为字（相当于直通）
    end else DataRSel_temp=3'b000; //内存读取数据生成器模式为字（相当于直通）
    if(I_L) WBSel_temp=2'b00;
      else if(JALR|JAL) WBSel_temp=2'b10;
      else WBSel_temp=2'b01;
  end
  */
endmodule