 
`include "PC_interface.sv"
module tb_top;
	  logic clk;
	  logic rst;
	  logic[31:0] address;
	  logic[31:0] next_address ;


 
 program tb_top(PC_bus ports);
`include "Input_monitor.sv"
`include "Output Monitor.sv"
PC_ip_monitor ipm;
PC_op_monitor opm;
initial begin
	ipm = new(ports);
	opm = new(ports);
	fork
    ipm.input_monitor();
    opm.output_monitor();
  join_none
  repeat (20) @ (posedge ports.clk);	
  end
  endprogram	  
endmodule