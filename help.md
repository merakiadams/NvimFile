 _____ _     _  __     ___             _   _      _
|  ___(_)___| |_\ \   / (_)_ __ ___   | | | | ___| |_ __
| |_  | / __| '_ \ \ / /| | '_ ` _ \  | |_| |/ _ \ | '_ \
|  _| | \__ \ | | \ V / | | | | | | | |  _  |  __/ | |_) |
|_|   |_|___/_| |_|\_/  |_|_| |_| |_| |_| |_|\___|_| .__/
                                                   |_|

### 如果你想要查看键盘映射：

:map
:noremap

### 如果你想要安装插件：

:PluginInstall

### 如果vim-plug失效：

[vim-plug](https://github.com/junegunn/vim-plug)

#### Installation

Download plug.vim and put it in the "autoload" directory.

##### Vim
###### Unix

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

You can automate the process by putting the command in your Vim configuration file as suggested here.

###### Windows (PowerShell)

 ```
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni $HOME/vimfiles/autoload/plug.vim -Force
```

##### Neovim

###### Unix, Linux

```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

###### Linux (Flatpak)

```bash
curl -fLo ~/.var/app/io.neovim.nvim/data/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

###### Windows (PowerShell)

```bash
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -F
```

### 如果你想卸载FishVim：

运行uninstall.sh文件
