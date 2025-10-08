import os, re
import ffmpeg

try: os.mkdir('tmp/slide')
except FileExistsError: pass

mp4 = 'tmp/slide/mp4.mp4'

def tts(name):
    mp3 = f'tmp/slide/{name}.mp3'
    ru = f'tmp/slide/{name}.md'
    with open(ru, 'w') as w:
        with open(f'doc/slide/{name}.md', 'r') as r:
            print(r.read().split('### ru')[-1], file=w)
    # if not os.path.exists(mp3):
    ru2mp3 = f'RHVoice-test -i {ru} -o {mp3} -v 200 -r 130 -p pavel'
    print(ru2mp3); os.system(ru2mp3)
    return mp3

# video fragments
fragment = {
    '00': {'png': 'doc/splash.png', 'mp3': 'doc/dos.mp3', } # splashscreen
}

for i in filter(lambda name: re.match(r'\d+.(md|png)', name), os.listdir('doc/slide')):
    name, ext = i.split('.')
    if name not in fragment.keys(): fragment[name] = {}
    match ext:
        case 'md':
            fragment[name]['mp3'] = f'tmp/slide/{name}.mp3'
        case 'png':
            fragment[name]['png'] = f'doc/slide/{name}.png'

def slide(k, video, audio, dura):
    video = ffmpeg.input(video, loop=1, framerate=1)
    audio = ffmpeg.input(audio)
    stream = ffmpeg.output(
        video, audio, f'tmp/slide/{k}.mp4', t=dura,
        **{
            # video codec
            'c:v': 'libx264', 'pix_fmt': 'yuv420p', 'r': 1, 'crf': 28,
            'vf': 'scale=1280:720,fps=1', 'preset': 'ultrafast',
            # audio codec
            'c:a': 'aac', 'b:a': '128k', 'ac': 1,
            'ar': 44100, 'tune': 'stillimage',
        }
    )
    stream = ffmpeg.overwrite_output(stream)
    ffmpeg.run(stream)

def grab(k, x=1250, y=440, w=640, h=360):
    os.system(
        f'import -window root -crop {w}x{h}+{x}+{y} png:doc/slide/{k}.png')

def single(k):
    tts(k)
    png = f'doc/slide/{k}.png'# fragment[k]['png']
    mp3 = f'tmp/slide/{k}.mp3'# fragment[k]['mp3']
    probe = ffmpeg.probe(mp3); dura = float(probe['streams'][0]['duration'])
    print(k, png, mp3, dura); slide(k, png, mp3, dura)
    os.system(f'cvlc --play-and-exit tmp/slide/{k}.mp4')

# acer
grab('33', 710, 75)
single('33')

# mas
grab('32', x=1225, y=370)
single('32')

with open('tmp/slide/fragments.list', 'w') as list:
    with open('tmp/slide/m3u.m3u', 'w') as m3u:
        for k in sorted(fragment.keys()):
            single(k)
            print(f'{k}.mp4', file=m3u)
            print(f'file {k}.mp4', file=list)

os.system('cvlc tmp/slide/m3u.m3u')# --fullscreen')
os.system('ffmpeg -f concat -safe 0 -i tmp/slide/fragments.list tmp/slide/mp4.mp4')
os.system('vlc tmp/slide/mp4.mp4')# --fullscreen')
