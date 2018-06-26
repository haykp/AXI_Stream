`timescale 1ns/1ps

module TB_axis_m ();

default clocking cb @(posedge aclk);
endclocking

bit aclk, rst, send;
logic finish;

logic tready; 
logic tvalid, tlast;
logic [31:0] tdata;

wire pc_asserted ;
wire [31 : 0] pc_status ;

logic [31:0] data;

assign cntLimit=6'd40;

axis_m inst_axis_m (.rst(rst), .aclk(aclk),
					.data(data),
					.send(send),
					.tready(tready), 
                    .tvalid(tvalid),.tlast(tlast),.tdata(tdata),
					.finish (finish)
					);
					
					

/* axis_protocol_checker_0 inst_axiCheck (
  .aclk(aclk),                      // input wire aclk
  .aresetn(~rst),                // input wire aresetn
  .pc_axis_tvalid(tvalid),  // input wire pc_axis_tvalid
  .pc_axis_tready(tready),  // input wire pc_axis_tready
  .pc_axis_tdata({5'd0,tdata}),    // input wire [7 : 0] pc_axis_tdata
  .pc_asserted(pc_asserted),        // output wire pc_asserted
  .pc_status(pc_status)            // output wire [31 : 0] pc_status
); */					

initial 
 forever #2 aclk++;

initial
begin
    rst <= 1;
    ##4 rst <= 0;
end

initial
begin
##10    send = 1;
##1    send = 0;
//##2    send <= 0;
end


initial
begin
    tready =0;
    ##15 tready = 1;
    ##1 tready = 0 ;
    ##10 tready = 1 ;
end

initial
begin
data <=32'haaaa_bbbb;
##90
data <=32'hcccc_dddd;
end

endmodule
