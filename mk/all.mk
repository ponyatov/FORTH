.PHONY: all run
all: $(BIN)/$(BINFILE) $(F)
run: $(BIN)/$(BINFILE) $(F)
	$^
