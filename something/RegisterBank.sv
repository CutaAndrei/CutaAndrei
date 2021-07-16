//modul cu 32 de registri rpp
module RegisterBank 
(	
	input 		  clk, 	//!
	input 		  rst,	 // activ pe 1, initializeaza toti registri din interiorul modulului
	input  [31:0] load,	 // intrare de enable (va permite scrierea pe un singur registru din cei 32 , vine de la decodificator)
	input  [31:0] WriteData , // intrare de date , va ajunge la toti registrii, dar va avea efect doar pentru registrul cu load = 1
	output [31:0] ReadData [0:31]  // 32 de iesiri de date, cate una pentru fiecare registru
);	  
	assign ReadData[0] = 32'b0;	// fortam valoarea registrului 0 la valoarea 0 pe toti cei 32biti (va fi folosit drept referitna)
								// nu poate fi modificat!
	/*rpp #(.N(32)) U0(				
									.clk(clk),
									.rst(rst),		       // reset comun pentru toti registrii
									.load(load[31]),       // conectam fiecare bit de load la registrul sau.
									.WriteData(32'd0), 		   // intrarea de date comuna pentru toti registrii
									.ReadData(ReadData[0]) // fiecare registru conectat la una iesirea cu numarul sau specific
					);
	*/
	
	generate		  // pentru a nu instantia de 31 ori registrul rpp vom folosi instructiunea generate pentru a instantia automat
		genvar i;
			for( i = 1 ; i <= 31 ; i = i+1 )
				begin: structura_regulata
					rpp #(.N(32)) U(					   // instantierea componentei rpp
									.clk(clk),			   // clock comun pentru toti registrii
									.rst(rst),		       // reset comun pentru toti registrii
									.load(load[31-i]),     // conectam fiecare bit de load la registrul sau.
									.WriteData(WriteData), // intrarea de date comuna pentru toti registrii
									.ReadData(ReadData[i]) // fiecare registru conectat la una iesirea cu numarul sau specific
					);
				end
	endgenerate
					
endmodule
