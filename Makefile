# vim: set noet :
#
#
ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

default:
	@echo "mkfile_path $(mkfile_path)"
	@echo "current_dir $(current_dir)"
	@echo "rootdir $(ROOT_DIR)"

install: install-vim
install-vim:
	@install -d $$HOME/.vim/bundle
	@ln -svf $(ROOT_DIR)/vim/vimrc $${HOME}/.vim/vimrc
	@if [ ! -d $${HOME}/.vim/bundle/Vundle.vim ]; then git clone git@github.com:VundleVim/Vundle.vim.git $${HOME}/.vim/bundle/Vundle.vim; fi
	@vim +PluginInstall +qa

install-tmux:
	@ln -svf $(ROOT_DIR)/tmux.conf $${HOME}/.tmux.conf

install-git:
	@ln -svf $(ROOT_DIR)/gitconfig $${HOME}/.gitconfig

install-bash:
	@ln -svf $(ROOT_DIR)/bashrc $${HOME}/.bashrc.local
	@if `grep -vq 'bashrc.local' ~/.bashrc`; then echo '[ -f ~/.bashrc.local ] && source ~/.bashrc.local' >> ~/.bashrc; fi
