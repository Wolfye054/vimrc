set tabstop=4
set shiftwidth=4
set splitright
filetype plugin indent on

syntax on
augroup MyHighlights
  autocmd!
  autocmd ColorScheme * highlight Normal 	ctermfg=white
  autocmd ColorScheme * highlight Comment 	ctermfg=grey
  autocmd ColorScheme * highlight Constant 	ctermfg=red
  autocmd ColorScheme * highlight Special 	ctermfg=magenta
  autocmd ColorScheme * highlight PreProc	ctermfg=magenta
  autocmd ColorScheme * highlight Type    	ctermfg=blue
  autocmd ColorScheme * highlight Statement	ctermfg=yellow
  autocmd ColorScheme * highlight Keyword 	ctermfg=yellow
  autocmd ColorScheme * highlight Todo		ctermfg=black ctermbg=white
  autocmd ColorScheme * highlight Search 	ctermfg=black ctermbg=white
  autocmd ColorScheme * highlight Visual 	ctermfg=black ctermbg=white
augroup END
:colorscheme default

