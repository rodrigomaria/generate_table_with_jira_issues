ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
$(eval $(ARGS):;@:)
EXEC = docker-compose exec generate-table

help: ## show the make help
	@echo 'usage: make [target] [option]'
	@echo ''
	@echo 'Common sequence of commands:'
	@echo '- make build [nocache]'
	@echo '- make run'
	@echo '- make lint'
	@echo '- make sh'
	@echo '- make create_json'
	@echo '- make create_table'
	@echo ''
	@echo 'targets:'
	@egrep '^(.+)\:\ .*##\ (.+)' ${MAKEFILE_LIST} | sed 's/:.*##/#/' | column -t -c 2 -s '#'

build: ## build application image
ifeq ($(ARGS), nocache)
	@ docker-compose build --no-cache
else
	@ docker-compose build
endif

run: ## run this container
	@ docker-compose up -d

lint: ## runs linters over the code
	@ $(EXEC) /bin/sh -c "isort . && black . && flake8 ."

sh: run ## runs pure shell on application container
	@ $(EXEC) sh

create_json: ## get the csv and returns json file
	@ $(EXEC) python generate_table/create_json.py

create_table: ## get the json file informations and generate a table
	@ $(EXEC) python generate_table/create_table.py