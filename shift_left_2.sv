// shifter left parametrizabil cu N biti de intrare si M biti de iesire
module shift_left_2 #( parameter N = 32 , M = 32 )
(
	input  [N-1:0] data_in,	// intrare de date
	output [M-1:0] data_out	// iesire de date
);

	assign data_out = {data_in, 2'b00};	  // atribuim iesirii intrarea shiftata cu doua pozitii la stanga  (de la LSB spre MSB)

endmodule
