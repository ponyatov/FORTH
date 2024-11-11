ARCH = CortexM4

OBJ += tmp/startup_stm32f407xx.o

TCFLAGS += -DSTM32F407xx

REF += ref/Components/lis302dl/README.md
ref/Components/lis302dl/README.md:
	$(GITREF) git@github.com:ponyatov/stm32-lis302dl.git $(dir $@)

TCFLAGS += -Iref/Components
