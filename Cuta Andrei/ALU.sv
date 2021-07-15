//Unitate aritmetico logica
module ALU 
(
      input [31:0] a,	// intrare de date
      input [31:0] b,	// intrare de date
      input [5:0] alu_control, // permite selectarea operatiei
	  output zero,			   // flag
      output reg [31:0] result // iesire de date
);	
	  
always @(*) begin  
	
 case(alu_control)
      6'b100001: result = a + b; // addu
      6'b100011: result = a - b; // subu
	  6'b100100: result = a & b; // and
      6'b100101: result = a | b; // or
      6'b101011: if (a < b) 
		  			result = 32'd1;  //sltu
                 else result = 32'd0;
                  
	  6'b111101: if ( a - b != 0 ) 	 // BNE	  = daca a != b
		               result = 32'd0;
	             else result = 32'd1;
		         
      default: result = a + b; // adunare
 endcase   
 
end	   

assign zero = (result == 32'd0) ? 1'b1: 1'b0;	 // modelarea comportamentului flagului
 
endmodule
