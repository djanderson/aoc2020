{
    split($1, range, "-")
    i1 = range[1]
    i2 = range[2]
    letter = substr($2, 1, 1)
    password = $3

    n = substr(password, i1, 1) == letter
    n += substr(password, i2, 1) == letter
    if (n == 1)
        valid++
}

END {
    print valid
}
