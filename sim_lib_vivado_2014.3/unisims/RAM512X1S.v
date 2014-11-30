///////////////////////////////////////////////////////////////////////////////
//  Copyright (c) 1995/2014 Xilinx, Inc.
//  All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2014.3
//  \   \         Description : Xilinx Functional Simulation Library Component
//  /   /                  Static Synchronous RAM 512-Deep by 1-Wide
// /___/   /\     Filename : RAM512X1S.v
// \   \  /  \    
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    07/02/12 - Initial version, from RAM256X1S
//    09/17/12 - 678488 fix file name
// End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps

`celldefine

module RAM512X1S #(
`ifdef XIL_TIMING
  parameter LOC = "UNPLACED",
`endif
  parameter [511:0] INIT = 512'h0,
  parameter [0:0] IS_WCLK_INVERTED = 1'b0
)(
  output O,

  input [8:0] A,
  input D,
  input WCLK,
  input WE
);

// define constants
  localparam MODULE_NAME = "RAM512X1S";

  reg trig_attr = 1'b0;

`ifdef XIL_ATTR_TEST
  reg attr_test = 1'b1;
`else
  reg attr_test = 1'b0;
`endif
  reg attr_err = 1'b0;

  wire D_in;
  wire WCLK_in;
  wire WE_in;
  wire [8:0] A_in;

  wire D_dly;
  wire WCLK_dly;
  wire WE_dly;
  wire [8:0] A_dly;

`ifdef XIL_TIMING
  reg notifier;
`endif
    
`ifndef XIL_TIMING
  assign A_dly = A;
  assign D_dly = D;
  assign WCLK_dly = WCLK;
  assign WE_dly = WE;
`endif
  assign A_in = A_dly;
  assign D_in = D_dly;
  assign WCLK_in = WCLK_dly ^ IS_WCLK_INVERTED;
  assign WE_in = (WE === 1'bz) || WE_dly; // rv 1

  initial begin
    #1;
    trig_attr = ~trig_attr;
  end

  always @ (trig_attr) begin
  #1;
    if ((attr_test == 1'b1) ||
        ((INIT < 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000) || (INIT > 512'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF))) begin
      $display("Error: [Unisim %s-101] INIT attribute is set to %h.  Legal values for this attribute are 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 to 512'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF. Instance: %m", MODULE_NAME, INIT);
      attr_err = 1'b1;
    end

    if ((attr_test == 1'b1) ||
        ((IS_WCLK_INVERTED !== 1'b0) && (IS_WCLK_INVERTED !== 1'b1))) begin
      $display("Error: [Unisim %s-102] IS_WCLK_INVERTED attribute is set to %b.  Legal values for this attribute are 1'b0 to 1'b1. Instance: %m", MODULE_NAME, IS_WCLK_INVERTED);
      attr_err = 1'b1;
    end

    if (attr_err == 1'b1) $finish;
  end

  reg  [511:0] mem;

  assign O = mem[A_in];

  initial 
      mem = INIT;

  always @(posedge WCLK_in) 
      if (WE_in == 1'b1) mem[A_in] <= #100 D_in;
    
`ifdef XIL_TIMING
  always @(notifier) mem[A_in] <= 1'bx;
`endif
    
`ifdef XIL_TIMING
  specify
  (WCLK => O) = (0:0:0, 0:0:0);
  (A *> O) = (0:0:0, 0:0:0);
  $period (negedge WCLK &&& WE, 0:0:0, notifier);
  $period (posedge WCLK &&& WE, 0:0:0, notifier);
  $setuphold (negedge WCLK, negedge A[0] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[0]);
  $setuphold (negedge WCLK, negedge A[1] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[1]);
  $setuphold (negedge WCLK, negedge A[2] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[2]);
  $setuphold (negedge WCLK, negedge A[3] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[3]);
  $setuphold (negedge WCLK, negedge A[4] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[4]);
  $setuphold (negedge WCLK, negedge A[5] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[5]);
  $setuphold (negedge WCLK, negedge A[6] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[6]);
  $setuphold (negedge WCLK, negedge A[7] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[7]);
  $setuphold (negedge WCLK, negedge A[8] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[8]);
  $setuphold (negedge WCLK, negedge D &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,D_dly);
  $setuphold (negedge WCLK, negedge WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,WE_dly);
  $setuphold (negedge WCLK, posedge A[0] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[0]);
  $setuphold (negedge WCLK, posedge A[1] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[1]);
  $setuphold (negedge WCLK, posedge A[2] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[2]);
  $setuphold (negedge WCLK, posedge A[3] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[3]);
  $setuphold (negedge WCLK, posedge A[4] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[4]);
  $setuphold (negedge WCLK, posedge A[5] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[5]);
  $setuphold (negedge WCLK, posedge A[6] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[6]);
  $setuphold (negedge WCLK, posedge A[7] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[7]);
  $setuphold (negedge WCLK, posedge A[8] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[8]);
  $setuphold (negedge WCLK, posedge D &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,D_dly);
  $setuphold (negedge WCLK, posedge WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,WE_dly);
  $setuphold (posedge WCLK, negedge A[0] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[0]);
  $setuphold (posedge WCLK, negedge A[1] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[1]);
  $setuphold (posedge WCLK, negedge A[2] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[2]);
  $setuphold (posedge WCLK, negedge A[3] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[3]);
  $setuphold (posedge WCLK, negedge A[4] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[4]);
  $setuphold (posedge WCLK, negedge A[5] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[5]);
  $setuphold (posedge WCLK, negedge A[6] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[6]);
  $setuphold (posedge WCLK, negedge A[7] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[7]);
  $setuphold (posedge WCLK, negedge A[8] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[8]);
  $setuphold (posedge WCLK, negedge D &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,D_dly);
  $setuphold (posedge WCLK, negedge WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,WE_dly);
  $setuphold (posedge WCLK, posedge A[0] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[0]);
  $setuphold (posedge WCLK, posedge A[1] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[1]);
  $setuphold (posedge WCLK, posedge A[2] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[2]);
  $setuphold (posedge WCLK, posedge A[3] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[3]);
  $setuphold (posedge WCLK, posedge A[4] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[4]);
  $setuphold (posedge WCLK, posedge A[5] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[5]);
  $setuphold (posedge WCLK, posedge A[6] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[6]);
  $setuphold (posedge WCLK, posedge A[7] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[7]);
  $setuphold (posedge WCLK, posedge A[8] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[8]);
  $setuphold (posedge WCLK, posedge D &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,D_dly);
  $setuphold (posedge WCLK, posedge WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,WE_dly);
  specparam PATHPULSE$ = 0;
  endspecify
`endif

endmodule

`endcelldefine
