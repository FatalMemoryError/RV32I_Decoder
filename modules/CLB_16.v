module CLB_16 (
  input [15:0] A,
  input [15:0] B,
  input B0,
  output Gx,
  output Px,
  output [15:0] D
  );
  wire B4,B8,B12;
  wire Pm1,Gm1,Pm2,Gm2,Pm3,Gm3,Pm4,Gm4;
  full_sub_4bits fs4b_0(
    .X(A[3:0]),
    .Y(B[3:0]),
    .B0(B0),
    .B4(),
    .Gm(Gm1),
    .Pm(Pm1),
    .D(D[3:0])
  );
  full_sub_4bits fs4b_1(
    .X(A[7:4]),
    .Y(B[7:4]),
    .B0(B4),
    .B4(),
    .Gm(Gm2),
    .Pm(Pm2),
    .D(D[7:4])
  );
  full_sub_4bits fs4b_2(
    .X(A[11:8]),
    .Y(B[11:8]),
    .B0(B8),
    .B4(),
    .Gm(Gm3),
    .Pm(Pm3),
    .D(D[11:8])
  );
  full_sub_4bits fs4b_3(
    .X(A[15:12]),
    .Y(B[15:12]),
    .B0(B12),
    .B4(),
    .Gm(Gm4),
    .Pm(Pm4),
    .D(D[15:12])
  );
  assign B4 = Gm1 | (Pm1 & B0),
         B8 = Gm2 | (Pm2 & Gm1) | (Pm2 & Pm1 & B0),
			   B12 = Gm3 | (Pm3 & Gm2) | (Pm3 & Pm2 & Gm1) | (Pm3 & Pm2 & Pm1 & B0);
  assign Px = Pm1 & Pm2 & Pm3 & Pm4,
	       Gx = Gm4 | (Pm4 & Gm3) | (Pm4 & Pm3 & Gm2) | (Pm4 & Pm3 & Pm2 & Gm1);
endmodule