#!/bin/bash

diff vim/.vimrc ~/.vimrc
ln -isb $(pwd)/vim/.vimrc ~/.vimrc
diff vim/.config/nvim/init.vim ~/.config/nvim/init.vim
ln -isb $(pwd)/vim/.config/nvim/init.vim ~/.config/nvim/init.vim

diff scripts/workhours.py ~/Code/scripts/workhours.py
ln -isb $(pwd)/scripts/workhours.py ~/Code/scripts/workhours.py

echo "Link git/.gitconfig manually!"
diff git/.gitignore_global ~/.gitignore_global
ln -isb $(pwd)/git/.gitignore_global ~/.gitignore_global

diff conda/.condarc ~/.condarc
ln -isb $(pwd)/conda/.condarc ~/.condarc

diff bash/.bash_aliases ~/.bash_aliases
ln -isb $(pwd)/bash/.bash_aliases ~/.bash_aliases
diff bash/.bash_completion ~/.bash_completion
ln -isb $(pwd)/bash/.bash_completion ~/.bash_completion
diff bash/.bash_profile ~/.bash_profile
ln -isb $(pwd)/bash/.bash_profile ~/.bash_profile
diff bash/.bashrc ~/.bashrc
ln -isb $(pwd)/bash/.bashrc ~/.bashrc

echo "Link bash/.bashrc_local manually!"
