# Attract-Mode Plus AppImage Build

Builds [Attract-Mode Plus](https://github.com/oomek/attractplus/) into an AppImage. Use case is to run Attract Mode on a Steam Deck and use it to launch MAME, which is installed as a FlatPak.

## Building

Building is just one Docker command:

    docker run -it --mount type=bind,src=.,dst=/attractplus_appimage ubuntu:jammy /attractplus_appimage/buildit.sh

The resulting AppImage will be work/Attract-Mode-x86_64.AppImage

## Running

You still need to copy the source's config directory to ~/.attract before running it.

Have $HOME/mame/mame as a script to start MAME:

    #!/usr/bin/env bash
    flatpak run org.mamedev.MAME $@

If you do it correctly, then Attract Mode will detect MAME.

## My Setup

Setting up both MAME and Attract Mode is a journey, and I'm not going to repeat all of the YouTube videos that are out there.

For MAME, at least set the ROM path. For graphics, I like to set the vertical axis to have integer scaling, and to use a
bgfx shader. Here's one good shader guide:

https://mameonmacs.blogspot.com/2016/01/getting-video-retro-effect-on-lcd.html

Copy /var/lib/flatpak/app/org.mamedev.MAME/x86_64/stable/active/files/share/mame/bgfx to ~/mame so that you can modify it.

So, in mame.ini:

|setting           |value               |
|------------------|--------------------|
|unevenstretchy    |0                   |
|bgfx_path         |/home/deck/mame/bgfx|
|bgfx_backend      |vulkan              |
|bgfx_screen_chains|crt-geom            |
|video             |bgfx                |
|waitvsync         |1                   |
|syncrefresh       |1                   |

For Attract Mode, set up art paths and filtering. You shouldn't have trouble ending up with something that looks at least
as good as this:

[Attract Mode Frontend (Steam Deck - SteamOS) [Test - Micro SD 512Gb]](https://youtu.be/9yaQjpDqTtM?si=t4X6AnJDLZT6Q1-n)

I started by following this guide:

[Attract Mode Clean Setup - Adding Global Filters, Emulators & Artworks](https://youtu.be/PQm86NRnpdw?si=x13xSEN1XFhBn3Cc)

I use the Nevato frontend.

### Controls

My preferred setup is to have the gamepad controls as normal gamepad controls, and the right trackpad as
it would be in a mouse/keyboard setup. This also works well for other emulators that use both the gamepad and
mouse, such as Nintendo DS emulators. One way to achieve it is to start with the Gamepad with Mouse Trackpad
and then bind Right Trackpad Click to Left Mouse Click.

Going through this video, I rebound the following controls in Attract mode (keeping in mind that the Steam Deck
gives you easy access to TAB, ESC and ENTER):

[Attract Mode Controller Setup](https://youtu.be/mzyZnAwTowI?si=kWsdhuTh-cwls6Mm)

|Action         |Input       |
|---------------|------------|
|Displays Menu  |Start       |
|Previous Letter|Left Bumper |
|Next Letter    |Right Bumper|

### Notes

If you're using the [Flat Blue](https://onyxarcade.com/flat_blue.html) theme, you'll have to correct the
paths in layut.nut. See:

http://forum.attractmode.org/index.php?topic=277.msg27568#msg27568

### Extras

The scripts directory has the Python scripts I use to filter the gamelist based on artwork availability. They are meant to
be read and understood and adapted by you, not to be used as-is. One generates a MAME category ini file, and one generates
an Attract Mode tagfile.

Copy the tagfile to ~/.attract/romlists/mame/mame.tag, and add "Tags contains mame" as a global filter.

## Contributing

Look, I'm going to say this right now. If you want to use this to build a different version than what it builds (perhaps a
new version of Attract Plus was released), then don't submit an issue. Submit a PR.