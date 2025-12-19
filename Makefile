FONT_NAME := JetBrainsMono
FONT_URL := https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/$(FONT_NAME).zip
FONT_DIR := ~/.local/share/fonts

.PHONY: setup init install-font install-deps

setup: init
	@ln -sf $(CURDIR) ~/.config/nvim
	@echo "Neovim config linked to ~/.config/nvim"
	@echo "Run 'nvim' to start (plugins install automatically)"

init: install-font install-deps

install-deps:
	@echo "Installing npm dependencies..."
	@npm install -g typescript-language-server typescript
	@npm install -g vscode-langservers-extracted
	@npm install -g tree-sitter-cli
	@echo "Dependencies installed"

install-font:
	@if fc-list | grep -qi "JetBrainsMono Nerd Font"; then \
		echo "JetBrainsMono Nerd Font already installed"; \
	else \
		echo "Installing JetBrainsMono Nerd Font..."; \
		mkdir -p $(FONT_DIR); \
		curl -fLo /tmp/$(FONT_NAME).zip $(FONT_URL); \
		unzip -o /tmp/$(FONT_NAME).zip -d $(FONT_DIR)/$(FONT_NAME); \
		rm /tmp/$(FONT_NAME).zip; \
		fc-cache -fv; \
		echo "Font installed. Set 'JetBrainsMono Nerd Font' in Windows Terminal settings."; \
	fi
