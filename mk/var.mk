# var
MODULE  = $(notdir $(CURDIR))
REL     = $(shell git rev-parse --short=4    HEAD)
BRANCH  = $(shell git rev-parse --abbrev-ref HEAD)
NOW     = $(shell date +%y%m%d)
PEPS    = E26,E302,E305,E401,E402,E701,E702
BINFILE = $(MODULE)_$(HW)_$(BRANCH)_$(REL)_$(NOW)

ifeq ($(OS),Windows_NT)
	WS  = $(shell uname -o)
	EXE = .exe
else
	WS  = $(shell lsb_release -si)
	EXE =
endif
