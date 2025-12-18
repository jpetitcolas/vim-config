.PHONY: setup

setup:
	@mkdir -p ~/.config
	@ln -sf $(CURDIR) ~/.config/nvim
	@echo "Neovim config linked to ~/.config/nvim"
	@echo "Run 'nvim' to start (plugins install automatically)"
