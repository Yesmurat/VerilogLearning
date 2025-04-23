//4 by 1 Multiplexer
module mux (
    input wire I0, input wire I1, input wire I2, input wire I3,
    input wire S1, input wire S0,
    output wire Y
);
    
wire first_and, second_and, third_and, fourth_and;

assign first_and = I0 & (~S1) & (~S0);
assign second_and = I1 & (~S1) & S0;
assign third_and = I2 & S1 & (~S0);
assign fourth_and = I3 & S1 & S0;

assign Y = first_and | second_and | third_and | fourth_and;

endmodule

// Behavioral Logic
module muxbehavioral (
    input wire I0, input wire I1, input wire I2, input wire I3,
    input wire S1, input wire S0,
    output reg Y
);

always @(*)
    begin
        if (~S1 && ~S0)
            Y = I0;
        else if (~S1 && S0)
            Y = I1;
        else if (S1 && ~S0)
            Y = I2;
        else
            Y = I3;
    end

endmodule