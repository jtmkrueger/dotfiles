" VSCode extension
" START plug ----------------------------
call plug#begin('~/.vim/plugged')
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-rails'
call plug#end()
" END plug ------------------------

let mapleader = "\<Space>"
set clipboard=unnamed " copy to system register
set completeopt=menu,menuone,noselect,noinsert
set incsearch " highlight search pattern as it's typed
set ignorecase " searches are case insensitive...
set smartcase " ... unless they contain at least one capital letter
set scrolloff=5 " 5 line buffer below cursor when scrolling

" nunmap <C-w>j
nunmap <C-w>k

" neovim needs to be like vim
nnoremap Y Y
" Easier to type, and I never use the default behavior.
" noremap H ^
" noremap L $
" vnoremap L g_

" up/down on wrapped lines
nmap j gj
nmap k gk
vmap j gj
vmap k gk

" Reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" make . work in visual mode
:vnoremap . :norm.<cr>

" clear search highlights with enter
nnoremap <CR> :silent! nohls<CR>

" very VSCode specific
" find word under cursor across all files
nnoremap ? <Cmd>call VSCodeNotify('workbench.action.findInFiles', { 'query': expand('<cword>')})<CR>
nnoremap - <Cmd>call VSCodeNotify('vsnetrw.open')<CR>

" comment out things
xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

hi MatchParen ctermbg=NONE guibg=NONE cterm=italic gui=italic
