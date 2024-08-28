module tb;
reg sensor,clk;
wire [2:0] highway,farmway;
wire [1:0] state;
wire [2:0] count;
wire load,dec;

traffic DUT(sensor,clk,highway,farmway,state,count,load,dec);

always #5 clk = ~clk;

initial 
begin
clk = 1'b0;
sensor = 1'b1;
#1000 $finish;
end
endmodule
