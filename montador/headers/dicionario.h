#ifndef DICIONARIO_H
#define DICIONARIO_H

// Definições de Opcodes 
#define OP_R    0x33  // add, sub, and, or, xor, sll, srl
#define OP_I    0x13  // addi, andi, ori
#define OP_LW   0x03  // lw
#define OP_SW   0x23  // sw
#define OP_B    0x63  // beq, bne

// Definições de funct3 
#define F3_ADD_SUB_ADDI 0x0
#define F3_SLL          0x1
#define F3_SRL          0x5
#define F3_XOR          0x4
#define F3_OR_ORI       0x6
#define F3_AND_ANDI      0x7
#define F3_LW_SW        0x2
#define F3_BEQ          0x0
#define F3_BNE          0x1

// Definições de funct7 
#define F7_STD  0x00  // Padrão para a maioria das Tipo R
#define F7_SUB  0x20  // Especial para a instrução sub

// Estrutura para armazenar as informações de cada instrução
typedef struct {
    char *nome;
    char tipo; // R, I, S, B
    int opcode;
    int funct3;
    int funct7;
} Instrucao;

// Declaração do dicionário de instruções
extern Instrucao dicionario[];

#define TAM_DICIONARIO 14 

#endif // DICIONARIO_H