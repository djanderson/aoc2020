NR != 1 {
    line = $0
    depth = (NR - 1) * 3 + 1
    while (depth > length(line)) {
        line = line line
    }
    point = substr(line, depth, 1)
    if (point == "#") {
        hits++
    }
}

END {
    print hits
}
