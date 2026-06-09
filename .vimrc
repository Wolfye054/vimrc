set tabstop=4
set shiftwidth=4
set splitright
set clipboard=unnamedplus
filetype plugin indent on
syntax on

augroup MyHighlights
  autocmd!
  autocmd ColorScheme * highlight Normal     ctermfg=white
  autocmd ColorScheme * highlight Comment    ctermfg=grey
  autocmd ColorScheme * highlight Constant   ctermfg=red
  autocmd ColorScheme * highlight Special    ctermfg=magenta
  autocmd ColorScheme * highlight PreProc    ctermfg=magenta
  autocmd ColorScheme * highlight Type       ctermfg=blue
  autocmd ColorScheme * highlight Statement  ctermfg=yellow
  autocmd ColorScheme * highlight Keyword    ctermfg=yellow
  autocmd ColorScheme * highlight Todo       ctermfg=black ctermbg=white
  autocmd ColorScheme * highlight Search     ctermfg=black ctermbg=white
  autocmd ColorScheme * highlight Visual     ctermfg=black ctermbg=white
  autocmd ColorScheme * highlight Identifier ctermfg=blue
augroup END

colorscheme default

command! -nargs=* -complete=file BR call RunBar(<q-args>)
command! -nargs=* -complete=file R  call RunProgram(<q-args>)
command! B  call RunBuild()

function! s:OpenTerm(cmd, cwd)
  " Reuse existing terminal if possible
  if exists('g:bar_term_buf') && bufexists(g:bar_term_buf)
    let l:win = bufwinid(g:bar_term_buf)
    if l:win != -1
      call win_gotoid(l:win)
      execute 'bwipeout!'
    endif
  endif

  " Start terminal
  let g:bar_term_buf = term_start(['sh', '-c', a:cmd], {
        \ 'cwd': a:cwd,
        \ 'term_name': 'build-run',
        \ 'vertical': 1
        \ })
endfunction

function! s:FindBuildDir()
  let l:build = findfile('build.sh', '.;')
  if empty(l:build)
    echo "build.sh not found"
    return ''
  endif
  return fnamemodify(l:build, ':p:h')
endfunction

function! s:FindRunScript()
  let l:run = findfile('run.sh', '.;')
  if empty(l:run)
    return ''
  endif
  return fnamemodify(l:run, ':p')
endfunction

function! RunProgram(args)
  let l:dir = s:FindBuildDir()
  if empty(l:dir) | return | endif

  let l:cmd = '../build/debug'
  if !empty(a:args)
    let l:cmd .= ' ' . a:args
  endif

  call s:OpenTerm(l:cmd, l:dir)
endfunction

function! RunBar(args)
  let l:dir = s:FindBuildDir()
  if empty(l:dir) | return | endif

  let l:cmd = './build.sh && ../build/debug'
  if !empty(a:args)
    let l:cmd .= ' ' . a:args
  endif

  call s:OpenTerm(l:cmd, l:dir)
endfunction

function! RunBuild()
  let l:dir = s:FindBuildDir()
  if empty(l:dir) | return | endif
  call s:OpenTerm('./build.sh', l:dir)
endfunction
