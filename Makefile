SHELL = /bin/bash
DOCKER_COMPOSE = HOST_UID=$$(id -u) HOST_GID=$$(id -g) docker compose -f docker-compose.dist.yaml

#
# ❓ Help output
#
help: ## Show available commands
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_\-\/]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf " \033[36m%-24s\033[0m  %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: start
start: ## Start jupyter notebook server
	$(DOCKER_COMPOSE) up -d


.PHONY: stop
stop: ## Stop jupyter notebook server
	$(DOCKER_COMPOSE) down --remove-orphans


.PHONY: restart
restart: ## Restart jupyter notebook server
	@make -s stop
	@make -s start