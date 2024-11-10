# var
MODULE = $(notdir $(CURDIR))

# cross
HWINFO = tmp/hw.info
ifneq (,$(wildcard $(HWINFO)))
	include  $(HWINFO)
	include   hw/$(DESCR)_$(CHIPID).mk
	include   hw/$(HW).mk
	include  cpu/$(CPU).mk
	include arch/$(ARCH).mk
else
$(HWINFO): install
	echo "STVER  = $(shell st-info --version)"  > $@
	echo "FLASH  = $(shell st-info --flash  )" >> $@
	echo "SRAM   = $(shell st-info --sram   )" >> $@
	echo "SERIAL = $(shell st-info --serial )" >> $@
	echo "CHIPID = $(shell st-info --chipid )" >> $@
	echo "DESCR  = $(shell st-info --descr  )" >> $@
endif

# dir
CWD = $(CURDIR)
ifneq (,$(wildcard $(HOME)/distr/STM32))
GZ = $(HOME)/distr/STM32
else ifneq (,$(wildcard $(HOME)/gz))
GZ = $(HOME)/gz
endif

# tool
CURL   = curl -L -o
GITREF = git clone -o gh
CF     = clang-format -style=file -i
TCC    = $(TARGET)-gcc
TDUMP  = $(TARGET)-objdump

# src
C += $(wildcard src/*.c*)
H += $(wildcard inc/*.h*)

OBJ += $(subst .c,.o,$(subst src/,tmp/,$(C)))
OBJ += $(subst .c,.o,$(subst $(BSP)/,tmp/,$(CE)))

# cfg
TCFLAGS += -Iinc -Itmp -O0 -ggdb -std=gnu99
TCFLAGS += -DFLASH=$(FLASH) -DSRAM=$(SRAM) -DSERIAL=$(SERIAL)
TCFLAGS += -DHW=$(HW) -DCPU=$(CPU) -DARCH=$(ARCH)

# all
.PHONY: all FORTH
all: bin/$(MODULE).elf
FORTH: all

# format
.PHONY: format
format: /tmp/format_cpp
/tmp/format_cpp: $(C) $(H)
	$(CF) $? && touch $@

# rule
bin/$(MODULE).elf: $(OBJ)
	$(TCC) $(TCFLAGS) -o $@ $^
	$(TDUMP) -x $@ > $@.dump
	$(TCOPY) -O binary $@ $(subst .bin,.bin,$@)
	$(TCOPY) -O ihex   $@ $(subst .bin,.hex,$@)
tmp/%.o: src/%.c $(H) $(HE)
	$(TCC) $(TCFLAGS) -o $@ -c $<
	$(TDUMP) -x $@ > $@.dump
# original/patched STMicro libs
tmp/%.o: $(CMSIS_T)/%.s $(H) $(HE)
	$(TCC) $(TCFLAGS) -o $@ -c $<
	$(TDUMP) -x $@ > $@.dump
tmp/%.o: $(BSP)/%.c $(H) $(HE)
	$(TCC) $(TCFLAGS) -o $@ -c $<
	$(TDUMP) -x $@ > $@.dump

# doc
.PHONY: doxy
doxy: .doxygen
	rm -rf doc/html ; git checkout doc/html
	doxygen $< 1>/dev/null

# install
OS     = $(shell lsb_release -si)
OS_VER = $(shell lsb_release -sr)
.PHONY: install update ref gz
install: ref gz
	$(MAKE) update
ifeq ($(OS),Debian)
update:
	sudo apt update
	sudo apt install -uy `cat apt.$(OS)$(OS_VER)`
endif
ref: $(REF)
gz:
