#include "dicionario.h"

// Dicionário preenchido com as instruções suportadas pelo projeto
Instrucao dicionario[] = {
    // grupo 15
    {"lw",   'I', OP_LW, F3_LW_SW,   0x00}, 
    {"sw",   'S', OP_SW, F3_LW_SW,   0x00}, 
    {"add",  'R', OP_R,  F3_ADD_SUB_ADDI, F7_STD},
    {"xor",  'R', OP_R,  F3_XOR,  F7_STD},
    {"addi", 'I', OP_I,  F3_ADD_SUB_ADDI, 0x00},
    {"sll",  'R', OP_R,  F3_SLL,  F7_STD},
    {"bne",  'B', OP_B,  F3_BNE,  0x00},
    // extras 
    {"sub",  'R', OP_R,  F3_ADD_SUB_ADDI, F7_SUB},
    {"and",  'R', OP_R,  F3_AND_ANDI, F7_STD},
    {"or",   'R', OP_R,  F3_OR_ORI,   F7_STD},
    {"srl",  'R', OP_R,  F3_SRL,  F7_STD},
    {"andi", 'I', OP_I,  F3_AND_ANDI, 0x00},
    {"ori",  'I', OP_I,  F3_OR_ORI,   0x00},
    {"beq",  'B', OP_B,  F3_BEQ,  0x00}
};