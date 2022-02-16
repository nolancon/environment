#!/bin/bash

git clone https://github.com/Yggdroot/indentLine.git ~/.vim/pack/vendor/start/indentLine
vi -u NONE -c "helptags  ~/.vim/pack/vendor/start/indentLine/doc" -c "q"

vi +PluginUpdate +PluginInstall +GoInstallBinaries +qall
