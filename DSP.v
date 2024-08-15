
module DSP48A1 (
       A,B,C,D,CARRYIN,M,P,CARRYOUT,CARRYOUTF,CLK,OPMODE,CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP,RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP,BCOUT,PCIN,PCOUT,BCIN

);
parameter A0REG=0,A1REG=1,B0REG=0,B1REG=1,CREG=1,DREG=1,MREG=1,PREG=1,CARRYINREG=1,CARRYOUTREG=1,OPMODEREG=1,CARRYINSEL="OPMODE5",B_INPUT="DIRECT",RSTTYPE="SYNC" ;
input [17:0] A,B,D,BCIN;
input [47:0] C,PCIN;
input CARRYIN,CLK,CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP,RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP;
input [7:0] OPMODE;
output CARRYOUT,CARRYOUTF;
output [35:0] M;
output [47:0] P,PCOUT;
output [17:0] BCOUT;


wire  [7:0] wire_opmode;//BEC OPMODE SAME AS INPUTS REGISTED
wire  [17:0] out_muxB;
wire  [17:0] out_muxD;
wire  [17:0] out_muxB0;
wire  [17:0] out_muxA0;
wire  [47:0] out_muxC;
wire  [17:0] out_ADDER1;
wire  [17:0] out_mux_AFTER_ADDER1;
wire  [17:0] out_muxB1;
wire  [17:0] out_muxA1;
wire  [35:0] out_MULTIP;//CHECK
wire  [35:0] out_muxM;
wire  [47:0] out_muxX;
wire  [47:0] out_muxZ;
wire  [47:0] out_ADDER2;
wire  [47:0] D_A_B;
wire   out_mux_Carry_Cascade,CIN,input_CY0;

reg_mux#(1,8,"SYNC") op_mode(OPMODE,wire_opmode,CLK,RSTOPMODE,CEOPMODE);

reg_mux#(1,18,"SYNC") D_REG(D,out_muxD,CLK,RSTD,CED);
reg_mux#(0,18,"SYNC") B0_REG(B,out_muxB0,CLK,RSTB,CEB);
reg_mux#(0,18,"SYNC") A0_REG(A,out_muxA0,CLK,RSTA,CEA);
reg_mux#(1,48,"SYNC") C_REG(C,out_muxC,CLK,RSTC,CEC);

assign out_ADDER1=(wire_opmode[6]==1)?(out_muxD-out_muxB0):(out_muxD+out_muxB0);

assign out_mux_AFTER_ADDER1=(wire_opmode[4]==0)?out_muxB:out_ADDER1;

reg_mux#(1,18,"SYNC") B1_REG(out_mux_AFTER_ADDER1,out_muxB1,CLK,RSTB,CEB);

reg_mux#(1,18,"SYNC") A1_REG(out_muxA0,out_muxA1,CLK,RSTA,CEA);


assign out_MULTIP=out_muxB1*out_muxA1;
assign BCOUT=out_muxB1;

reg_mux#(1,36,"SYNC") M_REG(out_MULTIP,out_muxM,CLK,RSTM,CEM);

assign M=out_muxM;

//assign out_mux_Carry_Cascade=wire_opmode[5];//as default

assign out_mux_Carry_Cascade=(CARRYINSEL=="OPMODE5")? 
wire_opmode[5]:(CARRYINSEL=="CARRYIN")?CARRYIN:0; 

reg_mux#(1,1,"SYNC") C_Y1(out_mux_Carry_Cascade,CIN,CLK,RSTCARRYIN,CECARRYIN);

assign out_muxX=(wire_opmode[1:0]==0)?0:(wire_opmode[1:0]==1)?out_muxM:(wire_opmode[1:0]==2)? PCOUT:D_A_B;

assign out_muxZ=(wire_opmode[3:2]==0)?0:(wire_opmode[3:2]==1)?PCIN:(wire_opmode[3:2]==2)?PCOUT:out_muxC;

assign out_ADDER2=(wire_opmode[7]==0)?(out_muxX+out_muxZ):(out_muxZ-(out_muxX+CIN));

reg_mux#(1,48,"SYNC") P_REG(out_ADDER2,P,CLK,RSTP,CEP);

reg_mux#(1,1,"SYNC") C_Y0(input_CY0,CARRYOUT,CLK,RSTC,CEC);

assign CARRYOUTF=CARRYOUT;

assign PCOUT=P;
endmodule