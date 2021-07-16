	//  module PC_ip_monitor(PC_bus.in iin);  
`ifndef PC_IP_MONITOR_SV
`define PC_IP_MONITOR_SV 

class PC_ip_monitor; 
    virtual PC_bus  ports;
	function new (virtual PC_bus ports);
    begin  
      this.ports = ports;
    end
  endfunction

    task input_monitor();
    begin  
	while (1) begin
		@ (posedge ports.clk);
     		 if (ports.rst) begin
      			 $display("input_monitor : Next adress is: %x ", 
         					 ports.next_address);

       
    			end 
   		 	end
 		 end
	 endtask

 endclass
 `endif		   
	//endmodule