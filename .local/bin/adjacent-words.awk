#!/usr/bin/awk -f

FNR == 1 {
    last = ""
}

{
    gsub(/[^[:alnum:][:blank:]]/, " ")

    $0 = tolower($0)

    if (NF == 0) {
        next
    }

    if ($1 == last) {
        printf "%s: %d: %s\n", FILENAME, FNR, $1
    }

    for (i = 2; i <= NF; ++i) {
        if ($i == $(i - 1)) {
            printf "%s: %d: %s\n", FILENAME, FNR, $i
        }
    }

    last = $NF
}
