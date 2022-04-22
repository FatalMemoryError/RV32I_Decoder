//超前借位单元
module CLB(B0,B1,B2,B3,B4,P1,P2,P3,P4,G1,G2,G3,G4);
	input B0,P1,P2,P3,P4,G1,G2,G3,G4;
	output B1,B2,B3,B4;
	//直接采取超前借位方式，完成相应的借位的计算
	assign   
  B1 = G1 | (P1 & B0),
	B2 = G2 | (P2 & G1) | (P2 & P1 & B0),
  B3 = G3 | (P3 & G2) | (P3 & P2 & G1) | (P3 & P2 & P1 & B0),
	B4 = G4 | (P4 & G3) | (P4 & P3 & G2) | (P4 & P3 & P2 & G1) |(P4 & P3 & P2 & P1 & B0);
endmodule