`timescale 1ns / 1ps

module lock_tb;
reg clk = 0;
reg rst;
reg [2:0] btn;
wire led_open;
wire led_error;

lock uut(
    .clk(clk),
    .rst(rst),
    .btn(btn),
    .led_open(led_open),
    .led_error(led_error)
);

always begin
    #5 clk = ~clk;
end

initial begin
    $dumpfile("lock_tb.vcd");
    $dumpvars(0, lock_tb);
    
    rst=1;
    #15;
    rst=0;
    btn=3'b000;
    #10;

    btn=3'b001;
    #10;
    btn=3'b000;
    #10;

    btn=3'b010;
    #10;
    btn=3'b000;
    #10;

    btn=3'b100;
    #10;
    btn=3'b000;
    #20;



    rst=1;
    #15;
    rst=0;
    btn=3'b000;
    #10;

    btn=3'b001;
    #10;
    btn=3'b000;
    #10;

    btn=3'b001;
    #10;
    btn=3'b000;
    #20;

    #50;
    $finish;
end

endmodule