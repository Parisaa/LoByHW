module LolaP
#(nr_rounds = 8)
(
    input [256:0] LolaP_i,
    output [256:0] LolaP_o
);

wire[256:0] round_i_s [(nr_rounds-1):0];
wire[256:0] round_o_s [(nr_rounds-1):0];

genvar i;
generate
    for (i=0; i<nr_rounds; i=i+1) begin: LolaP_round_n
        if (r == 1 || r == 3 || r == 4 || r == 7 || r == 8) begin
            LolaP_round_w LolaP_round_w_ins(
                .round_i(round_i_s[i]),
                .round_o(round_o_s[i])
            );
        end else begin
            LolaP_round_wo LolaP_round_wo_ins(
                .round_i(round_i_s[i]),
                .round_o(round_o_s[i])
            );
        end
    end 
endgenerate

assign round_i_s[0] = LolaP_i;


genvar j;
generate
    for (j=1; j<nr_rounds; j=j+1) begin : chainrounds
        assign round_i_s[j] = round_o_s[j-1];
    end 
endgenerate

assign LolaP_o = round_o_s[nr_rounds-1];
endmodule

