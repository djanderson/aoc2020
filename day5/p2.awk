# Binary Space Partitioning
# Rows (128)
# F - front (lower number) half of rows
# B - back (higher number) half of rows
# First 7 characters will be F or B
# ex: FBFBBFFRLR -> row 44
#
# Columns (8)
# L - left (lower) half of columns
# R - right (higher) half of columns
# Last 3 characters will be L or R
# ex: FBFBBFFRLR -> column 5
#
# Seat ID
# row * 8 + column
# ex: FBFBBFFRLR -> seat id 357

{
    r = row($0)
    c = col($0)
    id = seat_id(r, c)
    ids[NR] = id
}

END {
    qsort(ids, 1, NR)

    for (i = 2; i < NR; i++) {
        id = ids[i]
        if (id != ids[i - 1] + 1) {
            print id - 1
            break
        }
        if (id != ids[i + 1] - 1) {
            print id + 1
            break
        }
    }
}

function row(bpass,    r, row_bsp, ch)
{
    r = 0
    row_bsp = substr(bpass, 1, 7)

    for (i = 1; i <= 7; i++) {
        ch = substr(row_bsp, i, 1)
        if (ch == "B") {
            r += int(128 / (2^i))
        } else if (ch != "F") {
            print "got row char that's not F or B"
            exit
        }
        #printf("i: %d, ch: %s, row: %d\n", i, ch, r);
    }

    return r
}

function col(bpass,    c, col_bsp, ch)
{
    c = 0
    col_bsp = substr(bpass, 8, 9)

    for (i = 1; i <= 3; i++) {
        ch = substr(col_bsp, i, 1)
        if (ch == "R") {
            c += int(8 / (2^i))            
        } else if (ch != "L") {
            print "got column char that's not L or R"
            exit
        }
        #printf("i: %d, ch: %s, col: %d\n", i, ch, c);
    }

    return c
}

function seat_id(row, col)
{
    return row * 8 + col
}

# Straight out of The AWK Programming Language, pg 161
function qsort(A, left, right,    i, last)
{
    if (left >= right)          # less than 2 elements remain
        return

    swap(A, left, left + int((right - left + 1) * rand()))
    last = left
    
    for (i = left + 1; i <= right; i++)
        if (A[i] < A[left])
            swap(A, ++last, i)
    
    swap(A, left, last)
    qsort(A, left, last - 1)
    qsort(A, last + 1, right)
}

function swap(A, i, j,    t)
{
    t = A[i]
    A[i] = A[j]
    A[j] = t
}

function max(m, n)
{
    return m > n ? m : n
}
