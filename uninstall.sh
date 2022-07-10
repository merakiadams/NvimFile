#! /bin/env bash

# uninstall_vim {{{
uninstall_vim () {
  if [[ -d "$HOME/.vim" ]]; then
    if [[ "$(readlink $HOME/.vim)" =~ \.SpaceVim$ ]]; then
      rm "$HOME/.vim"
      success "已为 vim 卸载了 FishVim"
      if [[ -d "./Vim_Back" ]]; then
        mv ./Vim_Back/.vim $HOME/.vim"
        success "从 Vim_Back 恢复了原始配置"
      fi
    fi
  fi
  if [[ -f "./Vimrc_Back" ]]; then
    mv ./.Vimrc_Back/.vimrc "$HOME/.vimrc"
    success "从 Vimrc_Back 恢复了原始配置"
  fi
}
# }}}

# uninstall_neovim {{{
uninstall_neovim () {
  if [[ -d "$HOME/.config/nvim" ]]; then
      rm "$HOME/.config/nvim"
      success "已为 neovim 卸载了 FishVim"
      if [[ -d "./Vim_Back" ]]
        mv ./Vim_Back  "$HOME/.config/nvim"
        success "从 Vim_Back 恢复了原始配置"
      fi
    fi
  fi
}
# }}}
