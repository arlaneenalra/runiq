runiq
=====

Runiq functions in a manner quite similar to GNU uniq, but runiq allows you to
specify keys based on regular expressions in stead of field or the first `N`
characters. Runiq takes most of the options that uniq does but omits the
character and field related arguments `--check-chars`, `--skip-fields`, and
`--skip-chars` since the same funtionality can be achieved using Perl regular
expressions.

New Arguments
-------------

### -e, --regex ###
This arguments accepts a Perl-compatible regular expression whose grouping
pairs are used to define the keys for determining the uniqueness of a line. If
a regular expression is not defined, the entire line is used as the comparison
key.

### -l, --discard-lines ###
When this argument is given, all lines that do not match the regular expression
will simply be ingored.

Examples
--------

Counting things with arbitrary descriptions:

    sinister:runiq [1]$ cat animals
    gigantic ferocious man-eating duck
    tiny little cow
    humongous cow warrior
    tiny cow peasant
    massive horse
    1337_ha><0rz_horse_1970_01_01

    sinister:runiq [2]$ runiq --regex '.*(cow|horse|duck).*' --count animals
          1 gigantic ferocious man-eating duck
          3 tiny cow peasant
          2 1337_ha><0rz_horse_1970_01_01

Other Arguments
---------------

### -c, --count ###
Prefix lines by the number of occurrences

### -d, --repeated ###
Only print duplicate lines

### -D, --all-repeated[=delimit-method] ###
Print all duplicate lines delimit-method={none(default),prepend,separate}
Delimiting is done with blank lines

### -i, --ignore-case ###
ignore differences in case when comparing

### -u, --unique ###
Only print unique lines

### -z, --zero-terminated ###
End lines with 0 byte, not newline

### --help ###
Display help and exit

Notes
-----

Right now, the program is not quite as useful as it could be when the input
needs to be sorted. I will create an rsort to complement this script to allow
sorting based on regular expressions.
