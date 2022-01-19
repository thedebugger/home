EMAIL ?= "sumitvij11@gmail.com"

create-key:
	ssh-keygen -t ed25519 -C $(EMAIL)

setup-vim:
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	mkdir -p ~/.vim/swap ~/.vim/undo ~/.vim/backup
	mv .vimrc ~/.vimrc

setup-fish:
	curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
	cp .config/fish/config ~/.config/fish/config
	cp .config/fish/functions/* ~/.config/fish/functions/

setup-git:
	cp .gitconfig ~/.gitconfig

setup-tmux:
	cp .tmux.conf ~/.tmux.conf

setup-ssh:
	cp .ssh/config ~/.ssh/config

nixos-upgrade:
	nixos-rebuild switch --upgrade
