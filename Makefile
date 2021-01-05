# \ <section:var>
MODULE     = $(notdir $(CURDIR))
OS        ?= $(shell uname -s)
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
CFLAGS += -I$(CWD) -I$(SRC)
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
T += tex/embed/lex.tex tex/embed/yacc.tex
T += tex/embed/emlinux.tex tex/embed/win32.tex
I += fig/pill103pins.png fig/pill030pins.jpg
C += src/vm.c src/asm.cpp
H += src/vm.h src/asm.hpp src/config.h
S += src/asm.lex src/asm.yacc
C += src/Linux.c src/win32.c src/cortex.c
H += src/Linux.h src/win32.h src/cortex.h
F += src/empty.4th src/noop.4th src/FORTH.4th
S += $(P) $(C) $(H) $(T) $(I) $(F)
# / <section:obj>
# \ <section:all>
all: $(PY) $(MODULE).py
	$^ $@
repl: $(PY) $(MODULE).py
	$^ $@

bc: bin/vm tmp/FORTH.bc
	$^

tmp/%.bc: src/%.4th bin/asm 
	bin/asm $@ < $< && $(HEX) $@

bin/vm: $(C) $(H)
	$(TCC) $(CFLAGS) -D$(OS) -DVM  -o $@ src/vm.c src/$(OS).c
bin/asm: $(C) $(H) tmp/lexer.cpp tmp/parser.cpp
	$(CXX) $(CFLAGS) -D$(OS) -DASM -o $@ src/vm.c src/$(OS).c \
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
$(TMP)/main.pdf: $(T)
	$(LATEX) $< && $(LATEX) $<
pdf: $(TMP)/$(MODULE)_$(NOW).pdf
$(TMP)/$(MODULE)_$(NOW).pdf: $(TMP)/main.pdf
	ghostscript \
		-sDEVICE=pdfwrite \
		-dMaxSubsetPct=100 \
		-dPDFSETTINGS=/ebook \
		-dNOPAUSE -dBATCH \
		-sOutputFile=$@ $<
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
