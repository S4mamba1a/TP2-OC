# Grupo 15 - Teste do Caminho de Dados RISC-V
# Instrucoes: lw, sw, add, xor, addi, sll, bne
# Estado inicial: tudo zerado
# Resultado esperado: DataMemory[0] = 7

# Coloca o valor 7 na memoria via registrador
addi x1, x0, 7     # x1 = 7
sw x1, 4(x0)       # DataMemory[1] = 7

# Carrega de volta pra testar o lw
lw x1, 4(x0)       # x1 = 7
add x2, x1, x0     # x2 = 7 (copia)

# Testa ADD e ADDI
add x1, x1, x2     # x1 = 14
addi x1, x1, -7    # x1 = 7

# Testa XOR: 7 XOR 7 deve dar 0
xor x3, x1, x2     # x3 = 0

# Testa BNE (nao deve pular, pois x3 == x0 == 0)
bne x3, x0, ERRO

# Testa SLL e SW no caminho de sucesso
addi x4, x0, 1     # x4 = 1 (shift amount)
sll x1, x1, x4     # x1 = 7 << 1 = 14
addi x1, x1, -7    # x1 = 7
sw x1, 0(x0)       # DataMemory[0] = 7

# Testa BNE (deve pular, pois x4=1 != x0=0)
bne x4, x0, SAIDA

ERRO:
addi x1, x0, 99    # valor errado, so chega aqui se o processador falhar
sw x1, 0(x0)

SAIDA: