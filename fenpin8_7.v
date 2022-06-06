// -----------------------------------------------------------------------------
// Copyright (c) 2014-2022 All rights reserved
// -----------------------------------------------------------------------------
// Author : 1598491517@qq.com
// File   : fenpin8_7.v
// Create : 2022-05-06 22:10:39
// Revise : 2022-05-06 22:35:00
// Editor : sublime text3, tab size (4)
// -----------------------------------------------------------------------------

module div_M_N(
 input  wire clk_in,
 input  wire rst,
 output wire clk_out
);
parameter M_N = 8'd87; 
parameter c89 = 8'd24; // 8/9时钟切换点
parameter div_e = 5'd8; //偶数周期
parameter div_o = 5'd9; //奇数周期
//*************code***********//
    reg [2:0] c_8;
    reg clk_8;
    reg [3:0] c_9;
    reg clk_9_p,clk_9_n;
    wire clk_9;
    reg [7:0] count_c_89;
    always @(posedge clk_in)begin
        if(!rst)begin
            count_c_89<='d0;
        end
        else if(count_c_89== M_N-1)begin
            count_c_89<='d0;
        end
        else
            count_c_89<=count_c_89+1;
    end
    always@(posedge clk_in)begin
        if(!rst)begin
            c_8<='d0;
            c_9<='d0;
        end
        else if(c_9==div_o-1)begin
            c_9<='d0;
            c_8<=c_8+1'b1;
        end
        else begin
            c_8<=c_8+1'b1;
            c_9<=c_9+1'b1;
        end
    end
    always@(posedge clk_in)begin
        if(!rst)begin
            clk_8<=1'b1;
        end
        else if((c_8==div_e/2-1)||(c_8==div_e-1))begin
            clk_8<=~clk_8;
        end
    end
    always@(posedge clk_in)begin
        if(!rst)begin
            clk_9_p<=1;
        end
        else if(((c_9==(div_o-1)/2-1))||(c_9==(div_o-1)))begin
            clk_9_p<=~clk_9_p;
        end
    end
    always@(negedge clk_in)begin
        if(!rst)begin
            clk_9_n<=1;
        end
        else if((c_9==((div_o-1)/2-1))||(c_9==(div_o-1)))begin
            clk_9_n<=~clk_9_n;
        end
    end
    assign clk_9 = clk_9_p||clk_9_n;
    assign clk_out = ((clk_8)&&(count_c_89<c89))||((clk_9)&&(count_c_89>=c89));

//*************code***********//
endmodule