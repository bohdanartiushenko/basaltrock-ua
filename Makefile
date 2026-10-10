# -----------------------------------------------------------------------------
# Copyright (c) 2025-2026 Bohdan Artiushenko https://github.com/bohdanartiushenko
# Home: https://github.com/bohdanartiushenko/basaltrock-ua
# Licensed under the MIT License. See LICENSE file in the project root.
# SPDX-License-Identifier: MIT
# -----------------------------------------------------------------------------

BASALTROCK_GH ?= bohdanartiushenko/basaltrock
BASALTROCK_VERSION ?= $(shell curl -fsSL https://api.github.com/repos/$(BASALTROCK_GH)/releases/latest | sed -n 's/.*"tag_name": *"\([^"]*\)".*/\1/p')
BASALTROCK ?= .basaltrock/$(BASALTROCK_VERSION)
DOCKER_DIR = $(BASALTROCK)/src/main/resources/opensearch/docker
DATA_FOLDER ?= data
DOC_ANSI_CODEPAGE ?= cp1251
MODEL_RUNNER_LLM_CHAT ?= ai/gemma4:e2b-safetensors
MODEL_RUNNER_LLM_EMBEDDING ?= ai/nomic-embed-text-v2-moe
MODEL_KEEP_ALIVE ?= -1
MODEL_CONTEXT_SIZE ?= 32768

COMPOSE = docker compose -f $(DOCKER_DIR)/docker-compose.yml -f docker-compose.ua.yml

export DATA_FOLDER_PATH = $(abspath $(DATA_FOLDER))
export INDEX_HTML_PATH = $(abspath index.ua.html)
export DOC_ANSI_CODEPAGE
export MODEL_RUNNER_LLM_CHAT
export MODEL_RUNNER_LLM_EMBEDDING
export MODEL_RUNNER_BASE_URL

.PHONY: up down restart ingest rtf2txt tune-models logs status prune help fetch

$(DOCKER_DIR)/docker-compose.yml:
	@echo "Downloading basaltrock $(BASALTROCK_VERSION) from github.com/$(BASALTROCK_GH)"
	@mkdir -p $(BASALTROCK)
	@curl -fsSL https://github.com/$(BASALTROCK_GH)/archive/refs/tags/$(BASALTROCK_VERSION).tar.gz | tar xz -C $(BASALTROCK) --strip-components=1
	@mkdir -p $(DOCKER_DIR)/data

fetch: $(DOCKER_DIR)/docker-compose.yml

up: fetch tune-models
	$(COMPOSE) up -d --build
	@echo "Waiting for API..."
	@until curl -sf -X POST http://localhost:80/model/health/count-tokens -H "Content-Type: application/json" -d '{"input":{}}' >/dev/null 2>&1; do sleep 2; done
	@echo "Ready: http://localhost:80"

down:
	$(COMPOSE) down

restart: down up

ingest:
	$(COMPOSE) run --rm ingestion

rtf2txt:
	@find $(DATA_FOLDER) -name '*.rtf' -exec textutil -convert txt -encoding UTF-8 {} \;

tune-models:
	@docker model configure --keep-alive=$(MODEL_KEEP_ALIVE) --context-size=$(MODEL_CONTEXT_SIZE) $(MODEL_RUNNER_LLM_CHAT)

logs:
	$(COMPOSE) logs -f

status:
	$(COMPOSE) ps

prune: down
	docker volume ls --filter "name=basaltrock-ua" -q | xargs -r docker volume rm

help:
	@echo "make up        - Download basaltrock + start Ukrainian KB stack on :80"
	@echo "make fetch     - Download basaltrock $(BASALTROCK_VERSION) only"
	@echo "make down      - Stop"
	@echo "make ingest    - Re-run ingestion over $(DATA_FOLDER)"
	@echo "make rtf2txt   - Convert .rtf in $(DATA_FOLDER) to .txt (macOS textutil)"
	@echo "make logs      - Follow logs"
	@echo "make status    - Show containers"
	@echo "make prune     - Remove volumes"