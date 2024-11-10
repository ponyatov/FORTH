include arch/CortexM.mk

REF += ref/STM32CubeF4/README.md
ref/STM32CubeF4/README.md:
	$(GITREF) -o gh -b master --depth 1 https://github.com/STMicroelectronics/STM32CubeF4.git $(dir $@)

STM32CubeF4_VER = 1.28.1
STM32CubeF4_GZ  = STM32CubeF4_$(STM32CubeF4_VER).zip
REF += $(GZ)/$(STM32CubeF4_GZ)
$(GZ)/$(STM32CubeF4_GZ):
	$(CURL) $@ https://github.com/STMicroelectronics/STM32CubeF4/archive/refs/tags/v$(STM32CubeF4_VER).zip

REF += ref/STM32F4xx_DSP_StdPeriph_Lib/Release_Notes.html
ref/STM32F4xx_DSP_StdPeriph_Lib/Release_Notes.html:
	$(GITREF) -o gh git@github.com:ponyatov/STM32F4xx_DSP_StdPeriph_Lib.git $(dir $@)

REF += ref/cmsis-device-f4/README.md
ref/cmsis-device-f4/README.md:
	$(GITREF) -o gh git@github.com:ponyatov/cmsis-device-f4.git $(dir $@)

REF += ref/stm32f4xx-hal-driver/README.md
ref/stm32f4xx-hal-driver/README.md:
	$(GITREF) -o gh git@github.com:ponyatov/stm32f4xx-hal-driver.git $(dir $@)

CMSIS    = ref/cmsis-device-f4/Source/Templates/gcc
TCFLAGS += -I$(CMSIS)
HE      += $(wildcard $(CMSIS)/*.h*)

HAL      = ref/stm32f4xx-hal-driver/Inc
TCFLAGS += -I$(HAL)
HE      += $(wildcard $(HAL)/*.h*)
