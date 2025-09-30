import os, sys, re
import ffmpeg

try: os.mkdir('tmp/slide')
except FileExistsError: pass

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
