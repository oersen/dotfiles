if exists("b:undo_indent")
    let b:undo_indent ..= " | "
else
    let b:undo_indent = ""
endif
let b:undo_indent ..= "setlocal shiftwidth< softtabstop<"

setlocal shiftwidth=2 softtabstop=2
