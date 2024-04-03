dotfiles
========

A collection of my configurations since 2012.

## Devcontainers

The install.sh script is used to bootstrap a devcontainer by passing the  `--dotfiles-repository` flag. This will clone the dotfiles repository and run the install script.

```bash
devcontainer up --dotfiles-repository https://github.com/jtmkrueger/dotfiles --remove-existing-container
```


## Set up iterm for operator

1. Install both Regular and Italic OperatorMonoNerdFonts
2. Enable support for italic text
    * Preferences > Profiles > Text > Italic text allowed
3. Install xterm-256color-italic
    * tic xterm-256color-italic
