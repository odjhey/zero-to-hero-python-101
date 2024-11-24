# Makefile for Poetry project setup

# Default configurations
PYTHON_VERSION=3.11
PROJECT_NAME ?= my_project
TEMPLATE_DIR=templates

.PHONY: all init install clean help

# Default target
all: init install

# Initialize a new Poetry project
init:
	@if [ -d "$(PROJECT_NAME)" ]; then \
		echo "Project directory $(PROJECT_NAME) already exists. Aborting."; \
		exit 1; \
	fi
	@echo "Initializing a new Poetry project: $(PROJECT_NAME)"
	poetry new $(PROJECT_NAME)
	@echo "Setting Python version for Poetry virtual environment..."
	@cd $(PROJECT_NAME) && poetry env use $(PYTHON_VERSION)

	@echo "Copying template files from $(TEMPLATE_DIR) to $(PROJECT_NAME)"
	@cp $(TEMPLATE_DIR)/.gitignore-template $(PROJECT_NAME)/.gitignore || echo ".gitignore not found in $(TEMPLATE_DIR)"
	@cp $(TEMPLATE_DIR)/.flake8-template $(PROJECT_NAME)/.flake8 || echo ".flake8 not found in $(TEMPLATE_DIR)"

	@echo "Adding default development dependencies..."
	@cd $(PROJECT_NAME) && poetry add --dev flake8

# Install dependencies
install:
	@echo "Installing dependencies"
	@cd $(PROJECT_NAME) && poetry install

# Clean up the project directory
clean:
	@echo "Cleaning up project: $(PROJECT_NAME)"
	rm -rf $(PROJECT_NAME)

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
