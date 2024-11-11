CPU     = STM32F407VGT6
BSP     = ref/stm32f7discovery-bsp

REF += ref/stm32f7-discovery-blinky/README.md
ref/stm32f7-discovery-blinky/README.md:
	$(GITREF) git@github.com:ponyatov/stm32f7-discovery-blinky.git $(dir $@)
