//blocul Registers contine decodificatorul , RegisterBank si doua mux-uri 32_5
module Registers
(	input clk,//! 
	input 		  rst,			   // intrare de reset
	input 		  RegWrite,		   // intrare de enable de la blocul control
	input [4:0]   Read_register1,  // intrare de selectie pentru primul mux
	input [4:0]   Read_register2,  // intrare de selectie pentru al doilea mux
	input [4:0]   Write_register,  // intrare de date a decodificatorului
	input [31:0]  Write_data,	   // intrare de date a registrilor
	
	output [31:0] Read_data1,	   // iesirea primului mux
	output [31:0] Read_data2	   // iesirea celui de-al doilea mux
);	

wire [31:0] tmpEn;				   // fir de conexiune intre iesirea decodificatorului si intrarea de enable a RegisterBank
wire [31:0] tmpData [0:31];		   // fir de conexiune intre iesirea de date a RegisterBank si intrarile de date a mux-urilor
	
    dcd_en U1(
		.RegWrite(RegWrite),	   // enable
		.WriteRegister(Write_register), //intrare de date (selectarea registrului in care se poate scrie)
		.EnableRegister(tmpEn) //  conexiunea prin firul tmpEn
	);
	
	RegisterBank U2(
		.clk(clk), //!
		.rst(rst),			  // reset
		.load(tmpEn),		  //   conexiunea prin firul tmpEn
		.WriteData(Write_data),	   //intrare de date
		.ReadData(tmpData)	 // conexiunea prin firul tmpData
	);
	
	mux32_5 U3(
		.sel(Read_register1), // selectia registrului din care se face citirea
		.in(tmpData),		 // conexiunea prin firul tmpData
		.out(Read_data1)	 // iesirea de date a registrului din care se face citirea
	);
	
	mux32_5 U4(
		.sel(Read_register2), 
		.in(tmpData),	    // conexiunea prin firul tmpData
		.out(Read_data2)
	);
	
endmodule
