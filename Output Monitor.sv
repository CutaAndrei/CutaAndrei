
`ifndef PC_OP_MONITOR_SV
`define PC_OP_MONITOR_SV
 //  module monitor_out(PC_bus.out iout
//);	  
class PC_op_monitor;
  
 
  virtual PC_bus       ports;
 
function new (virtual PC_bus ports);
begin
	
  this.ports = ports;
  end
 endfunction
 
  task output_monitor();
    begin
      while (1) begin
        @ (negedge ports.clk);
       			if (ports.rst) begin
		  			$display("Output_monitor : Current adress is: %x ", 
            					ports.address);
 
  				 end
      		end
   		 end
 endtask  
 endclass 
 `endif	
 //  endmodule