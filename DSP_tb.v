module DSP_tb (
    
);
reg [17:0] A_tb,B_tb,D_tb,BCIN_tb;
reg [47:0] C_tb,PCIN_tb;
reg CARRYIN_tb,CLK_tb,CEA_tb,CEB_tb,CEC_tb,CECARRYIN_tb,CED_tb,CEM_tb,CEOPMODE_tb,CEP_tb,RSTA_tb,RSTB_tb,RSTC_tb,RSTCARRYIN_tb,RSTD_tb,RSTM_tb,RSTOPMODE_tb,RSTP_tb;
reg [7:0] OPMODE_tb;
wire CARRYOUT_tb,CARRYOUTF_tb;
wire [35:0] M_tb;
wire [47:0] P_tb,PCOUT_tb;
wire [17:0] BCOUT_tb;

parameter A0REG_tb=0,A1REG_tb=1,B0REG_tb=0,B1REG_tb=1,CREG_tb=1,DREG_tb=1,MREG_tb=1,PREG_tb=1,CARRYINREG_tb=1,CARRYOUTREG_tb=1,OPMODEREG_tb=1,CARRYINSEL_tb="OPMODE5",B_INPUT_tb="DIRECT",RSTTYPE_tb="SYNC";
    
    DSP48A1#(A0REG_tb,A1REG_tb,B0REG_tb,B1REG_tb,CREG_tb,DREG_tb,MREG_tb,PREG_tb,CARRYINREG_tb,CARRYOUTREG_tb,OPMODEREG_tb,CARRYINSEL_tb,B_INPUT_tb,RSTTYPE_tb) dut(A_tb,B_tb,C_tb,D_tb,CARRYIN_tb,M_tb,P_tb,CARRYOUT_tb,CARRYOUTF_tb,CLK_tb,OPMODE_tb,CEA_tb,CEB_tb,CEC_tb,CECARRYIN_tb,CED_tb,CEM_tb,CEOPMODE_tb,CEP_tb,RSTA_tb,RSTB_tb,RSTC_tb,RSTCARRYIN_tb,RSTD_tb,RSTM_tb,RSTOPMODE_tb,RSTP_tb,BCOUT_tb,PCIN_tb,PCOUT_tb,BCIN_tb);

    initial begin
        CLK_tb=0;
        forever begin
            #2 CLK_tb=~CLK_tb;
        end
 end  
 initial begin
     RSTA_tb=1;RSTB_tb=1;RSTM_tb=1;RSTP_tb=1;RSTC_tb=1;RSTD_tb=1;RSTCARRYIN_tb=1;RSTOPMODE_tb=1;
    #20; // testin the rst signals
RSTA_tb=0;RSTB_tb=0;RSTM_tb=0;RSTP_tb=0;RSTC_tb=0;RSTD_tb=0;RSTCARRYIN_tb=0;RSTOPMODE_tb=0;

CEA_tb=1;CEB_tb=1;CEM_tb=1;CEP_tb=1;CEC_tb=1;CED_tb=1;CECARRYIN_tb=1;CEOPMODE_tb=1; 
    A_tb=10; 
    B_tb=11; 
    C_tb=12; 
    D_tb=13; 
    CARRYIN_tb=0; 
    OPMODE_tb=8'b00011101; 
    #20;
    OPMODE_tb=8'b10001101; 
#20; 
$stop; 
 end
endmodule