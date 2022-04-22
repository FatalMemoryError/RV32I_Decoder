module fast_sub_32 (
  input [31:0] A,
  input [31:0] B,
  output [31:0] result,
  output B32
  );
  	wire Px1,Gx1,Px2,Gx2;
    wire C16;
  CLB_16 CLB1(
    .A(A[15:0]),
		.B(B[15:0]),
		.B0(0),
		.Px(Px1),
		.Gx(Gx1),		
    .D(result[15:0])
	);
  CLB_16 CLB2(
    .A(A[31:16]),
		.B(B[31:16]),
		.B0(B16),
		.Px(Px2),
		.Gx(Gx2),		
    .D(result[31:16])
	);
  assign B16=Gx1|(Px1&&0),
         B32=Gx2|(Px2&&B16);
endmodule