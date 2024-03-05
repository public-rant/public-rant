CARDS = $(shell ls PITCH.*.0 | grep -v PITCH.md)

final.mp4: output.mp4
	ffmpeg -y -i $< -vf "setpts=(PTS-STARTPTS)/1.25" -af atempo=1.25 $@

output.mp4: cards
	ffmpeg -y -f concat -i files.txt -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" $@
cards: $(CARDS)
	for item in $?; do ${MAKE} $$item.mp4; done
PITCH.%.1.mp4: PITCH.%.1
	cp $$(cat PITCH.$*) $@

PITCH.%.0.mp4: PITCH.%.1.mp4
	ffmpeg -y -i "$$(cat $$(basename $@ .mp4))" -i $< \
	-vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" \
	-t $$(ffprobe -i $< -show_entries format=duration -v quiet -of csv="p=0") \
	-c:v libx264 -pix_fmt yuv420p $@