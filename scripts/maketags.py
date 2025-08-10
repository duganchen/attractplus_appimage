#!/usr/bin/env python3

import os

def getgames(directory):
    games = set()
    for file in os.listdir(directory):
        game, _ = os.path.splitext(os.path.basename(file))
        games.add(game)
    return games
    
wheeled = getgames('./wheel')
marqueed = getgames('./marquee')
snapped = getgames('./snap')
flyered = getgames('./flyers')
fanartted = getgames('./fanart')

tags = "\n".join(sorted(wheeled & marqueed & snapped & flyered & fanartted))

with open('mame.tag', 'w') as f:
    f.write(tags)
