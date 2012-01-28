#!/bin/bash
# Author: Eric Pruitt
# Licence: Public Domain, FreeBSD or MIT
# This script runs fuzz testing to ensure the output produced by runiq and GNU
# uniq are the same barring differences in whitespace.

(
    for ITERATION in 1 2 3 4 5
    do
        for ARGUMENTS in \
            '--repeated --count'\
            '--unique --count'\
            '--repeated'\
            '--unique'\
            '--count'\
            '--all-repeated=separate'\
            '--all-repeated=prepend'\
            '--all-repeated'\
            '--all-repeated --repeated'
        do
            head -c65536 /dev/urandom | tr -cd 'ab\n' > /tmp/fuzzdata
            ./runiq $ARGUMENTS < /tmp/fuzzdata | tr -d '[:blank:]' > /tmp/mine
            uniq $ARGUMENTS < /tmp/fuzzdata | tr -d '[:blank:]' > /tmp/gnuuniq
            md5sum /tmp/{mine,gnuuniq}
        done
    done
    rm /tmp/{mine,gnuuniq,fuzzdata}
) | awk '{print $1}' | uniq -u | grep -qm1 '.'

if [[ "$?" -eq 1 ]]
then
    echo "Tests passed."
else
    echo "Tests failed."
fi
