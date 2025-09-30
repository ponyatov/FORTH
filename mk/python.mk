.PHONY: py
py:     requirements.txt $(PY) $(PIP)
	$(PIP) install -U -r $<
$(PIP): $(PY)
	$(PY) -m pip install -U pip
$(PY):  pyvenv.cfg
pyvenv.cfg:
	python3 -m venv .
