#!/bin/bash

git fetch $1 pull/$2/head:pull-request-$2
git checkout pull-request-$2
