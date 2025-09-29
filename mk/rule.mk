VOICE = pavel
tmp/slide/%.mp3: tmp/slide/%.md
	RHVoice-test -i $< -o $@ -p $(VOICE)

MP3 = $(wildcard tmp/slide/*.mp3)
PNG = ~/icons/zxlock.png
.PHONY: video
video: tmp/slide/slide.mp4
tmp/slide/slide.mp4: $(MP3) $(PNG)
	ffmpeg -loop 1 -i $(PNG) -i $< -c:v libx264 -c:a aac -shortest $@
