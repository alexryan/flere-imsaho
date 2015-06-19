#!/bin/bash

#sox 001-A_Thousand_Years.mp3 -c 1 -r 4000 --bits 8 001-A_Thousand_Years.mono-sr4000-ss8.raw

source="001-A_Thousand_Years.mp3"
target="001-A_Thousand_Years.mono-sr4000-ss8.raw"
sox $source -c 1 -r 4000 --bits 8 $target

source="002-The_Cello_Song-Bach_is_back.mp3"
target="002-The_Cello_Song-Bach_is_back.mono-sr4000-ss8.raw"
sox $source -c 1 -r 4000 --bits 8 $target

source="003-Devi_Prayer.mp3"
target="003-Devi_Prayer.mono-sr4000-ss8.raw"
sox $source -c 1 -r 4000 --bits 8 $target

source="004-Sammasati.mp3"
target="004-Sammasati.mono-sr4000-ss8.raw"
sox $source -c 1 -r 4000 --bits 8 $target

source="005-The_Girl_From_Ipanema.mp3"
target="005-The_Girl_From_Ipanema.mono-sr4000-ss8.raw"
sox $source -c 1 -r 4000 --bits 8 $target

source="006_Gasolina.mp3"
target="006_Gasolina.mono-sr4000-ss8.raw"
sox $source -c 1 -r 4000 --bits 8 $target

ffmpeg -i 007_Crazy_Bitch.m4a 007_Crazy_Bitch.mp3

source="007_Crazy_Bitch.mp3"
target="007_Crazy_Bitch.mono-sr4000-ss8.raw"
sox $source -c 1 -r 4000 --bits 8 $target

source="008_Mortal_Kombat_Theme_Song.mp3"
target="008_Mortal_Kombat_Theme_Song.mono-sr4000-ss8.raw"
sox $source -c 1 -r 4000 --bits 8 $target

source="009_Fuck_It_All.mp3"
target="009_Fuck_It_All.mono-sr4000-ss8.raw"
sox $source -c 1 -r 4000 --bits 8 $target

source="010_Fucking_Hostile.mp3"
target="010_Fucking_Hostile.mono-sr4000-ss8.raw"
sox $source -c 1 -r 4000 --bits 8 $target

#source=""
#target=".mono-sr4000-ss8.raw"
#sox $source -c 1 -r 4000 --bits 8 $target


ls -ltF *.raw


