.PHONY: clean build run
.DEFAULT_GOAL := build

clean:
	docker image prune -af

clean-all:
	docker system prune -f

shell:
	docker run -it polyglot:latest
	docker exec -it polyglot:latest /bin/bash

build:
	docker build . -t polyglot:latest --platform linux/amd64 --progress=plain