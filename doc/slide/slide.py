import os, sys, re
import ffmpeg

try: os.mkdir('tmp/slide')
except FileExistsError: pass

mp4 = 'tmp/slide/mp4.mp4'

# video fragments
fragment = {
    '': {'png': 'doc/splash.png', 'mp3': 'doc/dos.mp3', } # splashscreen
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
            fragment[name]['mp3'] = f'tmp/slide/{name}.mp3'
            # os.system(f'make tmp/slide/{name}.mp3')
        case 'png':
            fragment[name]['png'] = f'doc/slide/{name}.png'

for k in sorted(fragment.keys()):
    print(k, fragment[k])

# with open('tmp/slide/m3u.m3u', 'w') as m3u:
#     for md in sorted(os.listdir('doc/slide')):
#         if re.match(r'\d+', name):
#             match ext:
#                 case 'md':
#                     with open(f'doc/slide/{name}.md', 'r') as r:
#                         text = r.read().split('# ru')[-1]
#                         with open(f'tmp/slide/{name}.ru.md', 'w') as w:
#                             print(text, file=w)
#                     print(f'file {name}.ru.mp3', file=m3u)
#                 case 'png':
#                     os.system(f'cp doc/slide/{name}.png tmp/slide/{name}.png')
#                     print(f'file {name}.png', file=m3u)

    #     with open('tmp/slide/files.audio', 'w') as audio:
    #         if ext == 'md':
    #             with open(f'doc/slide/{name}.md', 'r') as r:
    #                 text = r.read().split('# ru')[-1]
    #                 with open(f'tmp/slide/{name}.md', 'w') as w:
    #                     print(text, file=w)
    #             # print(f'{name}.mp3', file=m3u)
    #             print(f'file {name}.mp3')#, file=audio)

stream = ffmpeg.output(
    splash,
    dos,
    mp4,
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
os.system(f'vlc {mp4} --fullscreen')
