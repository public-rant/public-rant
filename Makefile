TARGETS = $(shell find src -name README.md | xargs)
README.md: $(TARGETS)
	cat $? | grep -v _Note > $@