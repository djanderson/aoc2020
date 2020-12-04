# Fields:
#
# byr (Birth Year)
# iyr (Issue Year)
# eyr (Expiration Year)
# hgt (Height)
# hcl (Hair Color)
# ecl (Eye Color)
# pid (Passport ID)
# cid (Country ID)

BEGIN {
    RS = ""   # enable multiline records
    FS = " "  # "\n" is also a default FS when RS is null str
    required_fields["byr"] = 0
    required_fields["iyr"] = 0
    required_fields["eyr"] = 0
    required_fields["hgt"] = 0
    required_fields["hcl"] = 0
    required_fields["ecl"] = 0
    required_fields["pid"] = 0

    optional_fields["cid"] = 0
}

{
    n = 0
    for (field in required_fields)
        required_fields[field] = 0

    for (i = 1; i <= NF; i++) {
        field = substr($i, 1, 3)
        if (field in required_fields)
            required_fields[field]++
    }
    
    for (field in required_fields)
        n += required_fields[field]

    if (n == length(required_fields))
        nvalid++
}

END {
    print nvalid
}
