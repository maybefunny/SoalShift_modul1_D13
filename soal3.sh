#!/bin/bash

i=0
if [ -f "password1.txt" ]
then
    for file in ./password*.txt
    do
        myPass[$i]=$(cat $file)
        i=($i+1)
    done
fi

n=0
while [ $n -eq 0 ]; do
    n=1
    newPass=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 9)
    number=$(head /dev/urandom | tr -dc 0-9 | head -c 1)
    lower=$(head /dev/urandom | tr -dc a-z | head -c 1)
    upper=$(head /dev/urandom | tr -dc A-Z | head -c 1)
    newPass="$newPass$number$lower$upper"

    for e in ${myPass[@]}
    do
        if [ $newPass == $e ]
        then
            n=0
        fi
    done
done

meh="password"
num=1
filename="${meh}${num}.txt"
while [ -f $filename ]; do
    num=$(( $num + 1 ))
    filename="${meh}${num}.txt"
done
echo $newPass > $filename