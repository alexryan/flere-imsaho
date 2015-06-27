#!/bin/bash

#sox 001-A_Thousand_Years.mp3 -c 1 -r 41000 --bits 16 001-A_Thousand_Years.mono-sr41000-ss16.raw

source="001-A_Thousand_Years.mp3"
target="001-A_Thousand_Years.mono-sr41000-ss16.raw"
sox $source -c 1 -r 41000 --bits 16 $target

source="002-The_Cello_Song-Bach_is_back.mp3"
target="002-The_Cello_Song-Bach_is_back.mono-sr41000-ss16.raw"
sox $source -c 1 -r 41000 --bits 16 $target

source="003-Devi_Prayer.mp3"
target="003-Devi_Prayer.mono-sr41000-ss16.raw"
sox $source -c 1 -r 41000 --bits 16 $target

source="004-Sammasati.mp3"
target="004-Sammasati.mono-sr41000-ss16.raw"
sox $source -c 1 -r 41000 --bits 16 $target

source="005-The_Girl_From_Ipanema.mp3"
target="005-The_Girl_From_Ipanema.mono-sr41000-ss16.raw"
sox $source -c 1 -r 41000 --bits 16 $target

source="006_Gasolina.mp3"
target="006_Gasolina.mono-sr41000-ss16.raw"
sox $source -c 1 -r 41000 --bits 16 $target

#ffmpeg -i 007_Crazy_Bitch.m4a 007_Crazy_Bitch.mp3

source="007_Crazy_Bitch.mp3"
target="007_Crazy_Bitch.mono-sr41000-ss16.raw"
sox $source -c 1 -r 41000 --bits 16 $target

source="008_Mortal_Kombat_Theme_Song.mp3"
target="008_Mortal_Kombat_Theme_Song.mono-sr41000-ss16.raw"
sox $source -c 1 -r 41000 --bits 16 $target

source="009_Fuck_It_All.mp3"
target="009_Fuck_It_All.mono-sr41000-ss16.raw"
sox $source -c 1 -r 41000 --bits 16 $target

source="010_Fucking_Hostile.mp3"
target="010_Fucking_Hostile.mono-sr41000-ss16.raw"
sox $source -c 1 -r 41000 --bits 16 $target

#source=""
#target=".mono-sr41000-ss16.raw"
#sox $source -c 1 -r 41000 --bits 16 $target


ls -ltF *sr41000-ss16.raw

