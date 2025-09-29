VOICE = pavel
tmp/slide/%.mp3: tmp/slide/%.md mk/rule.mk
	RHVoice-test -i $< -o $@ -p $(VOICE)

MP3 = $(wildcard tmp/slide/*.mp3)
PNG = doc/splash.png
VIDEO = -c:v libx264 -vf "scale=1280:720,fps=1" -r 1 -preset ultrafast -crf 28
AUDIO = -c:a aac -b:a 128k -ac 1 -ar 44100
.PHONY: video
video: tmp/slide/slide.mp4
tmp/slide/slide.mp4: tmp/slide/files.audio $(MP3) $(PNG) mk/rule.mk
	ffmpeg -loop 1 -i $(PNG) -f concat -i $< $(VIDEO) $(AUDIO) -shortest $@
