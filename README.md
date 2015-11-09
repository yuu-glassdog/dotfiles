# dotfiles
## Git clone
$ git clone https://github.com/yuu-glassdog/dotfiles.git

## Make symbolic link
$ cd dotfiles
$ ./dotfilesLink.sh

## Make directory
$ mkdir -p ~/.vim/bundle

## Install NeoBundle
$ git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
$ vim .vimrc
  :NeoBundleInstall

## Install plugin
$ vim .vimrc
  :%s/"1//g
  :NeoBundleInstall

## Activate some fanctions
$ vim .vimrc
  :%s/"2//g
