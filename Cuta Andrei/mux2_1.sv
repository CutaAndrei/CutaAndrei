// mux2-1 => multiplexor parametrizabil cu doua intrari de date pe N biti , o iesire de date pe N biti si o selectie pe un bit
module mux2_1 #( parameter N = 32 )			
	 (	  
	 	input  sel,	   				// semnal de selectie (out = in0 daca sel = 0 sau out = in1 daca sel = 1)
	 	input  [ N-1 : 0 ] in0,		// intrarea 1 de date pe N biti
	 	input  [ N-1 : 0 ] in1,		// intrarea 2 de date pe N biti
		output [ N-1 : 0 ] out		// iesirea de date pe N biti
	 );		 
	 
	 assign out = sel ? in1 : in0; 	// conditionala <=> if(sel) out = in1;
		 							//					else 	out = in0; 
endmodule
