#### somni.dotfiles.linux ####
## ZSH Profile Shell Script ##

# ** Set `fcitx` as the input method on Linux **
if [ `uname` = "Linux" ]; then
  export XMODIFIERS=@im=fcitx
  export GTK_IM_MODULE=fcitx
  export QT_IM_MODULE=fcitx
  export INPUT_METHOD=fcitx
fi
