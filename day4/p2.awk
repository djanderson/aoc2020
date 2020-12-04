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
    split("byr iyr eyr hgt hcl ecl pid", required_fields)
    required_fields["byr"] = ""
    required_fields["iyr"] = ""
    required_fields["eyr"] = ""
    required_fields["hgt"] = ""
    required_fields["hcl"] = ""
    required_fields["ecl"] = ""
    required_fields["pid"] = ""

    nvalid = 0
}

{
    # Reset state
    n = 0
    for (field in required_fields)
        required_fields[field] = ""

    for (i = 1; i <= NF; i++) {
        split($i, field_value, ":")
        field = field_value[1]
        value = field_value[2]
        if (field in required_fields) {
            required_fields[field] = value
        }
    }
    
    for (field in required_fields) {
        value = required_fields[field]
        if (value == "")
            continue
        
        validator = "validate_" field
        if (@validator(value))  # gawk-specific syntax
            n++
    }

    if (n == 7)  # there are 7 required fields
        nvalid++
}

END {
    print nvalid
}

function validate_byr(byr)
{
    if (match(byr, "^[12][09][0-9][0-9]$")) {
        yr = int(byr)
        if (yr >= 1920 && yr <= 2002) {
            return 1
        }
    }
    return 0
}

function validate_iyr(iyr)
{
    if (match(iyr, "20[12][0-9]")) {
        yr = int(iyr)
        if (yr >= 2010 && yr <= 2020) {
            return 1
        }
    }
    return 0
}

function validate_eyr(eyr)
{
    if (match(eyr, "^20[23][0-9]$")) {
        yr = int(eyr)
        if (yr >= 2020 && yr <= 2030) {
            return 1
        }
    }
    return 0
}

function validate_hgt(hgt)
{
    if (index(hgt, "in")) {
        inches = int(substr(hgt, 1, index(hgt, "in")))
        return (inches >= 59 && inches <= 76)
    } else if (index(hgt, "cm")) {
        cm = int(substr(hgt, 1, index(hgt, "cm")))
        return (cm >= 150 && cm <= 193)
    }
    return 0
}

function validate_hcl(hcl)
{
    return match(hcl, "^#[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]$")
}

function validate_ecl(ecl)
{
    valid_ecl["amb"]
    valid_ecl["blu"]
    valid_ecl["brn"]
    valid_ecl["gry"]
    valid_ecl["grn"]
    valid_ecl["hzl"]
    valid_ecl["oth"]
    return ecl in valid_ecl
}

function validate_pid(pid)
{
    return match(pid, "^[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]$")
}
