CPU = STM32F746NGH6

REF += ref/stm32f7-discovery-blinky/README.md
ref/stm32f7-discovery-blinky/README.md:
	$(GITREF) git@github.com:ponyatov/stm32f7-discovery-blinky.git $(dir $@)

REF += ref/32f746gdiscovery-bsp/README.md
ref/32f746gdiscovery-bsp/README.md:
	$(GITREF) git@github.com:ponyatov/32f746gdiscovery-bsp.git
BSP = ref/32f746gdiscovery-bsp
