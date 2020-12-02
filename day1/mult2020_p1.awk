BEGIN {
    while (getline < ARGV[1] > 0)
        A[++n] = $0;
}

{
    b = $0;
    for (i = NR + 1; i <= n; i++) {
        a = A[i];
        if (a + b == 2020) {
            print a * b;
            exit
        }
    }
}

END {
    printf "a: %s\n", a;
    printf "b: %s\n", b;
}
