import os, sys, re
import ffmpeg

try: os.mkdir('tmp/slide')
except FileExistsError: pass

mp4 = 'tmp/slide/mp4.mp4'

# video fragments
fragment = {
    '00': {'png': 'doc/splash.png', 'mp3': 'doc/dos.mp3', } # splashscreen
}

# splash = ffmpeg.input('doc/splash.png', loop=1, framerate=1)
# dos = ffmpeg.input(mp3)
# probe = ffmpeg.probe(mp3)
# dura = float(probe['streams'][0]['duration'])


for i in filter(lambda name: re.match(r'\d+.(md|png)', name), os.listdir('doc/slide')):
    name, ext = i.split('.')
    print(name, ext)
    if name not in fragment.keys(): fragment[name] = {}
    match ext:
        case 'md':
            with open(f'tmp/slide/{name}.md', 'w') as w:
                with open(f'doc/slide/{name}.md', 'r') as r:
                    print(r.read().split('# ru')[-1], file=w)
            fragment[name]['mp3'] = f'tmp/slide/{name}.mp3'
            mp3 = f'tmp/slide/{name}.mp3'
            if not os.path.exists(mp3): os.system(f'make {mp3}')
        case 'png':
            fragment[name]['png'] = f'doc/slide/{name}.png'

def slide(k, video, audio, dura):
    video = ffmpeg.input(video, loop=1, framerate=1)
    audio = ffmpeg.input(audio)

    stream = ffmpeg.output(
        video,
        audio,
        f'tmp/slide/{k}.mp4',
        t=dura,
        **{
            # video codec
            'c:v': 'libx264',
            'pix_fmt': 'yuv420p',
            'vf': 'scale=1280:720,fps=1',
            'r': 1,
            'preset': 'ultrafast',
            'crf': 28,
            # audio codec
            'c:a': 'aac',
            'b:a': '128k',
            'ac': 1,
            'ar': 44100,
            'tune': 'stillimage',
            # Use 'shortest' to stop when the audio ends
            # 'shortest': None,
        }
    )

    stream = ffmpeg.overwrite_output(stream)
    ffmpeg.run(stream)

for k in sorted(fragment.keys()):
    png = fragment[k]['png']
    mp3 = fragment[k]['mp3']
    probe = ffmpeg.probe(mp3)
    dura = float(probe['streams'][0]['duration'])
    slide(k, png, mp3, dura)

# os.system(f'vlc {mp4} --fullscreen')
