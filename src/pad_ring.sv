// SPDX-FileCopyrightText: © 2025 Project Template Contributors
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

`include "slot_defines.svh"

module pad_ring #(
    // Power/ground pads for core and I/O
    parameter NUM_DVDD_PADS = `NUM_DVDD_PADS,
    parameter NUM_DVSS_PADS = `NUM_DVSS_PADS,

    // Signal pads
    parameter NUM_INPUT_PADS = `NUM_INPUT_PADS,
    parameter NUM_BIDIR_PADS = `NUM_BIDIR_PADS,
    parameter NUM_ANALOG_PADS = `NUM_ANALOG_PADS,
    parameter NUM_UNUSED_PADS = `NUM_UNUSED_PADS
    )(
    `ifdef USE_POWER_PINS
    inout  wire VDD,
    inout  wire VSS,
    `endif

    inout  wire clk1_PAD,
    inout  wire wrst_n1_PAD,
    inout  wire rrst_n1_PAD,

    inout  wire clk2_PAD,
    inout  wire rst_n2_PAD,

    inout  wire clk3_PAD,
    inout  wire clk3_b_PAD,
    inout  wire rst_n3_PAD,

    inout  wire spi_clk0_PAD,
    inout  wire spi_clk1_PAD,
    inout  wire spi_clk2_PAD,
    
    inout  wire [NUM_INPUT_PADS-1:0] input_PAD,
    inout  wire [NUM_BIDIR_PADS-1:0] bidir_PAD,
    inout  wire [NUM_UNUSED_PADS-1:0] unused_PAD,
    
    inout  wire [NUM_ANALOG_PADS-1:0] analog_PAD
);

    wire clk1_PAD2CORE;
    wire wrst_n1_PAD2CORE;
    wire rrst_n1_PAD2CORE;

    wire clk2_PAD2CORE;
    wire rst_n2_PAD2CORE;

    wire clk3_PAD2CORE;
    wire clk3_b_PAD2CORE;
    wire rst_n3_PAD2CORE;

    wire spi_clk0_PAD2CORE;
    wire spi_clk1_PAD2CORE;
    wire spi_clk2_PAD2CORE;
    
    wire [NUM_INPUT_PADS-1:0] input_PAD2CORE;
    // wire [NUM_INPUT_PADS-1:0] input_CORE2PAD_PU;
    // wire [NUM_INPUT_PADS-1:0] input_CORE2PAD_PD;

    // assign input_CORE2PAD_PU = '0;
    // assign input_CORE2PAD_PD = '0;

    wire [NUM_BIDIR_PADS-1:0] bidir_PAD2CORE;
    // wire [NUM_BIDIR_PADS-1:0] bidir_CORE2PAD;
    // wire [NUM_BIDIR_PADS-1:0] bidir_CORE2PAD_OE;
    // wire [NUM_BIDIR_PADS-1:0] bidir_CORE2PAD_CS;
    // wire [NUM_BIDIR_PADS-1:0] bidir_CORE2PAD_SL;
    // wire [NUM_BIDIR_PADS-1:0] bidir_CORE2PAD_IE;
    // wire [NUM_BIDIR_PADS-1:0] bidir_CORE2PAD_PU;
    // wire [NUM_BIDIR_PADS-1:0] bidir_CORE2PAD_PD;

    // assign bidir_CORE2PAD = '0;
    // assign bidir_CORE2PAD_OE = '1;
    // assign bidir_CORE2PAD_CS = '0;
    // assign bidir_CORE2PAD_SL = '0;
    // assign bidir_CORE2PAD_IE = '0;
    // assign bidir_CORE2PAD_PU = '0;
    // assign bidir_CORE2PAD_PD = '0;

    // assign  = 1'b0;
    // assign  = 1'b1;

    wire [NUM_UNUSED_PADS-1:0] _unused_PAD2CORE;


    // Power/ground pad instances
    generate
    for (genvar i=0; i<NUM_DVDD_PADS; i++) begin : dvdd_pads
        (* keep *)
        gf180mcu_ws_io__dvdd pad (
            `ifdef USE_POWER_PINS
            .DVDD   (VDD),
            .DVSS   (VSS),
            .VSS    (VSS)
            `endif
        );
    end
    
    for (genvar i=0; i<NUM_DVSS_PADS; i++) begin : dvss_pads
        (* keep *)
        gf180mcu_ws_io__dvss pad (
            `ifdef USE_POWER_PINS
            .DVDD   (VDD),
            .DVSS   (VSS),
            .VDD    (VDD)
            `endif
        );
    end
    endgenerate

    // Signal IO pad instances

    // Schmitt trigger
    (* keep *)
    gf180mcu_fd_io__in_s clk1_pad (
        `ifdef USE_POWER_PINS
        .DVDD   (VDD),
        .DVSS   (VSS),
        .VDD    (VDD),
        .VSS    (VSS),
        `endif
    
        .Y      (clk1_PAD2CORE),
        .PAD    (clk1_PAD),
        
        .PU     (),
        .PD     ()
    );

    (* keep *)
    gf180mcu_fd_io__in_s clk2_pad (
        `ifdef USE_POWER_PINS
        .DVDD   (VDD),
        .DVSS   (VSS),
        .VDD    (VDD),
        .VSS    (VSS),
        `endif
    
        .Y      (clk2_PAD2CORE),
        .PAD    (clk2_PAD),
        
        .PU     (),
        .PD     ()
    );

    (* keep *)
    gf180mcu_fd_io__in_s clk3_pad (
        `ifdef USE_POWER_PINS
        .DVDD   (VDD),
        .DVSS   (VSS),
        .VDD    (VDD),
        .VSS    (VSS),
        `endif

        .Y      (clk3_PAD2CORE),
        .PAD    (clk3_PAD),
        
        .PU     (),
        .PD     ()
    );

    (* keep *)
    gf180mcu_fd_io__in_s clk3_b_pad (
        `ifdef USE_POWER_PINS
        .DVDD   (VDD),
        .DVSS   (VSS),
        .VDD    (VDD),
        .VSS    (VSS),
        `endif
    
        .Y      (clk3_b_PAD2CORE),
        .PAD    (clk3_b_PAD),
        
        .PU     (),
        .PD     ()
    );

    (* keep *)
    gf180mcu_fd_io__in_s spi_clk0_pad (
        `ifdef USE_POWER_PINS
        .DVDD   (VDD),
        .DVSS   (VSS),
        .VDD    (VDD),
        .VSS    (VSS),
        `endif
    
        .Y      (spi_clk0_PAD2CORE),
        .PAD    (spi_clk0_PAD),
        
        .PU     (),
        .PD     ()
    );

    (* keep *)
    gf180mcu_fd_io__in_s spi_clk1_pad (
        `ifdef USE_POWER_PINS
        .DVDD   (VDD),
        .DVSS   (VSS),
        .VDD    (VDD),
        .VSS    (VSS),
        `endif
    
        .Y      (spi_clk1_PAD2CORE),
        .PAD    (spi_clk1_PAD),
        
        .PU     (),
        .PD     ()
    );

    (* keep *)
    gf180mcu_fd_io__in_s spi_clk2_pad (
        `ifdef USE_POWER_PINS
        .DVDD   (VDD),
        .DVSS   (VSS),
        .VDD    (VDD),
        .VSS    (VSS),
        `endif
    
        .Y      (spi_clk2_PAD2CORE),
        .PAD    (spi_clk2_PAD),
        
        .PU     (),
        .PD     ()
    );
    
    // Normal input
    (* keep *)
    gf180mcu_fd_io__in_c wrst_n1_pad (
        `ifdef USE_POWER_PINS
        .DVDD   (VDD),
        .DVSS   (VSS),
        .VDD    (VDD),
        .VSS    (VSS),
        `endif
    
        .Y      (wrst_n1_PAD2CORE),
        .PAD    (wrst_n1_PAD),
        
        .PU     (),
        .PD     ()
    );

    (* keep *)
    gf180mcu_fd_io__in_c rrst_n1_pad (
        `ifdef USE_POWER_PINS
        .DVDD   (VDD),
        .DVSS   (VSS),
        .VDD    (VDD),
        .VSS    (VSS),
        `endif
    
        .Y      (rrst_n1_PAD2CORE),
        .PAD    (rrst_n1_PAD),
        
        .PU     (),
        .PD     ()
    );

    (* keep *)
    gf180mcu_fd_io__in_c rst_n2_pad (
        `ifdef USE_POWER_PINS
        .DVDD   (VDD),
        .DVSS   (VSS),
        .VDD    (VDD),
        .VSS    (VSS),
        `endif
    
        .Y      (rst_n2_PAD2CORE),
        .PAD    (rst_n2_PAD),
        
        .PU     (),
        .PD     ()
    );

    (* keep *)
    gf180mcu_fd_io__in_c rst_n3_pad (
        `ifdef USE_POWER_PINS
        .DVDD   (VDD),
        .DVSS   (VSS),
        .VDD    (VDD),
        .VSS    (VSS),
        `endif
    
        .Y      (rst_n3_PAD2CORE),
        .PAD    (rst_n3_PAD),
        
        .PU     (),
        .PD     ()
    );

    generate
    for (genvar i=0; i<NUM_INPUT_PADS; i++) begin : inputs
        (* keep *)
        gf180mcu_fd_io__in_c pad (
            `ifdef USE_POWER_PINS
            .DVDD   (VDD),
            .DVSS   (VSS),
            .VDD    (VDD),
            .VSS    (VSS),
            `endif
        
            .Y      (input_PAD2CORE[i]),
            .PAD    (input_PAD[i]),
            
            .PU     (),
            .PD     ()
        );
    end
    endgenerate

    generate
    for (genvar i=0; i<NUM_UNUSED_PADS; i++) begin : unused
        (* keep *)
        gf180mcu_fd_io__in_c pad (
            `ifdef USE_POWER_PINS
            .DVDD   (VDD),
            .DVSS   (VSS),
            .VDD    (VDD),
            .VSS    (VSS),
            `endif
        
            .Y      (_unused_PAD2CORE[i]),
            .PAD    (unused_PAD[i]),
            
            .PU     (),
            .PD     ()
        );
    end
    endgenerate

    generate
    for (genvar i=0; i<NUM_BIDIR_PADS; i++) begin : bidir
        (* keep *)
        gf180mcu_fd_io__bi_24t pad (
            `ifdef USE_POWER_PINS
            .DVDD   (VDD),
            .DVSS   (VSS),
            .VDD    (VDD),
            .VSS    (VSS),
            `endif
        
            .A      (),
            .OE     (),
            .Y      (bidir_PAD2CORE[i]),
            .PAD    (bidir_PAD[i]),
            
            .CS     (),
            .SL     (),
            .IE     (),

            .PU     (),
            .PD     ()
        );
    end
    endgenerate

    generate
    for (genvar i=0; i<NUM_ANALOG_PADS; i++) begin : analog
        (* keep *)
        gf180mcu_fd_io__asig_5p0 pad (
            `ifdef USE_POWER_PINS
            .DVDD   (VDD),
            .DVSS   (VSS),
            .VDD    (VDD),
            .VSS    (VSS),
            `endif
            .ASIG5V (analog_PAD[i])
        );
    end
    endgenerate

    // Core design

    // chip_core #(
    //     .NUM_INPUT_PADS  (NUM_INPUT_PADS),
    //     .NUM_BIDIR_PADS  (NUM_BIDIR_PADS),
    //     .NUM_ANALOG_PADS (NUM_ANALOG_PADS)
    // ) i_chip_core (
    //     `ifdef USE_POWER_PINS
    //     .VDD        (VDD),
    //     .VSS        (VSS),
    //     `endif
    
    //     .clk1        (clk1_PAD2CORE),
    //     .rst_n1      (rst_n1_PAD2CORE),

    //     .clk2        (clk2_PAD2CORE),
    //     .rst_n2      (rst_n2_PAD2CORE),

    //     .clk3        (clk3_PAD2CORE),
    //     .clk3_b      (clk3_b_PAD2CORE),
    //     .rst_n3      (rst_n3_PAD2CORE),
    
    //     .input_in   (input_PAD2CORE),
    //     .input_pu   (input_CORE2PAD_PU),
    //     .input_pd   (input_CORE2PAD_PD),

    //     .bidir_in   (bidir_PAD2CORE),
    //     .bidir_out  (bidir_CORE2PAD),
    //     .bidir_oe   (bidir_CORE2PAD_OE),
    //     .bidir_cs   (bidir_CORE2PAD_CS),
    //     .bidir_sl   (bidir_CORE2PAD_SL),
    //     .bidir_ie   (bidir_CORE2PAD_IE),
    //     .bidir_pu   (bidir_CORE2PAD_PU),
    //     .bidir_pd   (bidir_CORE2PAD_PD),
        
    //     .analog     (analog_PAD)
    // );
    
    // Chip ID - do not remove, necessary for tapeout
    (* keep *)
    gf180mcu_ws_ip__id chip_id ();
    
    // wafer.space logo - can be removed
    (* keep *)
    gf180mcu_ws_ip__logo wafer_space_logo ();

endmodule

`default_nettype wire
