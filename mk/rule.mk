bin/$(BINFILE): $(C) $(H) $(CP) $(HP) $(MK) $(CM)
	cmake --fresh --preset linux
	cmake --build --preset linux -j

RU = pavel
tmp/slide/%.ru.mp3: tmp/slide/%.ru.md mk/rule.mk
	RHVoice-test -i $< -o $@ -p $(RU)

# MDS = $(wildcard doc/slide/*.md)
# MP3 = $(subst doc/,tmp/, $(subst .md,.mp3,$(MDS)))
# PNG = doc/splash.png
VIDEO = -c:v libx264 -vf "scale=1280:720,fps=1" -r 1 -preset ultrafast -crf 28
AUDIO = -c:a aac -b:a 128k -ac 1 -ar 44100
.PHONY: video
video: tmp/slide/mp4.mp4
# tmp/slide/mp4.mp4: tmp/slide/files.audio $(MP3) $(PNG) mk/rule.mk
# 	ffmpeg -loop 1 -i $(PNG) -f concat -i $< $(VIDEO) $(AUDIO) -shortest $@
