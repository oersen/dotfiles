if exists("did_load_filetypes_user")
    finish
endif
let did_load_filetypes_user = 1

augroup filetypedetect
    autocmd BufNewFile,BufRead *.conf setfiletype conf
augroup END
