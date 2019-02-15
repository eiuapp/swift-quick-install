#!/bin/bash

for file in $(cat ./diff-filename-list.txt)
do
    diff $file ../$fill
done