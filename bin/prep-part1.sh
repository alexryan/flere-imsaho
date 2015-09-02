#!/bin/bash

################################################################################
# Take multiple 2 second audio clips from every MP3 file in
# $FLERE_IMSAHO/data/audio/full
# and place it them in
# $FLERE_IMSAHO/data/audio/snippets
# as .raw files.
################################################################################

################################################################################
# Convert all m4a files to mp3 files. Delete the m4a files.
################################################################################

echo 'commence m4a file eradication ...'

cd $FLERE_IMSAHO/data/audio/full

SAVEIF=$IFS
IFS=$(echo -en "\n\b")

for file in $(ls *m4a)
do
  name=${file%%.m4a}
  ffmpeg -i ${name}.m4a ${name}.mp3
done

IFS=$SAVEIFS


###############################################################################
# Extract multiple short snippets from each raw file
# These snippets must be long enough that a human can listen to and
# judge its intensity or valence relative to another snippet
################################################################################

#echo 'deleting old audio clips ...'
#rm $FLERE_IMSAHO/data/audio/snippets/*

echo 'generating new audio clips ...'
cd $FLERE_IMSAHO/data/audio/full

SAVEIF=$IFS
IFS=$(echo -en "\n\b")

for file in $(ls *mp3)
do
  name=${file%%.mp3}
  sox ${name}.mp3 ../snippets/${name}.30.mp3 trim 30 2
  sox ${name}.mp3 ../snippets/${name}.40.mp3 trim 40 2
  sox ${name}.mp3 ../snippets/${name}.50.mp3 trim 50 2
  sox ${name}.mp3 ../snippets/${name}.60.mp3 trim 60 2
  sox ${name}.mp3 ../snippets/${name}.70.mp3 trim 70 2
  sox ${name}.mp3 ../snippets/${name}.80.mp3 trim 80 2
done

IFS=$SAVEIFS


################################################################################
# Convert all mp3 files to raw format.
#   $FLERE_IMSAHO/data/audio/full/${name}.mono-sr-4000-ss8.raw
################################################################################

echo 'u want it raw? ...'

cd $FLERE_IMSAHO/data/audio/snippets

SAVEIF=$IFS
IFS=$(echo -en "\n\b")

for file in $(ls *mp3)
do
  name=${file%%.mp3}
  sox ${name}.mp3 -c 1 -r 4000 --bits 16 ${name}.mono-sr4000-ss16.raw
done

IFS=$SAVEIFS


################################################################################
# Delete any clips that are not FULL clips.
################################################################################

find -name "$FLERE_IMSAHO/data/audio/snippets*.raw" -size -16092c -delete


################################################################################
# Delete any clips that are unsuitable for training.
################################################################################

rm $FLERE_IMSAHO/data/audio/snippets/The_Piano_Guys-A_Thousand_Years.50.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Bertie_Higgins-Key_Largo.50.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Bertie_Higgins-Key_Largo.60.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Bertie_Higgins-Key_Largo.70.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Bertie_Higgins-Key_Largo.80.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Anthrax-Chromatic_Death.60.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Anthrax-Chromatic_Death.70.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Anthrax-Chromatic_Death.80.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Anthrax-Milk.30.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Billy_Talent-Fallen_Leaves.30.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Billy_Talent-Fallen_Leaves.40.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Billy_Talent-Fallen_Leaves.70.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Billy_Talent-Fallen_Leaves.80.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Blur-Song_2.30.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Blur-Song_2.40.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Blur-Song_2.70.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Blur-Song_2.80.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Drowning_Pool-Let_The_bodies_hit_the_floor!.30.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Drowning_Pool-Let_The_bodies_hit_the_floor!.40.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Iron_Maiden-2_Minutes_to_Midnight.60.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Iron_Maiden-2_Minutes_to_Midnight.70.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Iron_Maiden-2_Minutes_to_Midnight.80.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Metallica-Disposable_Heroes.30.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Metallica-Dyers_Eve.30.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Rage_Against_The_Machine-Sleep_now_in_the_fire.80.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/WASP-I_Wanna_Be_Somebody.30.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Wrathchild_America-Surrounded_by_Idiots.30.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Wrathchild_America-Surrounded_by_Idiots.40.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Wrathchild_America-Surrounded_by_Idiots.50.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Wrathchild_America-Surrounded_by_Idiots.80.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Adele-Someone_Like_You.80.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Burning_Inside.30.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/DRI-Suit_and_Tie_Guy.30.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/DRI-Suit_and_Tie_Guy.40.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/John_Mayer-Gravity.40.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/John_Mayer-Gravity.50.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Sarah_Brightman-Time_to_Say_Goodbye.80.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Sarah_McLachlan-I_Will_Remember_You.50.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Sarah_McLachlan-I_Will_Remember_You.70.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Sherriff-When_Im_With_You.50.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Sherriff-When_Im_With_You.60.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Sherriff-When_Im_With_You.70.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Sherriff-When_Im_With_You.80.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Stan_Gets-The_Girl_From_Ipanema.70.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/James_Blunt-Youre_Beautiful.50.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/James_Blunt-Youre_Beautiful.60.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/James_Blunt-Youre_Beautiful.70.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/James_Blunt-Youre_Beautiful.80.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Disturbed-Down_With_The_Sickness.60.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/snippets/Disturbed-Down_With_The_Sickness.70.* 2> /dev/null



################################################################################
# echo stats
################################################################################

numberOfFullSongs=$(ls -l $FLERE_IMSAHO/data/audio/full | grep '^-.*mp3' | wc -l)
numberOfClips=$(ls -l $FLERE_IMSAHO/data/audio/snippets | grep '^-.*.raw' | wc -l)
echo "numberOfFullSongs = $numberOfFullSongs"
echo "numberOfClips = $numberOfClips"



