`ifndef PC_OP_MONITOR_SV
`define PC_OP_MONITOR_SV
   
class PC_op_monitor;
  
 
  virtual PC       ports;
 
function new (virtual PC ports);
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