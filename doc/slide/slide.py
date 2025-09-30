import os, sys, re
import ffmpeg

try: os.mkdir('tmp/slide')
except FileExistsError: pass

mp3 = 'doc/dos.mp3'
mp4 = 'tmp/slide/mp4.mp4'

splash = ffmpeg.input('doc/splash.png', loop=1, framerate=1)
dos = ffmpeg.input(mp3)
probe = ffmpeg.probe(mp3)
dura = float(probe['streams'][0]['duration'])

stream = ffmpeg.output(
    splash,
    dos,
    mp4,
    t=dura,
    **{
        # video codec
        'c:v': 'libx264',
        'pix_fmt':'yuv420p',
        'vf': 'scale=1280:720,fps=1',
        'r':1,
        'preset': 'ultrafast',
        'crf': 28,
        # audio codec
        'c:a': 'aac',
        'b:a': '128k',
        'ac': 1,
        'ar': 44100,
        # 'tune': 'stillimage',
        # Use 'shortest' to stop when the audio ends
        # 'shortest': None,
    }
)

stream = ffmpeg.overwrite_output(stream)
ffmpeg.run(stream)
os.system(f'vlc {mp4} --fullscreen')

with open('tmp/slide/m3u.m3u', 'w') as m3u:
    for md in sorted(os.listdir('doc/slide')):
        name, ext = md.split('.')
        if re.match(r'\d+',name):
            match ext:
                case 'md':
                    with open(f'doc/slide/{name}.md', 'r') as r:
                        text = r.read().split('# ru')[-1]
                        with open(f'tmp/slide/{name}.ru.md', 'w') as w:
                            print(text, file=w)
                        # os.system(f'make tmp/slide/{name}.ru.mp3')
                    print(f'file {name}.ru.mp3', file=m3u)
                case 'png':
                    os.system(f'cp doc/slide/{name}.png tmp/slide/{name}.png')
                    print(f'file {name}.png', file=m3u)

    #     with open('tmp/slide/files.audio', 'w') as audio:
    #         if ext == 'md':
    #             with open(f'doc/slide/{name}.md', 'r') as r:
    #                 text = r.read().split('# ru')[-1]
    #                 with open(f'tmp/slide/{name}.md', 'w') as w:
    #                     print(text, file=w)
    #             # print(f'{name}.mp3', file=m3u)
    #             print(f'file {name}.mp3')#, file=audio)
