/*

	Barramento de controle 16 bits:
	
	
		0: EscCondCP
		1: EscCP
		2: ULA_A
	 3-4: ULA_B
		5: EscIR
    6-7: FonteCP [1:0]
		8: EscReg
		9: Reservado
	  10: Mul
  11-14: ULA_OP
     15: reservado
  
		
*/

module Ctrl(clk, inst, controle_a, controle_b, controle_c, regs_a, regs_b, regs_c);
input clk;
input [15:0] inst;
output reg [15:0]controle_a ;
output reg [11:0]regs_a  ;
output reg [15:0]controle_b ;
output reg [11:0]regs_b  ;
output reg [15:0]controle_c ;
output reg [11:0]regs_c  ;

always @(posedge clk) begin
	
	controle_c [15:0] = controle_b [15:0];
	controle_b [15:0] = controle_a [15:0];

	regs_c [11:0] = regs_b [11:0];
	regs_b [11:0] = regs_a [11:0];
	
	controle_a [14:11] = inst [15:12];	
	regs_a [11:0] = inst [11:0];
	
end


always @(inst)
begin

	controle_a [14:11] = inst [15:12];	
	regs_a [11:0] = inst [11:0];
	
	
	if (inst[15:12] == 4'd0 || inst[15:12] == 4'd1 || inst[15:12] == 4'd3 || inst[15:12] == 4'd4 || inst[15:12] == 4'd5 || inst[15:12] == 4'd13 || inst[15:12] == 4'd14 || inst[15:12] == 4'd15 )
		begin
		

	controle_a[0] = 0;			//EscCondCP
	controle_a[1] = 1;			//EscCP
	controle_a[2] = 1;			//ULA_A
	controle_a[4:3] = 2'b00;	//ULA_B
	controle_a[5] = 0;			//EscIR
	controle_a[7:6] = 2'b00;	//FonteCP
	controle_a[8] = 1;			//EscReg
	controle_a[10] = 0;			//Mul				
		end
		
	if (inst[15:12] == 4'd2 || inst[15:12] == 4'd6 || inst[15:12] == 4'd7 || inst[15:12] == 4'd8 || inst[15:12] == 4'd9 || inst[15:12] == 4'd10)	
		begin
				
	controle_a[0] = 0;			//EscCondCP
	controle_a[1] = 1;			//EscCP
	controle_a[2] = 1;			//ULA_A
	controle_a[4:3] = 2'b10;	//ULA_B
	controle_a[5] = 0;			//EscIR
	controle_a[7:6] = 2'b00;	//FonteCP
	controle_a[8] = 1;			//EscReg
	controle_a[10] = 0;			//Mul							
	
				
		end
		
	if (inst[15:12] == 4'd11)	//jump
		begin
		
	controle_a[0] = 0;			//EscCondCP
	controle_a[1] = 1;			//EscCP
	controle_a[2] = 1;			//ULA_A
	controle_a[4:3] = 2'b10;	//ULA_B
	controle_a[5] = 0;			//EscIR
	controle_a[7:6] = 2'b10;	//FonteCP
	controle_a[8] = 0;			//EscReg
	controle_a[10] = 0;			//Mul		

		end
		
	if (inst[15:12] == 4'd12)	
		begin
		
	controle_a[0] = 1;			//EscCondCP
	controle_a[1] = 1;			//EscCP
	controle_a[2] = 0;			//ULA_A
	controle_a[4:3] = 2'b00;	//ULA_B
	controle_a[5] = 0;			//EscIR
	controle_a[7:6] = 2'b01;	//FonteCP
	controle_a[8] = 0;			//EscReg
	controle_a[10] = 0;			//Mul		
		
			
		end
	

		if (inst[15:12] == 4'd15) begin
		
		
	controle_a[0] = 0;			//EscCondCP
	controle_a[1] = 0;			//EscCP
	controle_a[2] = 1;			//ULA_A
	controle_a[4:3] = 2'b00;	//ULA_B
	controle_a[5] = 0;			//EscIR
	controle_a[7:6] = 2'b00;	//FonteCP
	controle_a[8] = 1;			//EscReg
	controle_a[10] = 1;			//Mul		

		end
		
end

endmodule
 