module EVM(
    input clk,
    input reset,
    input mode,                   // Mode switch: 0 = voting, 1 = display
    input [3:0] candid_button,
    output reg [3:0] vot_logged,
    output reg valid_vote,
    output reg invalid_vote,
   // output reg [7:0] counter_candid1,
  //  output reg [7:0] counter_candid2,
  //  output reg [7:0] counter_candid3,
   // output reg [7:0] counter_candid4,
    output reg [7:0] display_out  // 8-bit display output for vote count
);

    integer i;
    reg [2:0] button_count;
    reg [7:0] counter_candid1, counter_candid2, counter_candid3, counter_candid4,counter_total_valid,counter_total_Invalid;
    reg [3:0] candid_button_prev;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            vot_logged      <= 4'b0000;
            valid_vote      <= 0;
            invalid_vote    <= 0;
            counter_candid1 <= 0;
            counter_candid2 <= 0;
            counter_candid3 <= 0;
            counter_candid4 <= 0;
            counter_total_valid <= 0;
            counter_total_Invalid <= 0;
            display_out     <= 8'b00000000;
            candid_button_prev <= 4'b0000;
        end else begin
            if (mode == 0) begin
                // Voting mode
                button_count = 0;
                for (i = 0; i < 4; i = i + 1) begin
                    if (candid_button[i])
                        button_count = button_count + 1;
                end

                if (button_count == 1) begin
                counter_total_valid <= counter_total_valid + 1;
                    case (candid_button)
                        4'b0001: if (~candid_button_prev[0] & candid_button[0]) begin vot_logged <= 4'b0001; counter_candid1 <= counter_candid1 + 1; end
                        4'b0010: if (~candid_button_prev[1] & candid_button[1]) begin vot_logged <= 4'b0010; counter_candid2 <= counter_candid2 + 1; end
                        4'b0100: if (~candid_button_prev[2] & candid_button[2]) begin vot_logged <= 4'b0100; counter_candid3 <= counter_candid3 + 1; end
                        4'b1000: if (~candid_button_prev[3] & candid_button[3]) begin vot_logged <= 4'b1000; counter_candid4 <= counter_candid4 + 1; end
                        default: vot_logged <= 4'b0000;
                    endcase
                    valid_vote   <= 1;
                    invalid_vote <= 0;
                end else begin
                    vot_logged   <= 4'b0000;
                    valid_vote   <= 0;
                    invalid_vote <= (button_count > 1) ? 1 : 0;
                    if(invalid_vote)counter_total_Invalid <= counter_total_Invalid + 1;
                end
                // Clear display output in voting mode
                display_out <= 8'b00000000;

            end else begin
                // Display mode - show candidate counts
                case (candid_button)
                    4'b1001: display_out <= counter_total_valid;
                    4'b1010: display_out <= counter_total_Invalid;
                    4'b0001: display_out <= counter_candid1;
                    4'b0010: display_out <= counter_candid2;
                    4'b0100: display_out <= counter_candid3;
                    4'b1000: display_out <= counter_candid4;
                    default: display_out <= 8'b00000000; // None or multiple pressed
                endcase
                valid_vote   <= 0;
                invalid_vote <= 0;
                vot_logged   <= 4'b0000;
            end
            candid_button_prev <= candid_button;
        end
    end

endmodule