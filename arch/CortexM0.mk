include arch/CortexM.mk
TCFLAGS += -mthumb -mcpu=cortex-m0

STM32CubeF0_VER = 1.11.5
STM32CubeF0_GZ  = STM32CubeF0_$(STM32CubeF0_VER).zip
REF += $(GZ)/$(STM32CubeF0_GZ)
$(GZ)/$(STM32CubeF0_GZ):
	$(CURL) $@ https://github.com/STMicroelectronics/STM32CubeF0/archive/refs/tags/v$(STM32CubeF0_VER).zip

# REF += ref/STM32CubeF0/README.md
# ref/STM32CubeF0/README.md:
# 	$(GITREF) -o gh -b master --depth 1 https://github.com/STMicroelectronics/STM32CubeF0.git $(dir $@)

# REF += ref/stm32f10x-stdperiph-lib/Release_Notes.html
# ref/stm32f10x-stdperiph-lib/Release_Notes.html:
# 	$(GITREF) -o gh git@github.com:ponyatov/stm32f10x-stdperiph-lib.git $(dir $@)

REF += ref/cmsis-device-f0/README.md
ref/cmsis-device-f0/README.md:
	$(GITREF) -o gh git@github.com:ponyatov/cmsis-device-f0.git $(dir $@)

REF += ref/stm32f0xx-hal-driver/README.md
ref/stm32f0xx-hal-driver/README.md:
	$(GITREF) -o gh git@github.com:ponyatov/stm32f0xx-hal-driver.git $(dir $@)

CMSIS    = ref/cmsis-device-f0/Source/Templates/gcc
TCFLAGS += -I$(CMSIS)
HE      += $(wildcard $(CMSIS)/*.h*)

HAL      = ref/stm32f0xx-hal-driver/Inc
TCFLAGS += -I$(HAL)
HE      += $(wildcard $(HAL)/*.h*)
