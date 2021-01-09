# \ <section:var>
MODULE     = $(notdir $(CURDIR))
OS        ?= $(shell uname -s | tr A-Z a-z)
NOW        = $(shell date +%d%m%y)
REL        = $(shell git rev-parse --short=4 HEAD)
# / <section:var>
# \ <section:dir>
CWD        = $(CURDIR)
BIN        = $(CWD)/bin
DOC        = $(CWD)/doc
TEX        = $(CWD)/tex
SRC        = $(CWD)/src
TMP        = $(CWD)/tmp
# / <section:dir>
# \ <section:tool>
WGET       = wget -c
PY         = $(BIN)/python3
PIP        = $(BIN)/pip3
PEP        = $(BIN)/autopep8
PYT        = $(BIN)/pytest
LATEX	   = pdflatex -halt-on-error -output-directory=$(TMP)
TCC        = tcc
CC         = gcc
CXX        = g++
HEX        = hexdump -C
# / <section:tool>
# \ <section:cfg>
CFLAGS += -O0 -g3
CFLAGS += -I.
# / <section:cfg>
# \ <section:obj>
P += $(MODULE).py
T += tex/main.tex tex/header.tex tex/bib.tex
T += tex/intro.tex tex/install.tex
T += tex/micro/micro.tex tex/micro/dstack.tex tex/micro/rstack.tex tex/micro/voc.tex
T += tex/micro/memory.tex tex/micro/alloc.tex tex/micro/compile.tex
T += tex/micro/syntax.tex tex/micro/parser.tex tex/micro/instream.tex
T += tex/micro/io.tex
T += tex/object/object.tex
T += tex/embed/embed.tex tex/embed/bc.tex tex/embed/vm.tex
T += tex/embed/assembler.tex tex/embed/bluepill.tex
T += tex/embed/lex.tex tex/embed/yacc.tex tex/embed/labels.tex
T += tex/embed/emlinux.tex tex/embed/win32.tex
T += tex/embed/mtask.tex tex/embed/mpu.tex
I += fig/pill103pins.png fig/pill030pins.jpg
I += fig/backpatch.dot
T += tex/iot/iot.tex
T += tex/game/game.tex tex/game/sdl.tex
C += src/vm.c src/asm.cpp
H += src/vm.h src/asm.hpp src/config.h
S += src/asm.lex src/asm.yacc
C += src/linux.c src/win32.c src/cortex.c
H += src/linux.h src/win32.h src/cortex.h
C += src/sdl.c
H += src/sdl.h
F += src/empty.4th src/noop.4th src/jumps.4th src/FORTH.4th
F += src/game/hello.4th
S += $(P) $(C) $(H) $(T) $(I) $(F)

IMG += tmp/backpatch.pdf

ifeq ($(OS),linux)
L += src/sdl.c $(shell sdl-config --libs)
CFLAGS += $(shell sdl-config --cflags)
endif
# / <section:obj>
# \ <section:all>
all: $(PY) $(MODULE).py
	$^ $@
repl: $(PY) $(MODULE).py
	$^ $@

bc: bin/vm tmp/hello.bc
	$^

tmp/%.bc: src/%.4th bin/asm
	bin/asm $@ < $< && $(HEX) $@
tmp/%.bc: src/game/%.4th bin/asm
	bin/asm $@ < $< && $(HEX) $@

bin/vm: $(C) $(H)
	$(TCC) $(CFLAGS) -D$(OS) -DVM  -o $@ src/vm.c src/$(OS).c $(L)
bin/asm: $(C) $(H) tmp/lexer.cpp tmp/parser.cpp
	$(CXX) $(CFLAGS) -D$(OS) -DASM -o $@ src/vm.c \
			src/asm.cpp tmp/lexer.cpp tmp/parser.cpp

tmp/lexer.cpp: src/asm.lex
	flex -o $@ $<
tmp/parser.cpp: src/asm.yacc
	bison -o $@ $<

# / <section:all>
# \ <section:tex>
tex: doc/$(MODULE).pdf
doc/$(MODULE).pdf: $(TMP)/main.pdf
	cp $< $@
$(TMP)/main.pdf: $(T) $(I) $(IMG)
	$(LATEX) $< && $(LATEX) $<
pdf: $(TMP)/$(MODULE)_$(NOW).pdf
$(TMP)/$(MODULE)_$(NOW).pdf: $(TMP)/main.pdf
	cp $< $@
# ghostscript \
# 	-sDEVICE=pdfwrite \
# 	-dMaxSubsetPct=100 \
# 	-dPDFSETTINGS=/ebook \
# 	-dNOPAUSE -dBATCH \
# 	-sOutputFile=$@ $<

tmp/%.pdf: fig/%.dot Makefile
	dot -Tpdf -o $@.tmp $< && pdfcrop $@.tmp $@

# / <section:tex>
# \ <section:install>
.PHONY: install
install: $(OS)_install
	$(MAKE) $(PIP)
	$(MAKE) update
.PHONY: update
update: $(OS)_update
	$(PIP) install -U pip autopep8
	$(PIP) install -U -r requirements.pip
.PHONY: $(OS)_install $(OS)_update
$(OS)_install $(OS)_update:
	sudo apt update
	sudo apt install -u `cat apt.txt`
# \ <section:pyinst>
$(PY) $(PIP):
	python3 -m venv .
	$(MAKE) update
# / <section:pyinst>
# \ <section:merge>
MERGE  = Makefile README.md apt.txt .gitignore .vscode $(S)
.PHONY: main
main:
	# git push -v
	git checkout $@
	git pull -v
	git checkout shadow -- $(MERGE)
.PHONY: shadow
shadow:
	git push -v
	git checkout $@
	# git pull -v
.PHONY: release
release:
	git tag $(NOW)-$(REL)
	git push -v && git push -v --tags
	$(MAKE) shadow
# / <section:merge>
