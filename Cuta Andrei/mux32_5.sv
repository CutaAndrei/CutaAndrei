//Mux cu 32 de intrari a 32 de biti fiecare
//Selectie pe 5 biti si iesire pe 32 de biti
module mux32_5
(	
	input  [4:0]  sel ,			 // intrarea de selectie este pe 5 biti pentru a putea acoperi orice numar in intervalul 0:31
	input  [31:0] in [0:31] ,	 // intrarile de date
	output [31:0] out			 // iesirea de date
);	  
reg [31:0] temp;
	always@(*)		  // orice modificare a intrarilor va executa blocul always
		case(sel)
			0 : temp = in[0];  // daca la intrarea de selectie avem 00000 la iesirea out vom avea intrarea de la pozitia 0 (in[0])
			1 :	temp = in[1];  // etc
			2 : temp = in[2];
			3 :	temp = in[3];
			4 : temp = in[4];
			5 :	temp = in[5];
			6 : temp = in[6];
			7 :	temp = in[7];
			8 : temp = in[8];
			9 :	temp = in[9];
			
		   10 : temp = in[10];
		   11 : temp = in[11];
		   12 : temp = in[12];
		   13 : temp = in[13];
		   14 : temp = in[14];
		   15 : temp = in[15];
		   16 : temp = in[16];
		   17 : temp = in[17];
		   18 : temp = in[18];
		   19 : temp = in[19];
			
		   20 : temp = in[20];
		   21 : temp = in[21];
		   22 : temp = in[22];
		   23 : temp = in[23];
		   24 : temp = in[24];
		   25 : temp = in[25];
		   26 : temp = in[26];
		   27 : temp = in[27];
		   28 : temp = in[28];
		   29 : temp = in[29]; 
			
		   30 : temp = in[30];
		   31 : temp = in[31]; 
		   default temp = {32{1'bx}};  
	   endcase
	assign out = temp;		
endmodule
