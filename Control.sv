//activeaza si dezactiveaza functionalitatile blocurilor din arhitectura in functie de opcode
module Control
(
	input [5:0] op,	  	// intrare de date (opcode)
	output reg RegDst, 	// iesiri de date
	output reg RegWrite,
	output reg Branch, 
	output reg Jump,
	output reg MemRead,
	output reg MemToReg,
	output reg[1:0] ALUOp,
	output reg ALUSrc, 
	output reg MemWrite
);
    
always@(op)
    case(op)
		// pentru opcede-ul 000000 (instructiuni de tip R) modeleaza datele la iesire  // Instructiunile de tip R sunt diferentiate prin func
        0 : begin    //addu si subu
                RegDst = 1;
                ALUOp = 2'b11;
                RegWrite = 1;
                Jump = 0;
                Branch = 0;
                MemRead = 0;
                MemToReg = 0;
                MemWrite = 0;
                ALUSrc = 0;
			end	  
		// pentru opcede-ul 000010 (instructiuni de tip J) modeleaza datele la iesire
        2 : begin     // j = jump
                RegDst = 0;
                ALUOp = 2'b00;
                RegWrite = 0;
                Jump = 1;
                Branch = 0;
                MemRead = 0;
                MemToReg = 0;
                MemWrite = 0;
                ALUSrc = 0;
			 end	 
		// pentru opcede-ul 000110 (instructiune de tip I) modeleaza datele la iesire pentru BEQ
        6 : begin    // beq
                RegDst = 0;
                ALUOp = 2'b01;
                RegWrite = 0;
                Jump = 0;
                Branch = 1;
                MemRead = 0;
                MemToReg = 0;
                MemWrite = 0;
                ALUSrc = 0;
			end
		// pentru opcede-ul 000111 (instructiune de tip I) modeleaza datele la iesire pentru BNE
        7 : begin    // bne
                RegDst = 0;
                ALUOp = 2'b10;
                RegWrite = 0;
                Jump = 0;
                Branch = 1;
                MemRead = 0;
                MemToReg = 0;
                MemWrite = 0;
                ALUSrc = 0;
			end	  
		// pentru opcede-ul 000100 (instructiune de tip I) modeleaza datele la iesire pentru LW 
	    // (load-> incarcarea datelor de la o adresa din data memory intr-un registru)
        4 : begin  // lw
                RegDst = 0;
                ALUOp = 2'b00;
                RegWrite = 1;
                Jump = 0;
                Branch = 0;
                MemRead = 1;
                MemToReg = 1;
                MemWrite = 0;
                ALUSrc = 1;
			end	
		// pentru opcede-ul 000101 (instructiune de tip I) modeleaza datele la iesire pentru SW 
	    // ( incarcarea datelor dintr-un registru la o adresa din data memory )
        5 : begin  // sw
                RegDst = 0;
                ALUOp = 2'b00;
                RegWrite = 0;
                Jump = 0;
                Branch = 0;
                MemRead = 0;
                MemToReg = 0;
                MemWrite = 1;
                ALUSrc = 1;
			end	
		// modelarea datelor la iesire in cazul unui opcode necunoscut
        default : begin 
                RegDst = 0;
                ALUOp = 2'b00;
                RegWrite = 0;
                Jump = 0;
                Branch = 0;
                MemRead = 0;
                MemToReg = 0;
                MemWrite = 0;
                ALUSrc = 0;
            end
    endcase	 
	
endmodule
