// 2 by 1 MUX
module MUX (
    input wire I0, input wire I1, input wire S,
    output reg Y
);

always @(*)
    begin
        if (S)
            Y = I1;
        else
            Y = I0;
    end

endmodule