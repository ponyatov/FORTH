import os, sys

try: os.mkdir('tmp/slide')
except FileExistsError: pass

for md in sorted(os.listdir('doc/slide')):
    name, ext = md.split('.')
    with open('tmp/slide/m3u.m3u', 'w') as m3u:
        with open('tmp/slide/files.audio', 'w') as audio:
            if ext == 'md':
                with open(f'doc/slide/{name}.md', 'r') as r:
                    text = r.read().split('# ru')[-1]
                    with open(f'tmp/slide/{name}.md', 'w') as w:
                        print(text, file=w)
                os.system(f'make tmp/slide/{name}.mp3')
                # print(f'{name}.mp3', file=m3u)
                print(f'file {name}.mp3')#, file=audio)
