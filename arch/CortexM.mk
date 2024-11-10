TARGET   = arm-none-eabi
TCFLAGS += -march=armv7 -mthumb 

REF += ref/stm32-bsp-common/README.md
ref/stm32-bsp-common/README.md:
	$(GITREF) -o gh -b main git@github.com:ponyatov/stm32-bsp-common.git $(dir $@)
