//全减器
module full_sub(
	input Xi,
	input Yi,
	input Bi,
	output Di,
	output Bo
);
assign Di=Xi^Yi^Bi;
assign Bo=Bi&(~Xi|Yi)|~Xi&Yi;
endmodule