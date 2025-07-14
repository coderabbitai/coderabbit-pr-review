#!/bin/bash

name="world"

echo Hello $name

for file in $(ls *.txt)
do
  echo $file
done

read input
echo You typed $input

