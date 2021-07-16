//permite selectarea operatiei care va fi executata de ALU
module ALU_control
(	
	input [5:0] funct, // intrare de date
	input [1:0] ALUop, // intrare de selectie
	output reg [5:0] dout // iesire de date
);

always@( funct, ALUop ) begin
	
	if(	ALUop == 2'b11 ) begin		 //aritmetic
		dout <= funct;				 // iesirea va primi datele de la intrare
	end	
	
	else if( ALUop == 2'b01 ) begin	 //BEQ
		dout <= 6'b100011; //subu	 iesirea va primi codul specific scaderii indiferent de datele de la intrarea de date
	end
	
	else if( ALUop == 2'b10 ) begin	 //BNE
		dout <= 6'b111101; //subu 	 iesirea va primi codul specific instructiunii bne indiferent de datele de la intrarea de date
	end
	
	else if( ALUop == 2'b00) begin	 //load/store
		dout <= 6'b100001; //addu  	 iesirea va primi codul specific adunarii indiferent de datele de la intrarea de date
	end	   
	
end
	
endmodule
