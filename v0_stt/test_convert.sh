#!/bin/bash

ROOM="$HOME/Obsidian/Transcribed Audio Notes.md"
NOTES="$HOME/Obsidian/"



# remove extension
for i in $NOTES*.webm;
do
	[ -f "$i" ] && mv "$i" "${i%.webm}"
done


# convert and add .wav
for i in $NOTES/Recording*; 
do 
	[ ! -f "$i".wav ] && ffmpeg -i "$i" -ar 16000 -ac 1 "$i".wav
	# TO-DO: if I already ahve a .wav file but it needs to be converted, how do I find this out??
done




#[] -> DeepSpeech processes and spits out text

for i in $NOTES*.wav; 
	do

		# "title" of recording and tag for start of Transcript
		echo -e \!["$i"] "\n\nTranscript:" >> $ROOM
		
		# the transcription going to the note page
		deepspeech --model ~/deepspeech/deepspeech-0.9.3-models.pbmm --scorer ~/deepspeech/deepspeech-0.9.3-models.scorer --audio "$i" >> $ROOM
		
		# space to make easy to read
		echo -e "\n\n---\n" >> $ROOM

	done



# remove og files
for i in $NOTES/Recording*; 
do
	if [ -f "$i".wav ]; then
		rm "$i"
	fi
done 

# move converted audio notes out of the way
mv $NOTES*.wav $NOTES'Audio Notes (Transcribed)'







# Is there an ffmpeg command that deletes the original copy? I just want the converted


# Check for already converted
## Note, if files have already been converted, it will try to run again, just will ask to overwrite each one.
## having a check to see if both already exist (for each file with 
# quiet mode???

# can I store  "${i%.webm}" in a variable? If so, I can reduce speeling errors, work less
