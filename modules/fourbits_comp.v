//4位数值比较器
module fourbits_comp(
  input [3:0] A, 
  input [3:0] B,
  input Ieq,
  input Ilt,
  input Ibt,
  output Oeq,
  output Olt,
  output Obt
);
  wire xnor0, xnor1, xnor2, xnor3;
  wire lt3, lt2, lt1, lt0, bt3, bt2, bt1, bt0;
  assign xnor3=~(A[3]^B[3]),
         xnor2=~(A[2]^B[2]),
         xnor1=~(A[1]^B[1]),
         xnor0=~(A[0]^B[0]);
  assign lt3=~A[3]&B[3],
         lt2=~A[2]&B[2],
         lt1=~A[1]&B[1],
         lt0=~A[0]&B[0];
  assign bt3=A[3]&~B[3],
         bt2=A[2]&~B[2],
         bt1=A[1]&~B[1],
         bt0=A[0]&~B[0];
  assign Oeq=xnor3&xnor2&xnor1&xnor0&Ieq;
  assign Olt=lt3|xnor3&lt2|xnor3&xnor2&lt1|xnor3&xnor2&xnor1&lt0|xnor3&xnor2&xnor1&xnor0&Ilt;
  assign Obt=bt3|xnor3&bt2|xnor3&xnor2&bt1|xnor3&xnor2&xnor1&bt0|xnor3&xnor2&xnor1&xnor0&Ibt;
endmodule