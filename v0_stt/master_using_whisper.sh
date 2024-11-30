#!/bin/bash

export audio="$HOME/Obsidian/audio_project/test"
cd $audio


for i in $audio/*.{wav,webm}; do
    if [[ -e "$i".{txt,md} ]]
    then
        break
    else
        whisper --language "English" "$i"
        #echo "$i"
        mv "$i".txt "${i%.{webm,wav}}.md"



    fi
done

#rm *.vtt *.srt
#after this, remove the extensions from the txt files, link to the audio note



#first part: make .md file of the $i file, add link to audio file (necessary? these are pretty accurate), add #unProcAudio
#convert an audio note to text, take the $i.txt file and append to the .md file