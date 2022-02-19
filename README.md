<div align="center">
<img width="585" alt="Screen Shot 2021-12-15 at 17 06 47" src="https://user-images.githubusercontent.com/42694704/146170391-02ebd6ed-cd76-4124-90aa-198340e16693.png">
</div>

## Introduction
A minimal zsh theme written in shell

## Features
- [x] Display if there is any error command
- [x] Display change for each git stage
- [x] Show time for each command's execution
- [x] Show what language you are working on

## Option
Put every options in `~/.config/zsh/exports.zsh`
- You can display if your current git branch is ahead or behind remote

  ```bash
  # default
  export ZCRAFT_GIT_SHOW_AHEAD_BEHIND=true
  ```

## Installation
1. Install dependencies:

   - We use `exa` as a modern replacement for default `ls` command. See installation here: [exa](https://github.com/ogham/exa#installation). 
   - If you don't want to use it. You can remove all aliases related to `exa` at the end of `alisases.zsh` with tag `#tree search`
  
2. Setup this configuration into `~/.config/zsh`
      ```bash
      git clone git@github.com:cpea2506/zcraft.git ~/.config/zsh
      ```

3. Export `ZDOTDIR` and execute `~/config/.zshrc` in `~/.zshrc`
    ```bash
    echo "export ZDOTDIR=$HOME/.config/zsh\nsource $HOME/.config/zsh/.zshrc" >> ~/.zshrc
    ```

4. Exit zsh and enjoy your new look.
