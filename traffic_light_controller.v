`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.08.2023 12:13:44
// Design Name: 
// Module Name: traffic
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module traffic(sensor,clk,highway,farmway,state,count,load,dec);
input sensor,clk;
output reg [2:0] highway,farmway;  // RYG

output reg [1:0] state;
parameter s0 = 2'b00,s1 = 2'b01,s2 = 2'b10,s3 = 2'b11;

output reg load,dec;
reg [2:0] in;
output wire [2:0] count;

counter c(load,in,count,dec,clk);

always@(posedge clk)
begin
case(state)
s0 : if(sensor == 1'b0) state <= s0;
     else if(sensor == 1'b1 && count == 3'b000) state <= s1;
    // else state <= s0;
s1 : if(count == 3'b000) state <= s2;
     else state <= s1;
s2 : if(count == 3'b000) state <= s3;
     else state <= s2;
s3 : if(count == 3'b000) state <= s0;
     else state <= s3;
//default : begin state <= s0;load <= 1'b1;in <= 3'b111; end
default : begin state <= s0; end
endcase
end


always@(posedge clk)
begin
case(state)
s0 : begin highway <= 3'b001;
     farmway <= 3'b100;
     if(count == 3'b000) begin load = 1'b1;in = 3'b111; end
     else begin load = 1'b0;dec = 1'b1; end end
s1 : begin highway <= 3'b100;
     farmway <= 3'b010;
     if(count == 3'b000) begin load = 1'b1;in = 3'b011; end
     else begin load = 1'b0;dec = 1'b1; end end
s2 : begin highway <= 3'b100;
     farmway <= 3'b001;
     if(count == 3'b000) begin load = 1'b1;in = 3'b111; end
     else begin load = 1'b0;dec = 1'b1; end end
s3 : begin highway <= 3'b010;
     farmway <= 3'b100;
     if(count == 3'b000) begin load = 1'b1;in = 3'b011; end
     else begin load = 1'b0;dec = 1'b1; end end
default : begin load = 1'b1;in = 3'b111; end
endcase
end

endmodule

module counter(load,in,out,dec,clk);
input load,dec,clk;
input [2:0] in;
output reg [2:0] out;
always@(posedge clk)
begin
if(load == 1'b1) out <= in;
else if(dec == 1'b1) out <= out-1;
end
endmodule
