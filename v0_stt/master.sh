#!/bin/bash

export notes="/home/mat/Obsidian"
export 
export note_location="/home/mat/Documents/Program\ Experiments/stt_pipeline/test_transcribe.txt"


# remove extension
for i in ./*.webm; 
do
	if [[ -f "$i" ]]; then
		mv "$i" "${i%.webm}"
	fi
done

# convert and add .wav
for i in ./Recording*; 
do 
	ffmpeg -i "$i" -ar 16000 -ac 1 "$i".wav
done


for i in ./*.wav; 
do

	# "title" of recording and tag for start of Transcript
	echo -e \![["$i"]] "\n\nTranscript:" >> "Audio room.md"
	
	# the transcription going to the note page
	deepspeech --model ~/deepspeech/deepspeech-0.9.3-models.pbmm --scorer ~/deepspeech/deepspeech-0.9.3-models.scorer --audio ./"$i" >> "Audio room.md"
	
	# space to make easy to read
	echo -e "\n\n---\n" >> "Audio room.md"

done


# De-dup
for i in ./Recording*; 
do
	if [[ -f "$i".wav ]]; then
		rm "$i"
	fi
done 

mv *.wav ./"Audio Notes"