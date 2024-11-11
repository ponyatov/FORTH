ARCH = CortexM7

OBJ += tmp/startup_stm32f746xx.o

TCFLAGS += -DSTM32F746xx

TCFLAGS += -Iref/Components
