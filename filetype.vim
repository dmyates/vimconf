" Make some new filetypes

if exists("did_load_filetypes")
	finish
endif
augroup filetypedetect
	au! BufRead, BufNewFile *.jade	setfiletype jade
augroup END

