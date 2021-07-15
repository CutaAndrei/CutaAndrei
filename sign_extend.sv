// modul parametrizabil de extindere a intrarii data_in de la N biti la M biti
// extinderea numerelor cu semn ar trebui sa fie facuta cu biti de 1, functionalitatea va fi adaugata. Momentan avem doar extindere a numerelor fara semn
module sign_extend #( parameter N = 16 , M = 32 )
(
	input  [N-1:0] data_in,	  // intrare de date
	output [M-1:0] data_out	  // iesire de date
);
	assign data_out = {{M-N{1'b0}},data_in};   // concatenam M-N biti de 0 cu cei N biti de intrare => M biti de iesire
endmodule
