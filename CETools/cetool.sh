#!/bin/sh

echo 'Loading...'

cd "$(dirname "$0")"
cd lib
ruby -KU main.rb