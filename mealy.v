/*
Finite State Machine
Mealy Machine
Detect sequence 1011 (no overlap)
*/

module mealy (
    input wire x, input wire CLK,
    output reg F
);

reg A, B; // State registers
reg Astar, Bstar; // Next state logic

// Next state logic block (combinational)
always @(*) begin
       Astar = (~x & B) | (x & A & ~B);
       Bstar = (x & ~A) | (x & ~B);
    end

// State update block (sequential) based on the current state
always @(posedge CLK) begin
    A <= Astar;
    B <= Bstar;
end

// Output logic (Moore: depends only on state)
always @(*) begin
    F = x & A & B;
end

endmodule