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
    max_seat_id = max(id, max_seat_id)
}

END {
    print max_seat_id
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


function max(m, n)
{
    return m > n ? m : n
}
