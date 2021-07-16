// memorie RAM
// mod lucru: WRITE-FIRST (sau TRANSPARENT-WRITE)
//            informatia scrisa este transparenta la iesirea de date
module data_memory 
#(
	parameter N = 32,                    // dimensiunea liniei de adresa
	parameter W = 32                     // dimensiunea cuvantului de date 
)
(
	input               MemWrite,       // activa pe 1 , permite scriere in memorie
	input				MemRead,		// activa pe 1 , permite citire din memorie
	input      [W-1:0]  write_data,     // intrarea de date
	input      [N-1:0]  address,	    // intrarea de adresa
	output reg [W-1:0]  read_data	    // iesire de date
);

localparam SIZE = 2**10;                // dimensiunea memoriei
reg [W-1:0] mem_content [0: SIZE-1];    // modeleaza continutul memoriei 


// fortam primele 10 adrese ale memoriei sa contina numerele de la 0 la 10
always@(*)
	case(address)
		
		0 :   mem_content[ 0] = 32'd 0;
		1 :	  mem_content[ 1] = 32'd 1;
 		2 :   mem_content[ 2] = 32'd 2;
 		3 :   mem_content[ 3] = 32'd 3;
 		4 :   mem_content[ 4] = 32'd 4;
 		5 :   mem_content[ 5] = 32'd 5;
 		6 :   mem_content[ 6] = 32'd 6;
 		7 :   mem_content[ 7] = 32'd 7;
 		8 :   mem_content[ 8] = 32'd 8;
        9 :   mem_content[ 9] = 32'd 9;
	   10 :   mem_content[10] = 32'd10;
		
	endcase

// modelarea comportamentului memoriei RAM
always@(*)	  
	if(MemWrite) // scriere prioritara fata de citire
		begin
			mem_content[address] = write_data;   // operatie de scriere sincron	
		end	
	else if(MemRead)  
		begin
			read_data = mem_content[address];    // operatia de citire sincrona
		end
		
endmodule
