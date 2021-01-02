# \ <section:var>
MODULE     = $(notdir $(CURDIR))
NOW        = $(shell date +%d%m%y)
REL        = $(shell git rev-parse --short=4 HEAD)
# / <section:var>
# \ <section:dir>
CWD        = $(CURDIR)
DOC        = $(CWD)/doc
TEX        = $(CWD)/tex
TMP        = $(CWD)/tmp
# / <section:dir>
# \ <section:tool>
WGET       = wget -c
PY         = $(BIN)/python3
PIP        = $(BIN)/pip3
PEP        = $(BIN)/autopep8
PYT        = $(BIN)/pytest
LATEX	   = pdflatex -halt-on-error -output-directory=$(TMP)
# / <section:tool>
# \ <section:obj>
P += $(MODULE).py
T += tex/main.tex tex/header.tex tex/bib.tex
T += tex/intro.tex
S += $(P) $(T)
# / <section:obj>
# \ <section:all>
all: $(PY) $(MODULE).py
	$^ $@
repl: $(PY) $(MODULE).py
	$^ $@
# / <section:all>
# \ <section:tex>
tex: doc/$(MODULE).pdf
doc/$(MODULE).pdf: $(TMP)/main.pdf
	cp $< $@
$(TMP)/main.pdf: $(T)
	$(LATEX) $<
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
