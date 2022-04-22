module full_sub_4bits (
  input [3:0] X,
  input [3:0] Y,
  input B0, 
  output B4,
  output Gm,
  output Pm,
  output [3:0] D
);
  wire P1,P2,P3,P4,G1,G2,G3,G4;
  wire B1,B2,B3;
  full_sub full_sub_0(
    .Xi(X[0]),
    .Yi(Y[0]),
    .Bi(B0),
    .Di(D[0]),
    .Bo()
  );
  full_sub full_sub_1(
    .Xi(X[1]),
    .Yi(Y[1]),
    .Bi(B1),
    .Di(D[1]),
    .Bo()
  );
  full_sub full_sub_2(
    .Xi(X[2]),
    .Yi(Y[2]),
    .Bi(B2),
    .Di(D[2]),
    .Bo()
  );
  full_sub full_sub_3(
    .Xi(X[3]),
    .Yi(Y[3]),
    .Bi(B3),
    .Di(D[3]),
    .Bo()
  );
  CLB CLB(
    .B0(B0),
    .B1(B1),
    .B2(B2),
    .B3(B3),
    .B4(B4),
    .P1(P1),
    .P2(P2),
    .P3(P3),
    .P4(P4),
    .G1(G1),
    .G2(G2),
    .G3(G3),
    .G4(G4)
  );
  assign P1=~X[0]|Y[0],
         P2=~X[1]|Y[1],
         P3=~X[2]|Y[2],
         P4=~X[3]|Y[3];
  assign G1=~X[0]&Y[0],
         G2=~X[1]&Y[1],
         G3=~X[2]&Y[2],
         G4=~X[3]&Y[3];
  assign Pm=P1&P2&P3&P4,
         Gm=G4|P4&G3|P4&P3&G2|P4&P3&P2&G1;         
endmodule