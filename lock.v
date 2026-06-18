module lock(
    input clk,
    input rst,
    input [2:0] btn,
    output led_open,
    output led_error
);
localparam STATE_IDLE = 3'b000;
localparam STATE_NUM1 = 3'b001;
localparam STATE_NUM3 = 3'b010;
localparam STATE_OPEN = 3'b011;
localparam STATE_ERROR = 3'b100;
reg[2:0] current_state;
reg[2:0] next_state;

always @(posedge clk or posedge rst) begin
    if (rst)
    current_state <= STATE_IDLE;
    else
    current_state <= next_state;
end 

always @(*) begin
    next_state = current_state;
    case(current_state)
    STATE_IDLE : begin
        if (btn[0])
        next_state = STATE_NUM1;
        else if (btn[1] || btn[2])
        next_state = STATE_ERROR;
    end
    STATE_NUM1 : begin
        if (btn[1])
        next_state = STATE_NUM3;
        else if (btn[0] || btn[2])
        next_state = STATE_ERROR;
    end
    STATE_NUM3 : begin
        if (btn[2])
        next_state = STATE_OPEN;
        else if (btn[0] || btn[1])
        next_state = STATE_ERROR;
    end
    STATE_OPEN: begin
        next_state = STATE_OPEN;
    end
    STATE_ERROR: begin
        next_state = STATE_ERROR;
    end
    default: begin
        next_state = STATE_IDLE;
    end
    endcase
end

assign led_open = (current_state == STATE_OPEN);
assign led_error = (current_state == STATE_ERROR);

endmodule