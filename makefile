user = 1000
group = 1000
tools = tools.yaml

start:
	docker compose down --remove-orphans
	docker compose up -d
	docker compose logs -f
logs:
	docker compose logs -f 
stop:
	docker compose down 
build:
	docker compose -f $(tools) -f docker-compose.yaml build
cleanup:
	docker rm -f $$(docker ps -aq)

angular:
	docker compose -f $(tools) run --rm -u $(user):$(group) angular

nestjs:
	docker compose -f $(tools) run --rm -u $(user):$(group) nestjs

git-clone:
	@read -p "Enter Repo URL: " repo; \
	read -p "Enter folder: " folder; \
	docker compose -f $(tools) run --rm git bash -c \
			"git clone $$repo $$folder "

clone:
	git clone repodelfronend src/frontend
	git clone repodelbackend src/backend

build-env:
