// memorie de instructiuni
module Instruction_memory  
#(
	parameter N = 32,                    // dimensiunea liniei de adresa
	parameter W = 8                      // dimensiunea cuvantului de date 
)
(
	input  [N-1:0] address,			// intrarea de adresa
	output [N-1:0] instruction		// iesire de date
);

localparam SIZE = 512;                  // dimensiunea memoriei
reg [W-1:0] mem_content [0:SIZE-1];     // modeleaza continutul memoriei

//instructiuni hard codate pentru programul dezvoltat
																	   // if
	
localparam instruction_0  = 32'b000100_00000_00001_0000000000000101;   // aduce din memorie data 5 si o stocheaza in registrul 1
localparam instruction_1  = 32'b000100_00000_00010_0000000000000111;   // aduce din memorie data 7 si o stocheaza in registrul 2 
localparam instruction_2  = 32'b000110_00010_00001_0000000000000010;   // beq -> verifica daca continutul registrului 2 este egal cu continutul registrului 1
																	   // daca sunt egale sare la instructiunea de la adresa 20
localparam instruction_3  = 32'b000100_00000_00011_0000000000001001;   // incarca 9 in registrul 3
localparam instruction_4  = 32'b000010_00000000000000000000000110;	   // jump la adresa 24	(sare peste instructiunea de la adresa 20)
localparam instruction_5  = 32'b000000_00001_00010_00011_00000_100001; // registrul 3 primeste continutul registrului1 + continutul registrului2

																	   // for
	
localparam instruction_6  = 32'b000100_00000_01000_0000000000000001;   // initializam continutul registrului 8 cu valoarea 1 (gasita la adresa 1 in data mem)
localparam instruction_7  = 32'b000000_00100_00011_01010_00000_101011; // compara continutul registrului 4 cu continutul registrului 3 si memoreaza 
																	   // rezultatul in registrul 10 
localparam instruction_8  = 32'b000110__01010_00000_0000000000000011;  // verifica daca continutul registrului 10 este egal cu continutul registrului 0
																	   // daca este egal va sari la adresa 48
localparam instruction_9  = 32'b000000_00101_00100_00101_00000_100001; // registrul5 = registrul4 + registrul5
localparam instruction_10 = 32'b000000_00100_01000_00100_00000_100001; // registrul4 = registrul4 + 1
localparam instruction_11 = 32'b000010_00000000000000000000000111;	   // sari la instructiunea de la adresa 28 (instructiunea 7)
																	   // (se va executa doar daca registrul10 != registrul0) 

																	   // do...while
	
localparam instruction_12 = 32'b000100_00000_00110_0000000000001010;   // registrul6 = data de la adresa 10 din data memory
localparam instruction_13 = 32'b000000_00110_00111_00110_00000_100011; // registrul6 = registrul6 - registrul7
localparam instruction_14 = 32'b000000_00111_01000_00111_00000_100001; // registrul7 = registrul7 + 1
localparam instruction_15 = 32'b000110_00110_00111_0000000000000001;   // beq -> verifaca daca registrul6 == registrul7
																	   // daca sunt egale sare la instructiunea de la adresa 68
localparam instruction_16 = 32'b000010_00000000000000000000001101;	   // jump la instructiunea de la adresa 52 
																	   // (se va executa doar daca registrul6 != registrul7)

																	   // while

localparam instruction_17 = 32'b000000_00001_00010_01010_00000_101011; // compara registrul1 cu registrul2 si salveaza rezultatul in registrul10
localparam instruction_18 = 32'b000110_01010_00000_0000000000000010;   // beq verifica daca registrul10 == registrul0 , daca da sare la 84
localparam instruction_19 = 32'b000000_00001_01000_00001_00000_100001; // registrul1 = 1 + registrul1  (se va executa doar daca registrul10 != registrul0)
localparam instruction_20 = 32'b000010_00000000000000000000010001;	   // jump la adresa 68 		   (se va executa doar daca registrul10 != registrul0)

																	   // sfarsit
localparam instruction_21 = 32'b000000_00000_00000_00000_00000_100001;

// Atribuirea continutului memoriei in functie de adresa primita la intrarea address

always@(address)
	case(address)
		0 : {mem_content[address],mem_content[address+1],mem_content[address+2],mem_content[address+3]} = instruction_0 ;
		
		4 : {mem_content[address],mem_content[address+1],mem_content[address+2],mem_content[address+3]} = instruction_1 ;
		
		8 : {mem_content[address],mem_content[address+1],mem_content[address+2],mem_content[address+3]} = instruction_2 ;
																													    
	   12 : {mem_content[address],mem_content[address+1],mem_content[address+2],mem_content[address+3]} = instruction_5 ;
	   
	   16 : {mem_content[address],mem_content[address+1],mem_content[address+2],mem_content[address+3]} = instruction_4 ;	
	   
	   20 :	{mem_content[address],mem_content[address+1],mem_content[address+2],mem_content[address+3]} = instruction_3 ;
	   
	   24 :	{mem_content[address],mem_content[address+1],mem_content[address+2],mem_content[address+3]} = instruction_6 ;
	   
	   28 :	{mem_content[address],mem_content[address+1],mem_content[address+2],mem_content[address+3]} = instruction_7 ;
	   																												    
	   32 :	{mem_content[address],mem_content[address+1],mem_content[address+2],mem_content[address+3]} = instruction_8 ;
	   
	   36 :	{mem_content[address],mem_content[address+1],mem_content[address+2],mem_content[address+3]} = instruction_9 ;
	   
	   40 :	{mem_content[address],mem_content[address+1],mem_content[address+2],mem_content[address+3]} = instruction_10;
	   
	   44 :	{mem_content[address],mem_content[address+1],mem_content[address+2],mem_content[address+3]} = instruction_11;
	   
	   48 :	{mem_content[address],mem_content[address+1],mem_content[address+2],mem_content[address+3]} = instruction_12;
	   
	   52 :	{mem_content[address],mem_content[address+1],mem_content[address+2],mem_content[address+3]} = instruction_13;
	   
	   56:	{mem_content[address],mem_content[address+1],mem_content[address+2],mem_content[address+3]} = instruction_14;
	   
	   60 :	{mem_content[address],mem_content[address+1],mem_content[address+2],mem_content[address+3]} = instruction_15;
	   
	   64 :	{mem_content[address],mem_content[address+1],mem_content[address+2],mem_content[address+3]} = instruction_16;
	   
	   68 :	{mem_content[address],mem_content[address+1],mem_content[address+2],mem_content[address+3]} = instruction_17;
	   
	   72 :	{mem_content[address],mem_content[address+1],mem_content[address+2],mem_content[address+3]} = instruction_18;
	   
	   76 :	{mem_content[address],mem_content[address+1],mem_content[address+2],mem_content[address+3]} = instruction_19;
	   
	   80 :	{mem_content[address],mem_content[address+1],mem_content[address+2],mem_content[address+3]} = instruction_20;
	   
	   84 :	{mem_content[address],mem_content[address+1],mem_content[address+2],mem_content[address+3]} = instruction_21;
		
	endcase

// atribuirea la iesire a continutului memoriei
assign instruction = { mem_content[address], mem_content[address+1], mem_content[address+2], mem_content[address+3] };
		

endmodule	
