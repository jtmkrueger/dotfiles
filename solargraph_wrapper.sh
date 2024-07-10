#!/bin/bash
source ~/.zshrc
chruby-exec $(cat .ruby-version) -- solargraph "$@"
