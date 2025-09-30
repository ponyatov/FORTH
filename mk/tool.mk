CURL   = curl -L -o
CF     = clang-format -style=file -i
GITREF = git clone -o gh --depth 1
#
PY     = $(BIN)/python3
PIP    = $(BIN)/pip3
PEP    = $(BIN)/autopep8 --ignore $(PEPS) -i
