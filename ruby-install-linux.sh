#! /bin/bash

PATH=~/.rbenv/bin:~/.rbenv/plugins/ruby-build/bin:$PATH

version=${1:-4.0.0}

trap 'exit 1' 2

eval "$(rbenv init -)"

export CC=clang
export CXX=clang++
export LDFLAGS="${LDFLAGS} -fuse-ld=mold"
export CFLAGS="-O2 -march=native -pipe"
#export CFLAGS="-O0 -ggdb3 -march=native -pipe"
export CXXLAGS="${CFLAGS}"

export RUBY_CONFIGURE_OPTS="--enable-yjit --enable-zjit"

export MAKE_OPTS="-j 16"

[ -d ~/.rbenv/sources/$version ] && rm -rf ~/.rbenv/sources/$version

rbenv install -k -f $version

# export RBENV_VERSION=$version
# rbenv exec gem update --system
# rbenv exec gem install bundler --no-document
# rbenv rehash
