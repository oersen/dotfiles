if exists("b:undo_ftplugin")
    let b:undo_ftplugin ..= " | "
else
    let b:undo_ftplugin = ""
endif
let b:undo_ftplugin ..= "setlocal textwidth<"

setlocal textwidth=79
