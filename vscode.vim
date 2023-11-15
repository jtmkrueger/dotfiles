" VSCode extension
" START plug ----------------------------
call plug#begin('~/.vim/plugged')
Plug 'andymass/vim-matchup'
Plug 'tpope/vim-surround'
call plug#end()
" END plug ------------------------

let g:loaded_matchit = 1
let mapleader = "\<Space>"
set clipboard=unnamed " copy to system register
set completeopt=menu,menuone,noselect,noinsert

" nunmap <C-w>j
nunmap <C-w>k

" neovim needs to be like vim
nnoremap Y Y
" Easier to type, and I never use the default behavior.
noremap H ^
noremap L $
vnoremap L g_

" up/down on wrapped lines
nnoremap j gj
nnoremap k gk

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

" comment out things
xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

hi MatchParen ctermbg=NONE guibg=NONE cterm=italic gui=italic
