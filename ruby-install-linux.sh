#! /bin/bash

PATH=~/.rbenv/bin:~/.rbenv/plugins/ruby-build/bin:$PATH

version=${1:-3.3.0}

trap 'exit 1' 2

eval "$(rbenv init -)"

export CC=cc
export CXX=c++
export CFLAGS="-O2 -march=native"
export CXXLAGS="${CFLAGS}"

export RUBY_CONFIGURE_OPTS="--enable-rjit"

export MAKE_OPTS="-j 16"

[ -d ~/.rbenv/sources/$version ] && rm -rf ~/.rbenv/sources/$version

rbenv install -k -f $version

# export RBENV_VERSION=$version
# rbenv exec gem update --system
# rbenv exec gem install bundler --no-document
# rbenv rehash
