#!/bin/bash
# TODO should be a doit python script tbh

setup_config () {
    echo "Diff between $1 and $2:"
    diff $1 $2
    ln -isb $(pwd)/$1 $2
}

setup_config vim/.vimrc ~/.vimrc
setup_config vim/.config/nvim/init.vim ~/.config/nvim/init.vim

setup_config scripts/workhours.py ~/Code/scripts/workhours.py

echo "Link git/.gitconfig manually!"
setup_config git/.gitignore_global ~/.gitignore_global

setup_config conda/.condarc ~/.condarc

setup_config bash/.bash_aliases ~/.bash_aliases
setup_config bash/.bash_completion ~/.bash_completion
setup_config bash/.bash_profile ~/.bash_profile
setup_config bash/.bashrc ~/.bashrc

echo "Link bash/.bashrc_local manually!"

setup_config ipython/profile_default/ipython_config.py ~/.ipython/profile_default/ipython_config.py
setup_config ipython/profile_default/ipython_kernel_config.py ~/.ipython/profile_default/ipython_kernel_config.py
echo "Link ~/.ipython/profile_default/startup manually!"
