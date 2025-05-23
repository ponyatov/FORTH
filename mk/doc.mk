.PHONY: doxy
doxy: .doxygen doc/DoxygenLayout.xml doc/logo.png
	rm -rf doc/html ; doxygen $< 1>/dev/null
	cargo doc && cp -r target/doc/$(MODULE) doc/html/

.PHONY: doc
doc:
