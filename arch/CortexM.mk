TARGET   = arm-none-eabi

REF += ref/stm32-bsp-common/README.md
ref/stm32-bsp-common/README.md:
	$(GITREF) -o gh -b main git@github.com:ponyatov/stm32-bsp-common.git $(dir $@)

REF += ref/cmsis-core/README.md
ref/cmsis-core/README.md:
	$(GITREF) -o gh -b master git@github.com:ponyatov/cmsis-core.git $(dir $@)

CMSIS_C  = ref/cmsis-core
TCFLAGS += -I$(CMSIS_C)/Include

TCFLAGS += -Iref/Components
