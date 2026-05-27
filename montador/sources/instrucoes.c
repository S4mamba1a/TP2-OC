#include "instrucoes.h"
#include <string.h>
#include <stdio.h>

// Gerenciamento da tabela de rótulos
Rotulo tabela_rotulos[100];
int total_rotulos = 0;

void adicionar_rotulo(const char* nome, int endereco) {
    strcpy(tabela_rotulos[total_rotulos].nome, nome);
    tabela_rotulos[total_rotulos].endereco = endereco;
    total_rotulos++;
}

int buscar_rotulo(const char* nome) {
    for (int i = 0; i < total_rotulos; i++) {
        if (strcmp(nome, tabela_rotulos[i].nome) == 0) {
            return tabela_rotulos[i].endereco;
        }
    }
    return -1;
}

// Implementação da função de extrair números
int extrair_numero(const char *str) {
    if (str == NULL) {
        return 0;
    }

    // Criamos um ponteiro que aponta para o início da string
    const char *inicio = str;

    // Se a string começar com 'x' ou 'X'
    if (str[0] == 'x' || str[0] == 'X') {
        inicio = str + 1;
    }
    // O strtol converte o texto para um número inteiro longo.
    return (int)strtol(inicio, NULL, 0);
}

// Função de busca interna
Instrucao* IIdentificaInstrucao(const char *nome) {
    for (int i = 0; i < TAM_DICIONARIO; i++) {
        if (strcmp(nome, dicionario[i].nome) == 0) {
            return &dicionario[i];
        }
    }
    return NULL;
}

// Retorna o caractere do tipo da instrução ('R', 'I', 'S' ou 'B') ou '\0' se não encontrar
char IdentificaInstrucao(const char *nome) {
    Instrucao *inst = IIdentificaInstrucao(nome);
    if (inst == NULL) {
        return '\0';
    }
    return inst->tipo;
}

// Funções de Montagem de Bits

uint32_t montar_tipo_R(int opcode, int rd, int funct3, int rs1, int rs2, int funct7) {
    uint32_t instrucao = 0;
    instrucao |= (opcode & 0x7F);
    instrucao |= ((rd & 0x1F) << 7);
    instrucao |= ((funct3 & 0x07) << 12);
    instrucao |= ((rs1 & 0x1F) << 15);
    instrucao |= ((rs2 & 0x1F) << 20);
    instrucao |= ((funct7 & 0x7F) << 25);
    return instrucao;
}

uint32_t montar_tipo_I(int opcode, int rd, int funct3, int rs1, int imediato) {
    uint32_t instrucao = 0;
    instrucao |= (opcode & 0x7F);
    instrucao |= ((rd & 0x1F) << 7);
    instrucao |= ((funct3 & 0x07) << 12);
    instrucao |= ((rs1 & 0x1F) << 15);
    instrucao |= ((uint32_t)(imediato & 0xFFF) << 20); // Imediato de 12 bits
    return instrucao;
}

uint32_t montar_tipo_S(int opcode, int funct3, int rs1, int rs2, int imediato) {
    uint32_t instrucao = 0;
    uint32_t imm_4_0 = imediato & 0x1F;
    uint32_t imm_11_5 = ((uint32_t)(imediato >> 5)) & 0x7F;
    instrucao |= (opcode & 0x7F);
    instrucao |= ((uint32_t)(imm_4_0 << 7));
    instrucao |= ((funct3 & 0x07) << 12);
    instrucao |= ((rs1 & 0x1F) << 15);
    instrucao |= ((rs2 & 0x1F) << 20);
    instrucao |= ((uint32_t)(imm_11_5 << 25));
    return instrucao;
}

uint32_t montar_tipo_B(int opcode, int funct3, int rs1, int rs2, int imediato) {
    uint32_t instrucao = 0;
    uint32_t imm_11 = (imediato >> 11) & 0x01;
    uint32_t imm_4_1 = (imediato >> 1) & 0x0F;
    uint32_t imm_10_5 = (imediato >> 5) & 0x3F;
    uint32_t imm_12 = (imediato >> 12) & 0x01;
    instrucao |= (opcode & 0x7F);
    instrucao |= ((uint32_t)(imm_11 << 7));
    instrucao |= ((uint32_t)(imm_4_1 << 8));
    instrucao |= ((funct3 & 0x07) << 12);
    instrucao |= ((rs1 & 0x1F) << 15);
    instrucao |= ((rs2 & 0x1F) << 20);
    instrucao |= ((uint32_t)(imm_10_5 << 25));
    instrucao |= ((uint32_t)(imm_12 << 31));
    return instrucao;
}