/*
Finite State Machine
Moore Machine
Detect Sequence 1011 (no overlap)
*/
module moore (
    input wire x, input wire CLK,
    output reg F
);

reg A, B, C; // State registers
reg Astar, Bstar, Cstar; // Next state logic

// Next state logic block (combinational)
always @(*) begin
       Astar = x & B & C;
       Bstar = (~x & C) | (x & B & ~C);
       Cstar = (x & ~B) | (x & ~C);
    end

// State update block (sequential) based on the current state
always @(posedge CLK) begin
    A <= Astar;
    B <= Bstar;
    C <= Cstar;
end

// Output logic (Moore: depends only on state)
always @(*) begin
    F = A;
end

endmodule