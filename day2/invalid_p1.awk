{
    split($1, range, "-")
    lower_bound = range[1]
    upper_bound = range[2]
    letter = substr($2, 1, 1)
    password = $3

    n = count(password, letter)
    if (n >= lower_bound && n <= upper_bound)
        valid++
}

END {
    print valid
}

# Return the number of characters `c` in string `s`
function count(s, c) {
    return split(s, _, c) - 1
}
