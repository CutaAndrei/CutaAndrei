// registru parametrizabil, cu incarcare PARALELA si iesire PARALELA
module rpp #(parameter N = 32)	 // N = dimensiunea registrului 
(	
	input clk,					//!
	input rst ,					// activ 1 , sincron
	input load,   				// comanda incarcare ,  activ pe 1 (vine de la iesirea decodificatorului si ajunge pe registrul in care trebuie scrise date)		
	input [N-1:0] WriteData, 	// intrare de date
	output[N-1:0] ReadData      // iesire de date
);

reg[N-1:0] tmp;	        		// starea (continutul)	registrului

always@(posedge clk)	//!	   				// always va fi executat cand apare un eveniment pe oricare dintre intrari
    if(rst)
		tmp = {N{1'b0}};		// initializare circuit
	else 
		if(load)			 	// modelare operatie incarcare
			tmp = WriteData;    // a datei in registru     
	
assign ReadData = tmp;          // modelare comportament iesire

endmodule
