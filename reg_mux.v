module reg_mux (
    in,out,clk,rst,ce 
);

parameter SEL=0,WIDTH=1,RSTTYPE="SYNC";
input clk,rst,ce;
input [WIDTH-1:0] in ;
output  [WIDTH-1:0] out;// output of the mux block

reg [WIDTH-1:0] out_reg;//output of the register block



always @(posedge clk or posedge rst ) begin// 1st always block for real logic and equating the typical parameters,,1st block if rst asyncchronus he will enter one always only may be
    if(RSTTYPE=="ASYNC")begin
    if (rst) begin
        out_reg<=0;
    end
 else if(ce) begin
    out_reg<=in;
 end

end
end

always @(posedge clk) begin// 2always block for the logic using reg wire for the register block
    if (ce) begin
       if(rst) out_reg<=0;
    
    else begin
        out_reg<=in;
    end
    end
end

assign out=(SEL==1)? out_reg:in;
  
endmodule