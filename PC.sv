// la fiecare front activ de ceas la iesirea address va aparea urmatoarea adresa a programului
module PC(PC_bus.in iin,PC_bus.out iout );

always@(posedge iin.clk)
	if(iin.rst)
		iout.address <= {32{1'b0}};	 // initializare circuit
	else
		iout.address <= iin.next_address; // modelare operatie de incarcare 
		
endmodule
