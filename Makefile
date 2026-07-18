.DEFAULT_GOAL := build

MAKEFLAGS += --silent

HOST ?= 192.168.0.1
PROJECT ?= helloworld
PRJ_PATH ?= ./$(PROJECT)
TOOLS_PATH ?= /usr/bin

clean:
	rm -rf *.o *.tmp $(PRJ_PATH)/build/

validate_project:
	if [ ! -d "$(PRJ_PATH)" ]; then \
		echo "Aborting, project '$(PRJ_PATH)' doesn't exist"; \
		exit 1; \
	fi

create:
	if [ -d "$(PRJ_PATH)" ]; then \
		echo "Aborting, project '$(PRJ_PATH)' already exists"; \
		exit 1; \
	fi
	mkdir -p $(PRJ_PATH)/src
	touch $(PRJ_PATH)/src/$(PROJECT).a

build: validate_project
	mkdir -p $(PRJ_PATH)/build/
	$(TOOLS_PATH)/acme -f cbm -o $(PRJ_PATH)/build/$(PROJECT).prg -l $(PRJ_PATH)/build/$(PROJECT).lst $(PRJ_PATH)/src/$(PROJECT).a

run: build
	$(TOOLS_PATH)/x64sc -autostart $(PRJ_PATH)/build/$(PROJECT).prg

c64u: build
	./tools/remote_prg.sh $(HOST) $(PRJ_PATH)/build/$(PROJECT).prg | jq .

xxd: build
	$(TOOLS_PATH)/xxd $(PRJ_PATH)/build/$(PROJECT).prg
