.PHONY: ai tmp/$(APP).ai.md
ai: tmp/$(APP).ai.md
tmp/$(APP).ai.md:
	cat README.md doc/*.md doc/slide/*.md $(C) $(H) $(R) $(S) > $@ ; touch $@
