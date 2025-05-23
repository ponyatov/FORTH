bin/$(BINFILE): $(C) $(H) $(CP) $(HP) $(MK) $(CM)
	cmake --fresh --preset linux
	cmake --build --preset linux -j

$(ELF): $(C) $(H) $(CP) $(HP) $(MK) $(CM)
	cmake --fresh --preset ${HW}
	cmake --build --preset ${HW} -j
