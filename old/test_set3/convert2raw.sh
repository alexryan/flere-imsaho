#!/bin/bash

#sox 001-A_Thousand_Years.mp3 -c 1 -r 4000 --bits 8 001-A_Thousand_Years.mono-sr4000-ss8.raw

ffmpeg -i Adele-Someone_Like_You.m4a Adele-Someone_Like_You.mp3
source="Adele-Someone_Like_You.mp3"
target="Adele-Someone_Like_You.mono-sr4000-ss8.raw"
sox $source -c 1 -r 4000 --bits 8 $target

source="Burning_Inside.mp3"
target="Burning_Inside.mono-sr4000-ss8.raw"
sox $source -c 1 -r 4000 --bits 8 $target

source="Christopher_Cross-Sailing.mp3"
target="Christopher_Cross-Sailing.mono-sr4000-ss8.raw"
sox $source -c 1 -r 4000 --bits 8 $target

source="Deicide-Kill_the_Christian.mp3"
target="Deicide-Kill_the_Christian.mono-sr4000-ss8.raw"
sox $source -c 1 -r 4000 --bits 8 $target

source="Disturbed-Down_With_The_Sickness.mp3"
target="Disturbed-Down_With_The_Sickness.mono-sr4000-ss8.raw"
sox $source -c 1 -r 4000 --bits 8 $target

ffmpeg -i James_Blunt-Youre_Beautiful.m4a James_Blunt-Youre_Beautiful.mp3
source="James_Blunt-Youre_Beautiful.mp3"
target="James_Blunt-Youre_Beautiful.mono-sr4000-ss8.raw"
sox $source -c 1 -r 4000 --bits 8 $target

source="John_Lennon-Imagine.mp3"
target="John_Lennon-Imagine.mono-sr4000-ss8.raw"
sox $source -c 1 -r 4000 --bits 8 $target

ffmpeg -i Ministry-Primitive_Future.m4a Ministry-Primitive_Future.mp3
source="Ministry-Primitive_Future.mp3"
target="Ministry-Primitive_Future.mono-sr4000-ss8.raw"
sox $source -c 1 -r 4000 --bits 8 $target

source="Rhiana-Diamonds.mp3"
target="Rhiana-Diamonds.mono-sr4000-ss8.raw"
sox $source -c 1 -r 4000 --bits 8 $target

source="Sony_Hackers-you_are_an_idiot.mp3"
target="Sony_Hackers-you_are_an_idiot.mono-sr4000-ss8.raw"
sox $source -c 1 -r 4000 --bits 8 $target



ls -ltF *.raw


