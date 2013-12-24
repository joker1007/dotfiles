#! /bin/bash

PATH=~/.rbenv/bin:~/.rbenv/plugins/ruby-build/bin:$PATH

version=${1:-2.1.0-dev}

trap 'exit 1' 2

eval "$(rbenv init -)"

export CC=clang
export CXX=clang++
export CFLAGS="-O2 -march=corei7-avx -mtune=corei7-avx"
export CXXLAGS="${CFLAGS}"

export RUBY_CONFIGURE_OPTS=" \
  --with-out-ext=tk,tk/* \
  --enable-shared \
  --enable-pthread \
  --disable-install-doc \
  --disable-libedit \
"

export MAKE_OPTS="-j 2"

[ -d ~/.rbenv/sources/$version ] && rm -rf ~/.rbenv/sources/$version

rbenv install -k -f $version

export RBENV_VERSION=$version
rbenv exec gem update --system
rbenv exec gem install bundler --pre --no-ri --no-rdoc
rbenv rehash
