# vim: set noet :
#
install: install-vim

install-vim:
    install -d ~/.vim/bundle
    ln -svf vim/vimrc ~/.vim/vimrc
    git clone git@github.com:VundleVim/Vundle.vim.git ~/.vim/bundle
    vim +PluginInstall +qa

install-tmux:
    ln -sf
