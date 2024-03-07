# tests:
# 	-mkdir $@
# 	@echo $(TESTS) | base64 -d | jq -r 'map("-e collection=\"\(.use?.collection)\" tests/\(.name).spec.ts")[]' | xargs $(MAKE)

# %.html.json: %.html.json
# 	curl https://api.openai.com/v1/chat/completions \
# 	-H "Content-Type: application/json" \
# 	-H "Authorization: Bearer $(OPENAI_API_KEY)" \
# 	-d @./$< > $@

# Docs/%.md.json:
# 	pandoc Docs/$* -t html | pup table | pandoc -f html -t gfm > $(basename $@ .json)
# 	# cat $(basename .json) | jq -r



# tests/%.spec.ts: tests
# 	@pandoc -M name=$* -M collection=$(collection) -f html -t gfm  --template draft.md $@ -o $@

# build:
# 	act --artifact-server-path /tmp -s GITHUB_TOKEN="$$(gh auth token)" -j hello_world_job --container-architecture linux/amd64


# | $$matches[0][0:1] as $$parts \
# | $$matches[1] as $$tasks \
# | $$matches[2] as $$remote_documents \
# | $$parts[] \
# | . as $$part \
# | $$parts \
# | map(select(.data.line_number > $$part.data.line_number))[0] as $$nextPart \
# | [$$part, if $$nextPart != null then $$nextPart else ] }} end] \
# | . as $$qualified \
# | $$qualified[0] as $$qualifiedPart \
# | $$qualified[1] as $$qualifiedNextPart \
# | { "\($$qualifiedPart.data.lines.text)": [$$tasks | map(select(.data.line_number < $$qualifiedNextPart.data.line_number))[]] }'
# # | map(select(.data.line_number > $$qualifiedPart.data.line_number and .data.line_number > $$qualifiedNextPart.data.line_number))[].data.lines.text)''
# pandoc test.md -f gfm -t html | pup strong | rg 'Task\|Part' --json | jq -s > data.jsonl
# PROGRAM = '.data | [.line_number, .absolute_offset, [.submatches[] | .start, .end, .match.text][], [.lines.text | split("\n")[0]][], $$filename, .type]'
	
# %.jsonl.inverted: %.md
# 	@rg $(PATTERN) $< --json --invert-match | jq -c '.data | [.lines.text, .line_number, .absolute_offset, [.submatches[] | .start, .end, .match.text][]]'



# 	| jq -f meta.jq
# %.md:
# 	jq --argjson collection "$$(cat $< | jq -s)" -sf matches.jq \

# %.md.inverted:
# 	@rg $(PATTERN) $$(basename $@ .inverted) --json --invert-match | jq 'select(.type == "match")' > $@

# test: test/fixtures.json
# 	jq --run-tests spec.test


# PATTERN = Task\|Part\|http

# @jq --run-tests $@
# seed:
# 	dbt seed


# TODO add --context
# %.docx.csv: %.docx.md
# 	@rg $(PATTERN) $< --json --invert-match #| jq -c --arg filename $* $(PROGRAM) | jq -csr '.[] | @csv' > $@



# del:
# 	curl https://api.openai.com/v1/assistants/$(ASSISTANT_ID)/files/$(FILE_ID) \
# 	-H "Content-Type: application/json" \
# 	-H "Authorization: Bearer $$OPENAI_API_KEY" \
# 	-H "OpenAI-Beta: assistants=v1" \
# 	-X DELETE

# del\:thread:
# 	curl https://api.openai.com/v1/threads/$(THREAD_ID) \
# 	-H "Content-Type: application/json" \
# 	-H "Authorization: Bearer $$OPENAI_API_KEY" \
# 	-H "OpenAI-Beta: assistants=v1" \
# 	-X DELETE

# MESSAGES = "Here is a message"
 
# response:
# 	curl https://api.openai.com/v1/threads/$(THREAD_ID)/messages \
# 	-H "Content-Type: application/json" \
# 	-H "Authorization: Bearer $$OPENAI_API_KEY" \
# 	-H "OpenAI-Beta: assistants=v1"

# content:
# 	curl https://api.openai.com/v1/files/$(FILE_ID)/content -H "Authorization: Bearer $$OPENAI_API_KEY"


# thread: threads/$(THREAD_ID).json


# all: $(TARGETS) #thread

# %.docx: %.docx.json
# 	@cat $< | jq .status

# %.docx.json: %.docx.md.pdf
# 	@curl -s https://api.openai.com/v1/files \
# 	-H "Authorization: Bearer $$OPENAI_API_KEY" \
# 	-F purpose="assistants" \
# 	-F file="@$<" | jq -c >> $@



# all: $(TARGETS).md.pdf
# %.docx: %.docx.md.pdf
# 	@open $?

# @curl "https://api.openai.com/v1/assistants" \
# -H "Content-Type: application/json" \
# -H "Authorization: Bearer $$OPENAI_API_KEY" \
# -H "OpenAI-Beta: ssistants=v1" \
# -d @$<
# %.docx.md.pdf: %.docx.md %.docx.md.txt
# 	@pandoc $< -o $@

# %.docx.md.pdf.json: %.docx.md.pdf.json.json
# 	@echo '{ \
# 		"instructions": "$(shell cat prompt.txt)", \
# 		"name": "TAFE Student", \
# 		"tools": [{"type": "retrieval"}], \
# 		"model": "gpt-4-1106-preview", \
# 		"file_ids": ["$(shell cat $<)"] \
# 	}' | jq -nc



# %.docx.md.json.json: %.docx.md.txt

# @iconv -f utf-8 -t utf-8 -c $@
# %.docx.md.txt:
# 	@pandoc $(basename $(basename $@ .txt) .md) -t html | pup table | lynx -display_charset=utf-8 -dump -stdin -nolist > $@

# search:
# 	curl --get https://serpapi.com/search \
# 	-d q="site\\:ncat.nsw.gov.au $(q)" \
# 	-d location="Sydney,+New+South+Wales,+Australia" \
# 	-d hl="en" \
# 	-d gl="au" \
# 	-d google_domain="google.com" \
# 	-d api_key="$(SERP_API_KEY)" > $@

# after ?= 0

# TARGETS = $$HOME/Desktop/*.docx

# all: $(TARGETS)
# 	ls $(TARGETS)

# %.docx: %.docx.csv

# %.docx.csv:
# 	pandoc $(basename $@ .csv) -t gfm > $@
# 	cat $@

# all:
# 	${MAKE} $(shell ls Docs/*.docx)
# PROGRAM = '.[] | [.type, $$filename, [.data | .line_number, .absolute_offset, [.submatches[] | .start, .end, .match.text][], [.lines.text | gsub("\\\n"; "")][]][]]'
# RG_JSON = rg --json

# RG_INVERTED = $(RG_JSON) --invert-match

# %.docx: %.docx.txt %.docx.md
# 	pandoc $@ -t gfm | split -d -p 'Part' - $*-
# 	@ls $*-* | xargs -I _ mv _ _.txt


# %.docx.txt: %.docx.csv %.docx.inverted.csv
# 	@mlr --headerless-csv-output --c2p uniq -f text then sort -f line then cut -f text $? > $@

# clean:
# 	-rm -rf *.txt *-01 *-00

# %.docx.csv: %.docx.md
# 	@$(RG_JSON) Part $< | jq -s 'map(select(.type == "match"))' | jq --arg filename $* $(PROGRAM) | jq -cr '@csv' | mlr --csv --implicit-csv-header label 'type,module,line,offset,start,end,category,text' > $@
	

# %.docx.inverted.csv: %.docx.md
# 	@$(RG_INVERTED) Part $< | jq -s 'map(select(.type == "match"))' | jq --arg filename $* $(PROGRAM) | jq -cr '@csv' | mlr --csv --implicit-csv-header label type,module,line,offset,text > $@
	
# %.docx.md:
# 	@pandoc $(basename $@ .md) -t gfm \
# 	| rg '^\d|Brief|needs|research|Draft|Report|Table|Scenario|Section|Part|identify|analyse|Task|http|you|require|Idea|Analysis|^\|' --after-context $(after) --json \
# 	| jq -scr 'map(select(.type == "match"))[] | .data | if (.submatches[].match.text | match("Section|Senario|Table|Task|Part|\\d|\\|")) then .lines.text else "<!-- \(.lines.text) -->" end' \
# 	| sed 's/☐//g' \
# 	> $@

# after ?= 0


# alex = https://artincontext.org/wp-content/uploads/2021/10/Most-Famous-Portraits.jpg
# jordan = https://i.pinimg.com/736x/39/42/96/3942968d5647afc506757aaa2be07ef4.jpg
# jordan = https://artincontext.org/wp-content/uploads/2021/10/Famous-Portrait-Paintings.jpg
# jordan ?= 'https://openailabsprodscus.blob.core.windows.net/private/user-dPTl0uvY8cYnhh0yA61CXBpO/generations/generation-ElhBEx1FKlPGK0dxXzdr4jyh/image.webp?st=2024-01-25T02%3A46%3A25Z&se=2024-01-25T04%3A44%3A25Z&sp=r&sv=2021-08-06&sr=b&rscd=inline&rsct=image/webp&skoid=15f0b47b-a152-4599-9e98-9cb4a58269f8&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2024-01-25T00%3A11%3A44Z&ske=2024-02-01T00%3A11%3A44Z&sks=b&skv=2021-08-06&sig=TludO7I0K6%2BCrKyHW%2Bjel6aONpAvzvjfFuVXbRLQgZY%3D'

# REQUEST = curl --request POST --url https://api.d-id.com/talks --header 'accept: application/json' --header 'Authorization: Basic $(BASIC)' --header 'content-type: application/json'


# VOX1 = en-AU-NeilNeural
# VOX2 = en-AU-FreyaNeural
# PROGRAM = -cs --arg vox1 $(VOX1) --arg vox2 $(VOX2) --arg file FOO --arg line 00 --arg jordan $(jordan) --arg alex $(alex) --argfile talk talk.json 'map(select(.type == "match"))[] | $$talk * { script: { provider: { voice_id: (if .data.submatches[].match.text == "Jordan:" then $$vox1 else $$vox2 end)}, input: .data.lines.text | sub("^.+: "; "") | sub("\n"; "") }, source_url: (if .data.submatches[].match.text == "Jordan:" then $$jordan else $$alex end)}'
# module ?= BSBESB402 
# script:
# 	@rg '(Jordan|Alex):' Docs/$(module)-role-play.txt --json | jq $(PROGRAM) | tee $@
	
# video:
# 	for x in $(shell ls x*); do $(REQUEST) -d @./$$x; done


# MODULES = BSBESB402 BSBESB404 BSBESB403 BSBMKG434 BSBOPS401 BSBESB401 BSBTWK401 BSBESB407 BSBOPS404

# modules = $(wildcard **/*.docx)

# modules: $(modules)
# 	${MAKE} $?



# $(MODULES)/%.docx: $(MODULES)/%.docx.txt
# 	echo done


# $(MODULES)/%.docx.txt:
# 	pandoc $(basename $@ .txt) -t html | lynx -dump -stdin > $@
# 	split -d -l 50 $item.txt $*.
# 	ls $*.* | xargs -I _ mv _ _.txt
# 	mv $*.*.txt $$(dirname $item)/


# %.txt: %.txt.json
# 	cat $< | tail -n 1 | jq .status

# %.txt.json:
# 	@curl -s https://api.openai.com/v1/files \
# 	-H "Authorization: Bearer $$OPENAI_API_KEY" \
# 	-F purpose="assistants" \
# 	-F file="@$(basename $@ .json)" | jq -c >> $@

# BASIC=bWFuZXNfd2ludHJ5XzAwQGljbG91ZC5jb20:S087ksxd_sdNdcoYxOTfw
# TEXT = Hi, I'm Andrea, the Head of Marketing at Bounce Fitness, headquartered in Cairns with locations in Brisbane, Sydney, and Melbourne.

# stream:
# 	curl --request POST \
# 		--url https://api.d-id.com/talks/streams \
# 		--header 'Authorization: Basic $(BASIC)' \
# 		--header 'content-type: application/json' \

# stream\:start:
# 	curl --request POST \
# 		--url https://api.d-id.com/talks/streams/fhjdks/sdp \
# 		--header 'accept: application/json' \
# 		--header 'Authorization: Basic $(BASIC)' \
# 		--header 'content-type: application/json' \
# 		--data ' { "answer": { "type": "answer" } } '

# talk: #script
# 	curl --request POST \
# 	--url https://api.d-id.com/talks \
# 	--header 'accept: application/json' \
# 	--header 'Authorization: Basic $(BASIC)' \
# 	--header 'content-type: application/json' \
# 	--data @./script



# talks:
# 	@curl --request GET \
#     --url 'https://api.d-id.com/talks' \
# 	--header 'Authorization: Basic $(BASIC)' \
# 	--header 'content-type: application/json'

# hotfix:
# 	curl --request POST --url https://api.d-id.com/talks --header 'accept: application/json' --header 'Authorization: Basic cHViLnJhbnQxQGdtYWlsLmNvbQ:E6Tw1EGsl7ZpPV4s8yYOr' --header 'content-type: application/json' -d ' {"source_url":"https://create-images-results.d-id.com/api_docs/assets/noelle.jpeg","script":{"type":"text","input":"Likewise, Alex. We appreciate the opportunity. Let's dive into the details. What are the key terms and conditions you have in mind for the contract?","provider":{"type":"microsoft","voice_id":"en-US-JennyNeural","voice_config":{"style":"Cheerful"}}}} '


# voices:
# 	@curl --request GET \
# 		--url https://api.d-id.com/tts/voices \
# 		--header 'accept: application/json' \
# 		--header 'Authorization: Basic $(BASIC)' \
# 		--header 'content-type: application/json'

# TARGETS = $(wildcard Docs/*.docx)
# Docs/%.txt:

# tasks3: $(TASKS)
# 	for item in $(firstword $?); do echo ${MAKE} -e THREAD_ID=$(THREAD_ID) $$item.json; done



# all: $(TARGETS)
# 	echo krunk

# Docs/%.docx.md:
# 	@pandoc $(basename $@ .md) -t gfm \
# 	| rg '^\d|Brief|needs|research|Draft|Report|Table|Scenario|Section|Part|identify|analyse|Task|http|you|require|Idea|Analysis|^\|' --after-context $(after) --json \
# 	| jq -scr 'map(select(.type == "match"))[] | .data | if (.submatches[].match.text | match("Section|Senario|Table|Task|Part|\\d|\\|")) then .lines.text else "<!-- \(.lines.text) -->" end' \
# 	| sed 's/☐//g' \
# 	> $@

# thread: threads/$(shell date +%s).json

# threads/%.json:
# 	curl https://api.openai.com/v1/threads \
# 	-H "Content-Type: application/json" \
# 	-H "Authorization: Bearer $$OPENAI_API_KEY" \
# 	-H "OpenAI-Beta: assistants=v1" \
# 	-d '' > $@

# %.thread.json:
# 	curl https://api.openai.com/v1/threads/$*/messages \
# 	-H "Content-Type: application/json" \
# 	-H "Authorization: Bearer $$OPENAI_API_KEY" \
# 	-H "OpenAI-Beta: assistants=v1" > $@

# DOCS = $(wildcard Docs/*.docx)

# all: $(DOCS)

# Docs/%.docx: Docs/%.docx.txt Docs/%.docx.pdf
# 	echo done
# Docs/%.docx.pdf: Docs/%.docx.md
# 	pandoc -f gfm $< -o $@
# Docs/%.docx.txt:
# 	@pandoc $(basename $@ .txt) -t html | lynx -display_charset=utf-8 -dump -stdin -list_inline > $@
# 	@split -a 3 -l 50 $@ $*.
# 	@ls $*.* | xargs -I _ mv _ Docs/_.txt
# 	@rg 'Part|Task|Role|Scenario' -s Docs/$*.docx.txt --before-context 50 --after-context 50 --json \
# 	| jq -s -r 'map(select(.type == "match" or .type == "context")) \
# 	| sort_by(.data.path.text)[].data.lines.text | gsub("\n"; "")' \
# 	| split -p 'Task' -d -a 3 - $*.
# 	@ls $*.* | xargs -I _ mv _ $(shell dirname $@)/_.txt



# .PRECIOUS: Docs/%.docx.pdf Docs/%.docx.md Docs/%.txt Docs/%.json
# TASKS = $(shell ls Docs/*.txt | rg '.\d\d\d.txt')
# MESSAGES = $(shell ls Docs/*.txt | rg '.\d\d\d.txt' | rg $(module) | rg --invert-match '000.txt')

# module ?= fixme


# messages: $(MESSAGES)
# 	for task in $?; do ${MAKE} $$task.json.json; done


# tasks: $(TASKS)
# 	for task in $?; do ${MAKE} $$task.json; done
# tables: $(DOCS)
# # 	for table in $?; do ${MAKE} $$table.md; done


# layouts: $(TASKS)
# 	for task in $?; do ${MAKE} $$task.md.json; done
# Docs/%.md:
# 	pandoc Docs/$$(basename $@ .md) -t html | pup table | lynx -dump -stdin > $@
# thread: $(module).json
# 	@cat $<





# # MODULES = $(shell find Docs/*.docx | jq -Rr 'split("_") | map(split("/")) | map(.[1])[] | select(. != null)' | uniq)

# # .PHONY: $(MODULES)

# # modules: $(MODULES)
# # 	for m in $?; do pandoc -s -M module=$$m --template draft.md -M title=$$m -o $$m.md; done

# # 	for m in $?; do pandoc -f gfm $$item.md -o $$m.md.pdf; done

# module ?= businessplan

# .PRECIOUS: threads/%.json run-%.txt.json runs/%.json

# default:
# 	jq -rs '.[] | @sh "make threads/\(.thread_id).md"' < $(wildcard runs/*.json)
# 	ls -tr threads/*.md | xargs pandoc -o plan.md
# 	pandoc plan.md -o test.pdf


# runs:
# 	cat search.md | split -p "/pagebreak" -a 3 -d - run-
# 	ls run-* | xargs -I _ mv _ _.txt
# 	ls run-*.txt | xargs -I _ cp _ add-_
# 	ls add-* | wc -l
	

# $(module).json:
# 	curl https://api.openai.com/v1/threads \
# 	-H "Content-Type: application/json" \
# 	-H "Authorization: Bearer $$OPENAI_API_KEY" \
# 	-H "OpenAI-Beta: assistants=v1" \
# 	-d '' > $@

# threads/%.md: threads/%.json
# 	cat runs/*.json | jq -rs --argjson thread "$$(cat $<)" '. as $$runs | $$thread.data[] | . as $$data | $$data.run_id as $$run_id | $$runs[] | select(.id == $$run_id).instructions as $$instructions | $$data.content | map([$$instructions, "", .text.value])[][]' | pandoc -o $@
# 	echo '\pagebreak' >> $@

# threads/%.json:
# 	@curl -s https://api.openai.com/v1/threads/$*/messages \
# 	-H "Content-Type: application/json" \
# 	-H "Authorization: Bearer $$OPENAI_API_KEY" \
# 	-H "OpenAI-Beta: assistants=v1" | jq > $@

# messages.txt.json:
# 	@cat $(basename $@ .json) | rg '^' --json  | jq -s 'map(select(.type == "match")) | sort_by(.data.path.text)[].data.lines.text | gsub("\n"; "") | select(. != "") | { role: "user", "content": . }'
# # ¡¡¡FIXME!!!
# # %.json.json: %.json
# # 	curl https://api.openai.com/v1/threads/$*/messages \
# # 	-H "Content-Type: application/json" \
# # 	-H "Authorization: Bearer $$OPENAI_API_KEY" \
# # 	-H "OpenAI-Beta: assistants=v1" \
# # 	-d @./$< | jq -c > $@
# # status:
# # 	curl https://api.openai.com/v1/threads/$(THREAD_ID)/runs/$(RUN_ID) \
# # 	-H "Authorization: Bearer $$OPENAI_API_KEY" \
# # 	-H "OpenAI-Beta: assistants=v1"

# add-run-%.txt: runs/%.json
# 	cat $< | jq .status



# run-%.txt.json:
# 	cat $(basename $@ .json) | rg '^' --context 50 --json| jq -cs --arg additional_instructions "$$(cat add-$(basename $@ .json))" 'map(select(.type == "match")) as $$messages | { assistant_id: "asst_VcOodVezjDgM63kESN9tuMxZ", instructions: [$$messages[].data.lines.text | sub("\n"; "")] | join(" "), thread: { metadata: {slice: $*}, messages: [{ role: "user", content: $$additional_instructions}] } }' | tee $@


# runs/%.json: run-%.txt.json
# 	@curl https://api.openai.com/v1/threads/runs \
# 	-H "Authorization: Bearer $$OPENAI_API_KEY" \
# 	-H "Content-Type: application/json" \
# 	-H "OpenAI-Beta: assistants=v1" \
# 	-d @./$< | tee $@

# assistant.json: instructions.txt.json
# 	curl "https://api.openai.com/v1/assistants" \
# 	-H "Content-Type: application/json" \
# 	-H "Authorization: Bearer $OPENAI_API_KEY" \
# 	-H "OpenAI-Beta: assistants=v1" \
# 	-d @./$<

# instructions.txt.json:
# 	cat $(basename $@ .json) | jq -Rs 'split("\n") | { "instructions": map(select(. != "")) | join(" "), "name": "businessplan", "model": "gpt-3.5-turbo-16k" }'
# CARDS = $(shell ls PITCH.*.0 | grep -v PITCH.md)

# final.mp4: output.mp4
# 	ffmpeg -y -i $< -vf "setpts=(PTS-STARTPTS)/1.25" -af atempo=1.25 $@

# output.mp4: cards
# 	ffmpeg -y -f concat -i files.txt -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" $@
# cards: $(CARDS)
# 	for item in $?; do ${MAKE} $$item.mp4; done
# PITCH.%.1.mp4: PITCH.%.1
# 	cp $$(cat PITCH.$*) $@

# PITCH.%.0.mp4: PITCH.%.1.mp4
# 	ffmpeg -y -i "$$(cat $$(basename $@ .mp4))" -i $< \
# 	-vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" \
# 	-t $$(ffprobe -i $< -show_entries format=duration -v quiet -of csv="p=0") \
# 	-c:v libx264 -pix_fmt yuv420p $@


# TARGETS = ABOUT.md EXPERIENCE.md EDUCATION.md

# .PHONY: $(TARGETS)

# RESUME.pdf: RESUME.html
# 	echo FIXME

# RESUME.html: $(TARGETS)
# 	pandoc -s -M title="Richard Massey" -c ./pandoc.css $(TARGETS) --embed-resources -f markdown+link_attributes+header_attributes -o $@

# ITEMS = $(shell ls -r EXPERIENCE.*.md) 
# EXPERIENCE.md: $(ITEMS)
# 	pandoc $? -o $@

# EXPERIENCE.%.md: EXPERIENCE.%.md.json
# 	echo foo | pandoc -s --metadata-file $< --template EXPERIENCE.md.txt -o $@

# .PRECIOUS: EXPERIENCE.%.md.json

# EXPERIENCE.%.md.json:
# 	rg '^' $(basename $@ .json) --json | jq -cs 'map(select(.type == "match")) | group_by(.data.path.text)[] | map(.data.lines.text | sub("\n"; "")) | { title: .[0], company: .[1], start: .[2], end: .[3], city: .[4], state: .[5], desc: .[6] }' > $@

# SEARCH_TERMS = product+manager
# SERP_API_KEY = $(shell pass show serp_api_key)

# search.md: #$(SEARCH_TERMS).json
# 	echo foo | pandoc -s -f markdown+emoji --metadata-file $(SEARCH_TERMS).json --template search.pdf.md -o $@


# $(SEARCH_TERMS).json:
# 	curl --get https://serpapi.com/search \
# 	-d api_key="$(SERP_API_KEY)" \
# 	-d engine="google_jobs" \
# 	-d google_domain="google.com" \
# 	-d uule="w+CAIQICIgU3lkbmV5LE5ldyBTb3V0aCBXYWxlcyxBdXN0cmFsaWE" \
# 	-d q="$(SEARCH_TERMS)" > $@


test:
	devcontainer features test --project-folder .devcontainer --skip-autogenerated