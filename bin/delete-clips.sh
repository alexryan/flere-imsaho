#!/bin/bash

################################################################################
# Delete any clips that are unsuitable for machine learning.
################################################################################
numberBeforeDelete=$(ls -l $FLERE_IMSAHO/data/audio/clips | grep '^-.*mp3' | wc -l)

rm $FLERE_IMSAHO/data/audio/clips/The_Piano_Guys-A_Thousand_Years.50.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Bertie_Higgins-Key_Largo.50.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Bertie_Higgins-Key_Largo.60.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Bertie_Higgins-Key_Largo.70.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Bertie_Higgins-Key_Largo.80.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Anthrax-Chromatic_Death.60.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Anthrax-Chromatic_Death.70.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Anthrax-Chromatic_Death.80.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Anthrax-Milk.30.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Billy_Talent-Fallen_Leaves.30.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Billy_Talent-Fallen_Leaves.40.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Billy_Talent-Fallen_Leaves.70.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Billy_Talent-Fallen_Leaves.80.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Blur-Song_2.30.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Blur-Song_2.40.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Blur-Song_2.70.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Blur-Song_2.80.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Drowning_Pool-Let_The_bodies_hit_the_floor!.30.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Drowning_Pool-Let_The_bodies_hit_the_floor!.40.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Iron_Maiden-2_Minutes_to_Midnight.60.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Iron_Maiden-2_Minutes_to_Midnight.70.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Iron_Maiden-2_Minutes_to_Midnight.80.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Metallica-Disposable_Heroes.30.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Metallica-Dyers_Eve.30.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Rage_Against_The_Machine-Sleep_now_in_the_fire.80.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/WASP-I_Wanna_Be_Somebody.30.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Wrathchild_America-Surrounded_by_Idiots.30.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Wrathchild_America-Surrounded_by_Idiots.40.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Wrathchild_America-Surrounded_by_Idiots.50.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Wrathchild_America-Surrounded_by_Idiots.80.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Adele-Someone_Like_You.80.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Burning_Inside.30.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/DRI-Suit_and_Tie_Guy.30.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/DRI-Suit_and_Tie_Guy.40.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/John_Mayer-Gravity.40.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/John_Mayer-Gravity.50.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Sarah_Brightman-Time_to_Say_Goodbye.80.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Sarah_McLachlan-I_Will_Remember_You.50.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Sarah_McLachlan-I_Will_Remember_You.70.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Sherriff-When_Im_With_You.50.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Sherriff-When_Im_With_You.60.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Sherriff-When_Im_With_You.70.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Sherriff-When_Im_With_You.80.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Stan_Gets-The_Girl_From_Ipanema.70.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/James_Blunt-Youre_Beautiful.50.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/James_Blunt-Youre_Beautiful.60.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/James_Blunt-Youre_Beautiful.70.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/James_Blunt-Youre_Beautiful.80.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Disturbed-Down_With_The_Sickness.60.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Disturbed-Down_With_The_Sickness.70.* 2> /dev/null
rm $FLERE_IMSAHO/data/audio/clips/Chicago-Hard_Habit_To_Break.80
rm $FLERE_IMSAHO/data/audio/clips/Sarah_McLachlan-I_Will_Remember_You.70,0
#rm $FLERE_IMSAHO/data/audio/clips/



################################################################################
# echo stats
################################################################################

numberAfterDelete=$(ls -l $FLERE_IMSAHO/data/audio/clips | grep '^-.*mp3' | wc -l)
echo "numberBeforeDelete = $numberBeforeDelete"
echo "numberAfterDelete  = $numberAfterDelete"


