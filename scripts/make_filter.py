#!/usr/bin/env python3

import os

def getgames(directory):
    games = set()
    for file in os.listdir(directory):
        game, _ = os.path.splitext(os.path.basename(file))
        games.add(game)
    return games


# These are in the order of smallest by number of files.
marqueed = getgames('./marquee')
snapped = getgames('./snap')

tags = "\n".join(sorted(marqueed & snapped))

header = """[FOLDER_SETTINGS]
RootFolderIcon mame
SubFolderIcon folder

[ROOT_FOLDER]"""

print(header)
print(tags)
