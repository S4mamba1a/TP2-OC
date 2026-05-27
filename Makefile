
# Configurações do montador (TP1)
CC       = gcc
CFLAGS   = -Wall -I montador/headers
SRCS     = montador/arquivo_principal/main.c \
           montador/sources/instrucoes.c \
           montador/sources/dicionario.c
MONTADOR = montador/montador

# Arquivos do projeto
ASM      = asm/programa.asm
INST_OUT = init/inst_init.txt

# Arquivos Verilog
MODULOS  = modulos/alu.v \
           modulos/alu_control.v \
           modulos/control.v \
           modulos/data_memory.v \
           modulos/imm_gen.v \
           modulos/instruction_memory.v \
           modulos/register_file.v \
           modulos/top_level.v
TB       = simulacao/testbench.v
SIM_BIN  = simulacao/simulacao


# Alvo padrão: faz tudo
all: montar compilar simular

# Compila o montador do TP1
$(MONTADOR): $(SRCS)
	$(CC) $(CFLAGS) $(SRCS) -o $(MONTADOR)

# Roda o montador para gerar o inst_init.txt
montar: $(MONTADOR)
	$(MONTADOR) $(ASM) -o $(INST_OUT)

# Compila todos os arquivos Verilog com o iverilog
compilar:
	iverilog -o $(SIM_BIN) $(TB) $(MODULOS)

# Roda a simulação a partir da pasta init/
# (o $readmemb dos módulos procura os .txt no diretório atual)
simular:
	cd init && vvp ../$(SIM_BIN)

# Limpa os arquivos gerados
clean:
	rm -f $(MONTADOR) $(INST_OUT) $(SIM_BIN)