`ifndef PC_interface_SV
`define PC_interface_SV

interface PC_bus(input clk,input rst);
	
logic[31:0] address;
logic[31:0] next_address ;

modport in (input clk,rst,  next_address);
modport out(input clk,rst, output address);

endinterface  : PC_bus

`endif