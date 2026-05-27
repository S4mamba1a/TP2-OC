#ifndef INSTRUCOES_H
#define INSTRUCOES_H

#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include "dicionario.h"


// Struct para a tabela de rótulos 
typedef struct {
    char nome[50];
    int endereco;
} Rotulo;

// Funções para gerenciar a tabela de rótulos
void adicionar_rotulo(const char* nome, int endereco);
int buscar_rotulo(const char* nome);

// Função auxiliar encapsulada para extrair números de registradores/imediatos
int extrair_numero(const char *str);

// Função de busca interna
Instrucao* IIdentificaInstrucao(const char *nome);

// Retorna o caractere do tipo da instrução ('R', 'I', 'S' ou 'B') ou '\0' se não encontrar
char IdentificaInstrucao(const char *nome);

// Formato R
uint32_t montar_tipo_R(int opcode, int rd, int funct3, int rs1, int rs2, int funct7);

// Formato I
uint32_t montar_tipo_I(int opcode, int rd, int funct3, int rs1, int imediato);

// Formato S
uint32_t montar_tipo_S(int opcode, int funct3, int rs1, int rs2, int imediato);

// Formato B
uint32_t montar_tipo_B(int opcode, int funct3, int rs1, int rs2, int imediato);

#endif // INSTRUCOES_H