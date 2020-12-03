NR != 1 {
    line = $0

    # slope 1
    nright = 1
    depth = (NR - 1) * nright + 1
    while (depth > length(line)) {
        line = line line
    }
    point = substr(line, depth, 1)
    if (point == "#") {
        slope1_hits++
    }

    # slope 2
    nright = 3
    depth = (NR - 1) * nright + 1
    while (depth > length(line)) {
        line = line line
    }
    point = substr(line, depth, 1)
    if (point == "#") {
        slope2_hits++
    }

    # slope 3
    nright = 5
    depth = (NR - 1) * nright + 1
    while (depth > length(line)) {
        line = line line
    }
    point = substr(line, depth, 1)
    if (point == "#") {
        slope3_hits++
    }

    # slope 4
    nright = 7
    depth = (NR - 1) * nright + 1
    while (depth > length(line)) {
        line = line line
    }
    point = substr(line, depth, 1)
    if (point == "#") {
        slope4_hits++
    }

    # slope 5
    if (NR % 2 == 0) {
        next
    }
    nright = 1
    depth = int(NR / 2) * nright + 1
    while (depth > length(line)) {
        line = line line
    }
    point = substr(line, depth, 1)
    if (point == "#") {
        slope5_hits++
    }
}

END {
    ans = slope1_hits * slope2_hits * slope3_hits * slope4_hits * slope5_hits
    printf("%u\n", ans)
}
