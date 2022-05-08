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
	@[ -f $$HOME/.vim/autoload/plug.vim ] || curl -fLo $$HOME/.vim/autoload/plug.vim $(VIMPLUG)
	@ln -svf $(ROOT_DIR)/vim/vimrc $${HOME}/.vim/vimrc
	@vim +PlugInstall +qa

install-nvim:
	@install -d $$HOME/.config/nvim
	@install -d $(NVIM_AL)
	@ln -svf $(ROOT_DIR)/nvim/init.vim $$HOME/.config/nvim/
	@[ -f $(NVIM_AL)/plug.vim ] || curl -fLo $(NVIM_AL)/plug.vim $(VIMPLUG)
	@nvim +PlugInstall +qa

install-tmux:
	@ln -svf $(ROOT_DIR)/tmux.conf $${HOME}/.tmux.conf

install-git:
	@ln -svf $(ROOT_DIR)/gitconfig $${HOME}/.gitconfig

install-bash:
	@[ -d $${HOME}/.bashrc.d ] || mkdir -p $${HOME}/.bashrc.d
	@for F in bashrc.d/*; do [ -e ~/.$${F} ] || ln -svf $${F} $${HOME}/.bashrc.d/; done
	@[[ `grep -q 'bashrc\.d' $${HOME}/.bashrc` ]] || cat bashrc_d_stanza >> ~/.bashrc
	@if `grep -vq 'bashrc.local' ~/.bashrc`; then echo '[ -f ~/.bashrc.local ] && source ~/.bashrc.local' >> ~/.bashrc; fi
