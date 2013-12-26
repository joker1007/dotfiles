#! /bin/bash

# from. http://qiita.com/mrkn/items/d2fa3f3eabedb7d9a332

PATH=~/.rbenv/bin:~/.rbenv/plugins/ruby-build/bin:$PATH

version=${1:-2.2.0-dev}

trap 'exit 1' 2

eval "$(rbenv init -)"

export RUBY_CONFIGURE_OPTS_ARRAY=( \
  CC=clang CXX=clang++ \
  optflags="-O2 -march=corei7-avx -mtune=corei7-avx" \
)

# export RUBY_CONFIGURE_OPTS_ARRAY=( \
  # CC=clang CXX=clang++ \
  # optflags="-O2 -march=corei7-avx -mtune=corei7-avx" \
  # debugflags="-ggdb3" \
# )

export RUBY_CONFIGURE_OPTS=" \
  --with-arch=x86_64 \
  --with-out-ext=tk,tk/* \
  --enable-shared \
  --enable-pthread \
  --with-gdbm-dir=$(brew --prefix gdbm) \
  --with-dbm-dir=$(brew --prefix gdbm) \
  --with-dbm-type=gdbm_compat \
  --with-libyaml-dir=$(brew --prefix libyaml) \
  --with-libffi-dir=$(brew --prefix libffi) \
  --with-openssl-dir=$(brew --prefix openssl) \
  --with-readline-dir=$(brew --prefix readline) \
  --with-opt-dir=$(brew --prefix) \
"

export MAKE_OPTS="-j 2"

[ -d ~/.rbenv/sources/$version ] && rm -rf ~/.rbenv/sources/$version

rbenv install -k -f $version

export RBENV_VERSION=$version
rbenv exec gem update --system
rbenv exec gem install bundler --pre --no-ri --no-rdoc
rbenv rehash
