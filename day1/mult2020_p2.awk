BEGIN {
    while (getline < ARGV[1] > 0)
        A[++n] = $0;
}

{
    a = $0;
    for (i = NR + 1; i < n; i++) {
        b = A[i];
        for (j = i + 1; j <= n; j++) {
            c = A[j];
            if (a + b + c == 2020) {
                print a * b * c;
                exit
            }
        }
    }
}

END {
    printf "a: %s\n", a;
    printf "b: %s\n", b;
    printf "c: %s\n", c;
}
