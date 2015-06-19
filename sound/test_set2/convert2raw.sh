#!/bin/bash

#sox 001-A_Thousand_Years.mp3 -c 1 -r 4000 --bits 8 001-A_Thousand_Years.mono-sr4000-ss8.raw

source="001-Beautiful_Day.mp3"
target="001-Beautiful_Day.mono-sr4000-ss8.raw"
sox $source -c 1 -r 4000 --bits 8 $target

ffmpeg -i 002-Zoo_Station.m4a 002-Zoo_Station.mp3
source="002-Zoo_Station.mp3"
target="002-Zoo_Station.mono-sr4000-ss8.raw"
sox $source -c 1 -r 4000 --bits 8 $target

ffmpeg -i 003-I_Wont_Forget_You.m4a 003-I_Wont_Forget_You.mp3
source="003-I_Wont_Forget_You.mp3"
target="003-I_Wont_Forget_You.mono-sr4000-ss8.raw"
sox $source -c 1 -r 4000 --bits 8 $target

ffmpeg -i 004-Cemetery_Gates.m4a 004-Cemetery_Gates.mp3
source="004-Cemetery_Gates.mp3"
target="004-Cemetery_Gates.mono-sr4000-ss8.raw"
sox $source -c 1 -r 4000 --bits 8 $target

source="005-Left-Handed_Drummer_1.mp3"
target="005-Left-Handed_Drummer_1.mono-sr4000-ss8.raw"
sox $source -c 1 -r 4000 --bits 8 $target

source="006-Lovers_In_Japan.mp3"
target="006-Lovers_In_Japan.mono-sr4000-ss8.raw"
sox $source -c 1 -r 4000 --bits 8 $target

ffmpeg -i 007-Fallen_Angel.m4a 007-Fallen_Angel.mp3
source="007-Fallen_Angel.mp3"
target="007-Fallen_Angel.mono-sr4000-ss8.raw"
sox $source -c 1 -r 4000 --bits 8 $target

ffmpeg -i 008-Did_You_No_Wrong.m4a 008-Did_You_No_Wrong.mp3
source="008-Did_You_No_Wrong.mp3"
target="008-Did_You_No_Wrong.mono-sr4000-ss8.raw"
sox $source -c 1 -r 4000 --bits 8 $target


ls -ltF *.raw


