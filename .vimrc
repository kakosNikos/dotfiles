set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax on
set number

set shiftwidth=4 smarttab
set expandtab
set tabstop=8 softtabstop=0
packadd! dracula
syntax enable
colorscheme dracula

set clipboard=autoselect
set mouse=v

set backspace=indent,eol,start

" some weird ass stuff written by chatGPT. Adds the :B command which switch to
" a buffer in an existing tab.

function! SwitchToBufferInTab(buffer)
  let bufnum = bufnr(a:buffer)
  let tabnum = tabpagenr()
  let winnum = tabpagewinnr(tabnum)

  " Check for existing tab with buffer
  let found_tabnum = -1
  for i in range(1, tabpagenr('$'))
    if i != tabnum
      let bufwin = tabpagebuflist(i)
      for j in range(len(bufwin))
        if bufwin[j] == bufnum
          let found_tabnum = i
          break
        endif
      endfor
    endif
    if found_tabnum != -1
      break
    endif
  endfor

  " Switch to existing tab or open new tab
  if found_tabnum != -1
    execute found_tabnum . "tabnext"
    execute winnum . "wincmd w"
  else
    execute "tabnew " . a:buffer
  endif
endfunction

command! -nargs=1 -complete=buffer B call SwitchToBufferInTab(<f-args>)
