# -----------------------------------------------------------------------------
# Copyright (c) 2025-2026 Bohdan Artiushenko https://github.com/bohdanartiushenko
# Home: https://github.com/bohdanartiushenko/basaltrock-ua
# Licensed under the MIT License. See LICENSE file in the project root.
# SPDX-License-Identifier: MIT
# -----------------------------------------------------------------------------

PROJECT_NAME = basaltrock-ua
SYSTEM_PROMPT_FILE = system-prompt.ua.txt
INDEX_HTML = index.ua.html
DOC_ANSI_CODEPAGE ?= cp1251

S3_EXTRA_BUCKETS = basaltrock-ua
SEED_SRC_basaltrock-ua = .

PRIVATE_CLOUD_GH ?= bohdanartiushenko/basaltrock-private-cloud
PRIVATE_CLOUD_VERSION ?= $(shell curl -fsSL https://api.github.com/repos/$(PRIVATE_CLOUD_GH)/tags | sed -n 's/.*"name": *"\([^"]*\)".*/\1/p' | head -1)
PRIVATE_CLOUD_DIR ?= .private-cloud/$(PRIVATE_CLOUD_VERSION)
export PRIVATE_CLOUD_VERSION

$(PRIVATE_CLOUD_DIR)/Makefile:
	@echo "Downloading basaltrock-private-cloud $(PRIVATE_CLOUD_VERSION) from github.com/$(PRIVATE_CLOUD_GH)"
	@mkdir -p $(PRIVATE_CLOUD_DIR)
	@curl -fsSL https://github.com/$(PRIVATE_CLOUD_GH)/archive/refs/tags/$(PRIVATE_CLOUD_VERSION).tar.gz | tar xz -C $(PRIVATE_CLOUD_DIR) --strip-components=1

include $(PRIVATE_CLOUD_DIR)/Makefile