#!/usr/bin/awk -f

{
    if (NF == 0) {
        next
    }

    for (i = 1; i <= NF; ++i) {
        cur_length = length($i)

        if (cur_length > max_length) {
            file = FILENAME
            longest_word = $i
            max_length = cur_length
        }
    }
}

END {
    printf "%s (%d characters):\t%s\n", file, max_length, longest_word
}
