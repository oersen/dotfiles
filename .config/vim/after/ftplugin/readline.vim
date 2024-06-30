if exists("b:undo_ftplugin")
    let b:undo_ftplugin ..= " | "
else
    let b:undo_ftplugin = ""
endif
let b:undo_ftplugin ..= "unlet g:readline_has_bash"

let g:readline_has_bash = 1
