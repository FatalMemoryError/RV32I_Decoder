//分支比较器
module branch_comp(
  input [2:1] funct, //功能码3的前两位
  input [31:0] dataA, //通用寄存器数据A
  input [31:0] dataB, //通用寄存器数据B 
  input B, //主比较器结果，作为使能信号，指令类型若为B型指令则为1
  output reg BrEq, //分支比较结果，用来控制PCSel，AB相等为1
  output reg BrLT, //分支比较结果，用来控制PCSel，A小于B为1
  output reg work //决定分支比较器工作状态
  );
  reg BrUn;//比较数据视为无符号或有符号，1表示无符号比较，0表示有符号比较
  always @(*) begin
    if(funct[2]&funct[1])  BrUn=1;
    else BrUn=0;
    if(B&BrUn) begin //无符号数比较
      BrLT=(dataA<dataB) ? 1'b1 : 1'b0;
      BrEq=(dataA==dataB) ? 1'b1 : 1'b0; 
      work=1;
    end else if(B&~BrUn) begin //有符号数比较
      if(dataA[31]==1&&dataB[31]==0) begin
        BrLT=1;
        BrEq=0;
        work=1;
      end
      else if(dataA[31]==0&&dataB[31]==1) begin
        BrLT=0;
        BrEq=0;
        work=1;
      end
      else begin
        BrLT=(dataA[30:0]<dataB[30:0]) ? 1'b1 : 1'b0;
        BrEq=(dataA[30:0]==dataB[30:0]) ? 1'b1 : 1'b0;
        work=1;
      end
    end else begin
      BrLT=1;
      BrEq=1;
      work=0;
    end
  end
endmodule 