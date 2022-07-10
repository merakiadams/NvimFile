#!/bin/env bash

# Init option {{{
Color_off='\033[0m'       # Text Reset

# terminal color template {{{
# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White
# }}}

# version
Version='2.1.0-dev'
#System name
System="$(uname -s)"

# }}}

# need_cmd {{{
need_cmd () {
  if ! hash "$1" &>/dev/null; then
    error "需要 '$1' （找不到命令）"
    exit 1
  fi
}
# }}}

# success/info/error/warn {{{
msg() {
  printf '%b\n' "$1" >&2
}

success() {
  msg "${Green}[✔]${Color_off} ${1}${2}"
}

info() {
  msg "${Blue}[➭]${Color_off} ${1}${2}"
}

error() {
  msg "${Red}[✘]${Color_off} ${1}${2}"
  exit 1
}

warn () {
  msg "${Yellow}[⚠]${Color_off} ${1}${2}"
}
# }}}

# echo_with_color {{{
echo_with_color () {
  printf '%b\n' "$1$2$Color_off" >&2
}
# }}}

# 获取linux发行版名称
function get_linux_distro()
{
	if grep -Eq "Ubuntu" /etc/*-release; then
        echo "Ubuntu"
	elif grep -Eq "Deepin" /etc/*-release; then
        echo "Deepin"
	elif grep -Eq "Raspbian" /etc/*-release; then
        echo "Raspbian"
	elif grep -Eq "uos" /etc/*-release; then
        echo "UOS"
	elif grep -Eq "LinuxMint" /etc/*-release; then
        echo "LinuxMint"
	elif grep -Eq "elementary" /etc/*-release; then
        echo "elementaryOS"
	elif grep -Eq "Debian" /etc/*-release; then
        echo "Debian"
	elif grep -Eq "Kali" /etc/*-release; then
        echo "Kali"
	elif grep -Eq "Parrot" /etc/*-release; then
        echo "Parrot"
	elif grep -Eq "CentOS" /etc/*-release; then
        echo "CentOS"
	elif grep -Eq "fedora" /etc/*-release; then
        echo "fedora"
	elif grep -Eq "openSUSE" /etc/*-release; then
        echo "openSUSE"
	elif grep -Eq "Arch Linux" /etc/*-release; then
        echo "ArchLinux"
	elif grep -Eq "ManjaroLinux" /etc/*-release; then
        echo "ManjaroLinux"
	elif grep -Eq "Gentoo" /etc/*-release; then
        echo "Gentoo"
	elif grep -Eq "alpine" /etc/*-release; then
        echo "Alpine"
	else
        echo "Unknown"
    fi
}

# 获取日期
function get_datetime()
{
    time=$(date "+%Y%m%d%H%M%S")
    echo $time
}

echo ":: 此脚本会自动修改你的nvim以及vim配置文件"
echo ":: 你原有的配置文件将会在此目录下的`Vim_Back文件中`"
echo ":: 此脚本仅支持linux系统，请确认你的操作系统"
echo :: 输入1继续，其他输入则放弃
read if_edit_sources

if [ $if_edit_sources = "1" ]; then
	# check_requirements {{{
	check_requirements () {
    info "正在检测 FishVim 依赖环境..."
    if hash "git" &>/dev/null; then
      git_version=$(git --version)
      success "检测 git 版本：${git_version}"
    else
      warn "缺少依赖：git"
    fi
    if hash "vim" &>/dev/null; then
      is_vim8=$(vim --version | grep "Vi IMproved 8")
      is_vim74=$(vim --version | grep "Vi IMproved 7.4")
      if [ -n "$is_vim8" ]; then
        success "检测到 Vim 版本: vim 8.0"
      elif [ -n "$is_vim74" ]; then
        success "检测到 Vim 版本: vim 7.4"
      else
        if hash "nvim" &>/dev/null; then
          success "检测到 Neovim 已安装成功"
        else
          warn "SpaceVim 需要 Neovim 或者 vim 7.4 及更高版本"
        fi
      fi
      if hash "nvim" &>/dev/null; then
        success "Check Requirements: nvim"
        success "检测到 Neovim 已安装成功"
      fi
    else
      if hash "nvim" &>/dev/null; then
        success "检测到 Neovim 已安装成功"
      else
        warn "FishVim 需要 Neovim 或者 vim 7.4 及更高版本"
      fi
    fi
    info "正在检测终端真色支持..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/JohnMorales/dotfiles/master/colors/24-bit-color.sh)"
  }

  # }}}

  # download_font {{{
  download_font () {
    url="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Regular/complete/${1// /%20}"
    path="$HOME/.local/share/fonts/$1"
    if [[ -f "$path" ]]
    then
      success "已下载 $1"
    else
      info "正在下载 $1"
      curl -s -o "$path" "$url"
      success "已下载 $1"
    fi
  }

  # }}}

  # install_fonts {{{
  install_fonts () {
    if [[ ! -d "$HOME/.local/share/fonts" ]]; then
      mkdir -p $HOME/.local/share/fonts
    fi
    download_font "Sauce Code Pro Nerd Font Complete.ttf"
    info "正在构建字体缓存，请稍等..."
    if [ $System == "Darwin" ];then
      if [ ! -e "$HOME/Library/Fonts" ];then
        mkdir "$HOME/Library/Fonts"
      fi
      cp $HOME/.local/share/fonts/* $HOME/Library/Fonts/
    else
      fc-cache -fv > /dev/null
      mkfontdir "$HOME/.local/share/fonts" > /dev/null
      mkfontscale "$HOME/.local/share/fonts" > /dev/null
    fi
    success "字体安装已完成!"
  }

  # }}}


  #####
  if [ "$if_edit_sources" = "1" ];then

  echo "   "
  echo "   "
  echo_with_color ${Yellow} "        _____ _     _  __     ___             ___           _        _ _ "
  echo_with_color ${Yellow} "       |  ___(_)___| |_\ \   / (_)_ __ ___   |_ _|_ __  ___| |_ __ _| | |"
  echo_with_color ${Yellow} "       | |_  | / __| ’_ \ \ / /| | ’_ | _ \   | || “_ \/ __| __/ _’ | | |"
  echo_with_color ${Yellow} "       |  _| | \__ \ | | \ V / | | | | | | |  | || | | \__ \ || (_| | | |"
  echo_with_color ${Yellow} "       |_|   |_|___/_| |_|\_/  |_|_| |_| |_| |___|_| |_|___/\__\__,_|_|_|"
  echo "   "
  echo "   "
  echo_with_color ${Yellow} "							        Version : 1.0.2 Author : Zane Adams          "
  echo "  "
  echo "  "

  read number
  echo "\033[36m :: \033[0m 4 可选选项。"
  echo "\033[35m 4 \033[0m \033[32m zane \033[0m \ nvim "
  echo "\033[35m 3 \033[0m \033[32m zane \033[0m \ vim "
  echo "\033[35m 2 \033[0m \033[32m zane \033[0m \ both "
  echo "\033[35m 1 \033[0m \033[32m zane \033[0m \ update "
  echo "\033[32m ==> \033[0m 要排除的包: (示例: "1 2 3", "1-3", "^4" 或选项名字)"
  echo "\033[32m ==> \033[0m $number"

  echo "  "
  echo " 正在备份你的配置文件 "
  mv -r $HOME/.config/nvim ./vim_back
  mv -r $HOME/.vim ./vim_back
  mv $HOME/.vimrc ./vim_back

  echo "  "
  echo ":: "
  if [ $number = "1" ]; then
    git clone https://github.com/Zane-two/fishvim ../fishvim
    mv ./fishvim/.vimrc $HOME/
    mv ./fishvim/.vim $HOME/
    mv ./fishvim/nvim $HOME/.config
  elif [ $number = "2" ]; then
    mv ./.vimrc $HOME/
    mv ./nvim $HOME/.config
  elif [ $number = "3" ]; then
    mv ./.vimrc $HOME/
  elif [ $number = "4" ]; then
    mv ./nvim $HOME/.config/
  else 
    echo ":: 对不起，你的操作为无效操作。"

  install_done () {
    echo_with_color ${Yellow} ""
    echo_with_color ${Yellow} "安装已完成!"
    echo_with_color ${Yellow} "=============================================================================="
    echo_with_color ${Yellow} "==               打开 Vim 或 Neovim，所有插件将会自动安装                   =="
    echo_with_color ${Yellow} "=============================================================================="
    echo_with_color ${Yellow} ""
    echo_with_color ${Yellow} "感谢支持 FishVim，欢迎反馈！"
    echo_with_color ${Yellow} ""
  }

  echo "按回车退出"
  read
  exit 0

else
echo "-----已放弃，按回车退出"
read
exit
fi
#####
