//Decodificator, va primi la intrare un numar in binar pe 5 biti iar la iesire va pune 1 pe iesirea cu numarul de la intrare
// ex : in 00101 ( = 5 ) => { 5{0} , 1 , 26{0} } (numaratoarea incepe de la 0) 
module dcd_en
(
	input 			  RegWrite ,	  // enable
	input 	   [4:0]  WriteRegister,  // intrare de date <=> numarului in binar
	output reg [31:0] EnableRegister  // iesire de date
); 
localparam I = 1'b0;			// parametru egal cu 0
localparam A = 1'b1;			// parametru egal cu 1

always@( RegWrite , WriteRegister )		   // always va fi executat la schimbarile semnalelor RegWrite si WriteRegister
	if(RegWrite)						   // verificam daca avem enable
		case(WriteRegister)				   // case
			//0 : EnableRegister = { A , {31{I}} };	          // registrul 0 a fost fortat la valoarea 0 permanent, deci nu va avea nevoie de enable
			1 :	EnableRegister = { I , A , {30{I}} };		  // concatenam bitul activ cu restul bitilor inactivi
			2 : EnableRegister = { { 2{I}} , A , {29{I}} };
			3 :	EnableRegister = { { 3{I}} , A , {28{I}} };
			4 : EnableRegister = { { 4{I}} , A , {27{I}} };
			5 : EnableRegister = { { 5{I}} , A , {26{I}} };
			6 : EnableRegister = { { 6{I}} , A , {25{I}} };
			7 :	EnableRegister = { { 7{I}} , A , {24{I}} };
			8 : EnableRegister = { { 8{I}} , A , {23{I}} };
			9 :	EnableRegister = { { 9{I}} , A , {22{I}} };
			
		   10 : EnableRegister = { {10{I}} , A , {21{I}} };
		   11 : EnableRegister = { {11{I}} , A , {20{I}} };
		   12 : EnableRegister = { {12{I}} , A , {19{I}} };
		   13 : EnableRegister = { {13{I}} , A , {18{I}} };
		   14 : EnableRegister = { {14{I}} , A , {17{I}} };
		   15 : EnableRegister = { {15{I}} , A , {16{I}} };
		   16 : EnableRegister = { {16{I}} , A , {15{I}} };
		   17 : EnableRegister = { {17{I}} , A , {14{I}} };
		   18 : EnableRegister = { {18{I}} , A , {13{I}} };
		   19 : EnableRegister = { {19{I}} , A , {12{I}} };
			
		   20 : EnableRegister = { {20{I}} , A , {11{I}} };
		   21 : EnableRegister = { {21{I}} , A , {10{I}} };
		   22 : EnableRegister = { {22{I}} , A , { 9{I}} };
		   23 : EnableRegister = { {23{I}} , A , { 8{I}} };
		   24 : EnableRegister = { {24{I}} , A , { 7{I}} };
		   25 : EnableRegister = { {25{I}} , A , { 6{I}} };
		   26 : EnableRegister = { {26{I}} , A , { 5{I}} };
		   27 : EnableRegister = { {27{I}} , A , { 4{I}} };
		   28 : EnableRegister = { {28{I}} , A , { 3{I}} };
		   29 : EnableRegister = { {29{I}} , A , { 2{I}} };
			
		   30 : EnableRegister = { {30{I}} , A ,  { 1{I}} };
		   31 : EnableRegister = { {31{I}} , A };
		   default : EnableRegister = {32{1'bx}};			 	//
		endcase	  
	else
		EnableRegister = {32{I}}; 								// daca nu avem enable toti bitii de iesire vor fi 0
endmodule
