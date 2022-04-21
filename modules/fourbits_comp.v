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
  assign Oeq=~(A[3]^B[3])&~(A[2]^B[2])&~(A[1]^B[1])&~(A[0]^B[0])&Ieq;
  assign Olt=~A[3]&B[3]|~(A[3]^B[3])&~A[2]&B[2]|~(A[3]^B[3])&~(A[2]^B[2])&~A[1]&B[1]|
             ~(A[3]^B[3])&~(A[2]^B[2])&~(A[1]^B[1])&~A[0]&B[0]|~(A[3]^B[3])&~(A[2]^B[2])&~(A[1]^B[1])&~(A[0]^B[0])&Ilt;
  assign Obt=A[3]&~B[3]|~(A[3]^B[3])&A[2]&~B[2]|~(A[3]^B[3])&~(A[2]^B[2])&A[1]&~B[1]|
             ~(A[3]^B[3])&~(A[2]^B[2])&~(A[1]^B[1])&A[0]&~B[0]|~(A[3]^B[3])&~(A[2]^B[2])&~(A[1]^B[1])&~(A[0]^B[0])&Ibt;
endmodule