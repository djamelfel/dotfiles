* VIM

First step install vim-plug:
	$ https://github.com/junegunn/vim-plug

Second step copy `vimrc` to `~/.vimrc` directory and execute in vim:
	:PlugInstall

* ZSH

First step install zsh if you need it and tmux


Second step:
	$ cp zshrc ~/.zshrc
	$ cp tmux.conf ~/.tmux.conf

* YouCompleteMe

First step install YCM:
	$ cd ~/.vim/plugged/YouCompleteMe/
	$ ./install.sh --all

* Powerline
Then config powerline in that way:
	$ pip install powerline-status
	$ mv themes /usr/local/lib/python2.7/site-packages/powerline/config_files/themes

