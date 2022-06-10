.PHONY: clean build run
.DEFAULT_GOAL := build

clean:
	docker image prune -af

clean-all:
	docker system prune -f

shell:
	docker run -it jpwhite3/polyglot:latest
	docker exec -it jpwhite3/polyglot:latest /bin/bash

build:
	docker build . -t jpwhite3/polyglot:latest --platform linux/amd64 --progress=plain

publish:
	docker push jpwhite3/polyglot:latest
