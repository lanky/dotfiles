# vim: set noet :
#
#
ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
NVIM_AL := "$$HOME/.local/share/nvim/site/autoload/"
# source for vim plug
VIMPLUG := "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

default:
	@echo "mkfile_path $(mkfile_path)"
	@echo "current_dir $(current_dir)"
	@echo "rootdir $(ROOT_DIR)"

install: install-vim
install-vim:
	@install -d $$HOME/.vim/plugged
	@install -d $$HOME/.vim/autoload
	@curl -Flo $$HOME/.vim/autoload/plug.vim $(VIMPLUG)
	@ln -svf $(ROOT_DIR)/vim/vimrc $${HOME}/.vim/vimrc
	@vim +PlugInstall +qa

install-nvim:
	@install -d $$HOME/.config/nvim
	@install -d $(NVIM_AL)
	@ln -svf $(ROOT_DIR)/nvim/init.vim $$HOME/.config/nvim/
	@if [ ! -f $(NVIM_AL)/plug.vim ]; then curl -Flo $(NVIM_AL)/plug.vim $(VIMPLUG); fi
	@nvim +PlugInstall +qa

install-tmux:
	@ln -svf $(ROOT_DIR)/tmux.conf $${HOME}/.tmux.conf

install-git:
	@ln -svf $(ROOT_DIR)/gitconfig $${HOME}/.gitconfig

install-bash:
	@ln -svf $(ROOT_DIR)/bashrc $${HOME}/.bashrc.local
	@if `grep -vq 'bashrc.local' ~/.bashrc`; then echo '[ -f ~/.bashrc.local ] && source ~/.bashrc.local' >> ~/.bashrc; fi
