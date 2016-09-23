[![Build Status](https://travis-ci.org/manabuishii/travis-sge-test.svg?branch=master)](https://travis-ci.org/manabuishii/travis-sge-test)

# travis-sge-test
Test SGE on travis

with docker container

# test flow

1. start master
2. start client
3. throw job from client to master
4. grep on sgemaster container
