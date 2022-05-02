//分支比较器
module branch_comp(
  input [2:1] funct, //功能码3的前两位
  input [31:0] dataA, //通用寄存器数据A
  input [31:0] dataB, //通用寄存器数据B 
  output reg BrEq, //分支比较结果，用来控制PCSel，AB相等为1
  output reg BrLT //分支比较结果，用来控制PCSel，A小于B为1
  );
  reg BrUn;//比较数据视为无符号或有符号，1表示无符号比较，0表示有符号比较
  wire BrEq_temp;
  wire BrLT_temp;
  wire [9:0] Oeq_temp;
  wire [9:0] Olt_temp;
  wire [9:0] Obt_temp;
  genvar i;
  generate
    for(i=0;i<8;i=i+1)
      begin:comp
        fourbits_comp fourbits_comp_i(
          .A(dataA[3+4*i:4*i]),
          .B(dataB[3+4*i:4*i]),
          .Ieq(1),
          .Ilt(0),
          .Ibt(0),
          .Oeq(Oeq_temp[i]),
          .Olt(Olt_temp[i]),
          .Obt(Obt_temp[i])
        );
      end
  endgenerate
  fourbits_comp fourbits_comp_8(
    .A(Obt_temp[3:0]),
    .B(Olt_temp[3:0]),
    .Ieq(1),
    .Ilt(0),
    .Ibt(0),
    .Oeq(Oeq_temp[8]),
    .Olt(Olt_temp[8]),
    .Obt(Obt_temp[8])
  );
  fourbits_comp fourbits_comp_9(
    .A(Obt_temp[7:4]),
    .B(Olt_temp[7:4]),
    .Ieq(1),
    .Ilt(0),
    .Ibt(0),
    .Oeq(Oeq_temp[9]),
    .Olt(Olt_temp[9]),
    .Obt(Obt_temp[9])
  );
  assign BrEq_temp=(~Obt_temp[9]&~Olt_temp[9]|Obt_temp[9]&Olt_temp[9])&(~Obt_temp[8]&~Olt_temp[8]|Obt_temp[8]&Olt_temp[8]);
  assign BrLT_temp=~Obt_temp[9]&Olt_temp[9]|(~Obt_temp[8]&~Olt_temp[8])&(~Obt_temp[8]&Olt_temp[8]);
  always @(*) begin
    if(funct[2]&funct[1])  BrUn=1;
    else BrUn=0;
    if(BrUn) begin //无符号数比较
      BrLT=BrLT_temp;
      BrEq=BrEq_temp;
    end else begin //有符号数比较
      if(dataA[31]==1&&dataB[31]==0) begin
        BrLT=1;
        BrEq=0;
      end
      else if(dataA[31]==0&&dataB[31]==1) begin
        BrLT=0;
        BrEq=0;
      end
      else begin
        BrLT=BrLT_temp;
        BrEq=BrEq_temp;
      end
    end
  end
endmodule 