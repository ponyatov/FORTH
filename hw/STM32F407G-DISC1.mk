CPU     = STM32F407VGT6
BSP     = ref/stm32f4discovery-bsp
CE      += $(wildcard $(BSP)/*.c*)
HE      += $(wildcard $(BSP)/*.h*)
TCFLAGS += -I$(BSP)
REF     += $(BSP)/README.md

$(BSP)/README.md:
	$(GITREF) -b main git@github.com:ponyatov/stm32f4discovery-bsp.git $(dir $@)
