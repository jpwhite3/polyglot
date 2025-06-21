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
	@echo "Updating README.md with latest tool versions..."
	@container_id=$$(docker run -d jpwhite3/polyglot:latest sleep 30) && \
	node_version=$$(docker exec $$container_id bash -c '. /root/.nvm/nvm.sh && node --version' | tr -d 'v') && \
	python_version=$$(docker exec $$container_id python --version | awk '{print $$2}') && \
	java_version=$$(docker exec $$container_id bash -c "java -version 2>&1 | head -1" | awk -F '"' '{print $$2}') && \
	dotnet_version=$$(docker exec $$container_id dotnet --version) && \
	go_version=$$(docker exec $$container_id go version | awk '{print $$3}' | sed 's/go//') && \
	ruby_version=$$(docker exec $$container_id ruby --version | awk '{print $$2}') && \
	rust_version=$$(docker exec $$container_id rustc --version | awk '{print $$2}') && \
	docker_version=$$(docker exec $$container_id docker --version | awk '{print $$3}' | tr -d ',') && \
	docker rm -f $$container_id > /dev/null 2>&1 && \
	sed -i.bak \
		-e "s/| Node               |.*|/| Node               | $$node_version |/" \
		-e "s/| Python             |.*|/| Python             | $$python_version |/" \
		-e "s/| Java               |.*|/| Java               | $$java_version |/" \
		-e "s/| Dotnet             |.*|/| Dotnet             | $$dotnet_version |/" \
		-e "s/| GO                 |.*|/| GO                 | $$go_version |/" \
		-e "s/| Ruby               |.*|/| Ruby               | $$ruby_version |/" \
		-e "s/| Rust               |.*|/| Rust               | $$rust_version |/" \
		-e "s/| Docker             |.*|/| Docker             | $$docker_version |/" \
		README.md && \
	rm README.md.bak && \
	echo "README.md updated with latest tool versions"

scan:
	docker scout quickview

publish:
	docker push jpwhite3/polyglot:latest
