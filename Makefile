# Makefile for Poetry project setup

# Default configurations
PYTHON_VERSION=3.11
PROJECT_NAME ?= my_project
SANITIZED_PROJECT_NAME := $(shell echo $(PROJECT_NAME) | sed 's/[^a-zA-Z0-9_]/_/g')
TEMPLATE_DIR=templates
SCRIPT_DIR=scripts

.PHONY: all init install clean help

# Default target
all: init install

# Initialize a new Poetry project
init:
	@if [ -d "$(SANITIZED_PROJECT_NAME)" ]; then \
		echo "Project directory $(SANITIZED_PROJECT_NAME) already exists. Aborting."; \
		exit 1; \
	fi
	@echo "Initializing a new Poetry project: $(SANITIZED_PROJECT_NAME)"
	poetry new $(SANITIZED_PROJECT_NAME)
	@echo "Setting Python version for Poetry virtual environment..."
	@cd $(SANITIZED_PROJECT_NAME) && poetry env use $(PYTHON_VERSION)

	@echo "Copying template files from $(TEMPLATE_DIR) to $(SANITIZED_PROJECT_NAME)"
	@cp $(TEMPLATE_DIR)/.gitignore-template $(SANITIZED_PROJECT_NAME)/.gitignore || echo ".gitignore not found in $(TEMPLATE_DIR)"
	@cp $(TEMPLATE_DIR)/.flake8-template $(SANITIZED_PROJECT_NAME)/.flake8 || echo ".flake8 not found in $(TEMPLATE_DIR)"
	@cp $(TEMPLATE_DIR)/Makefile-template $(SANITIZED_PROJECT_NAME)/Makefile || echo "Makefile not found in $(TEMPLATE_DIR)"
	@cp $(TEMPLATE_DIR)/tricks.yaml-template $(SANITIZED_PROJECT_NAME)/tricks.yaml || echo "tricks.yaml not found in $(TEMPLATE_DIR)"

	@echo "Adding default development dependencies..."
	@cd $(SANITIZED_PROJECT_NAME) && poetry add --group dev flake8 watchdog toml pyyaml

	@echo "Adding watch function to __init__.py..."
	@echo "def watch():" >> $(SANITIZED_PROJECT_NAME)/$(SANITIZED_PROJECT_NAME)/__init__.py
	@echo "    print('Hello, $(SANITIZED_PROJECT_NAME)!')" >> $(SANITIZED_PROJECT_NAME)/$(SANITIZED_PROJECT_NAME)/__init__.py

	@echo "Updating pyproject.toml using external script..."
	@cd $(SANITIZED_PROJECT_NAME) && poetry run python ../$(SCRIPT_DIR)/update_pyproject_toml.py $(SANITIZED_PROJECT_NAME)

	@echo "Project $(SANITIZED_PROJECT_NAME) initialized with a watch script. Run 'cd $(SANITIZED_PROJECT_NAME)' to start working on it."

# Install dependencies
install:
	@echo "Installing dependencies"
	@cd $(SANITIZED_PROJECT_NAME) && poetry install

# Clean up the project directory
clean:
	@echo "Cleaning up project: $(SANITIZED_PROJECT_NAME)"
	rm -rf $(SANITIZED_PROJECT_NAME)

# Help target for displaying commands
help:
	@echo "Usage: make [target] [PROJECT_NAME=name]"
	@echo
	@echo "Targets:"
	@echo "  init     Initialize a new Poetry project with defaults"
	@echo "  install  Install dependencies using Poetry"
	@echo "  clean    Remove the specified project directory"
	@echo "  all      Initialize and install (default target)"
	@echo
	@echo "Optional flags:"
	@echo "  PROJECT_NAME=name  Specify the name of the project (default: my_project)"
