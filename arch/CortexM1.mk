include arch/CortexM.mk
TCFLAGS += -march=armv7-m -mthumb

STM32CubeF1_VER = 1.8.6
STM32CubeF1_GZ  = STM32CubeF1_$(STM32CubeF1_VER).zip
REF += $(GZ)/$(STM32CubeF1_GZ)
$(GZ)/$(STM32CubeF1_GZ):
	$(CURL) $@ https://github.com/STMicroelectronics/STM32CubeF1/archive/refs/tags/v$(STM32CubeF1_VER).zip

REF += ref/STM32CubeF1/README.md
ref/STM32CubeF1/README.md:
	$(GITREF) -o gh -b master --depth 1 https://github.com/STMicroelectronics/STM32CubeF1.git $(dir $@)

REF += ref/stm32f10x-stdperiph-lib/Release_Notes.html
ref/stm32f10x-stdperiph-lib/Release_Notes.html:
	$(GITREF) -o gh git@github.com:ponyatov/stm32f10x-stdperiph-lib.git $(dir $@)

REF += ref/cmsis-device-f1/README.md
ref/cmsis-device-f1/README.md:
	$(GITREF) -o gh git@github.com:ponyatov/cmsis-device-f1.git $(dir $@)

# REF += ref/stm32f4xx-hal-driver/README.md
# ref/stm32f4xx-hal-driver/README.md:
# 	$(GITREF) -o gh git@github.com:ponyatov/stm32f4xx-hal-driver.git $(dir $@)

# CMSIS    = ref/cmsis-device-f4/Source/Templates/gcc
# TCFLAGS += -I$(CMSIS)
# HE      += $(wildcard $(CMSIS)/*.h*)

# HAL      = ref/stm32f4xx-hal-driver/Inc
# TCFLAGS += -I$(HAL)
# HE      += $(wildcard $(HAL)/*.h*)
