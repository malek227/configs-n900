"    File: $HOME/etc/vimrc
"  Author: Magnus Woldrich <m@japh.se>
" Created: 2009-04-24
" Updated: 2011-07-27 12:34:02
"    What: Highly optimized for Perl, C, Viml and Lua hacking.

let &t_Co=256

set nocompatible
syntax on
"set autoread
set autoindent
set backspace=start,indent,eol
set cmdheight=2
set complete=.,w,b,u,t,i,d,k,kspell
set cinoptions=:0,l1,t0,g0,(0
set cinwords=if,else,elsif,while,do,for,foreach,given,when,switch,case
set diffopt=filler,iwhite,context:4,vertical
set display+=lastline,uhex
set expandtab
set foldmethod=marker
set foldenable
set formatoptions=tcrqln1
set grepprg=ack\ -a
set guioptions-=m
set guioptions-=T
set helpheight=60
set hidden
set history=50
set hlsearch
set ignorecase
set isfname+=:
set laststatus=2
set magic
set makeprg=/usr/bin/make
set maxfuncdepth=200
set maxmem=200
set maxmemtot=2000
set modeline
set modelines=1
set nobackup
set nocscopeverbose
set noequalalways
set noerrorbells
set nostartofline
set noswapfile
set nowritebackup
set nowrap
set nrformats=octal,hex
set numberwidth=2
set preserveindent
set pumheight=3

set report=0
set ssop=buffers,folds,globals,help,localoptions,options,resize,tabpages
set shiftwidth=2
set smartcase
set smarttab
set synmaxcol=72
set scrolloff=5
set tabstop=2
"set timeout
"set timeoutlen=3000
"set ttimeoutlen=50
set textwidth=80

set notitle
set nottyfast
set ttyscroll=15

set visualbell t_vb=
"set viminfo=h,'100,\"100,:20,%,n~/var/vim/viminfo
set virtualedit=block
set wildchar=<Tab>
set wildmode=list:longest,full
set wildignore=*.swp,*.bak,*~,blib,*.o,*.png,*.jpe?g
set whichwrap=b,s,h,l,<,>
"set nomore

let &t_Co = 256
"color peachpuff
"set nolist
""call pathogen#runtime_append_all_bundles()

let mapleader = ';'
colorscheme  neverland-darker-shiva

"nnoremap <silent> <leader>å :%s/\v\d+/\=submatch(0) + 1/g<CR>  :normal gg<CR>
"nmap <leader>O :%w >> ~/vim_output<CR>
"nmap <leader>o :exec ':.w >> ' . eval(string( xclipboard_pipe_path ))<CR>

" searching                                                                  {{{
"nnoremap <silent> ! *:call HL_Search_Cword()<CR>
"nnoremap <silent> # #:call HL_Search_Cword()<CR>
"nnoremap <silent> * *:call HL_Search_Cword()<CR>
"nnoremap <silent> N N:call HL_Search_Cword()<CR>
"nnoremap <silent> n n:call HL_Search_Cword()<CR>
"nnoremap <CR>   zA       " toggle folds recursively
"nnoremap '      `        " switch ' and ` ...
nnoremap `      '        " ... and do the right thing
cmap     qq     qa!<CR>  " quit really, really fast
nnoremap ``     ''       " switch those two as well
nnoremap ''     ``       " '' now goes back to where cursor were before mark
nmap     <C-9>  <C-]>    " my ALT key is all jelly
nmap     Y      y$       " do what Y is supposed to do; d$ <=> D etc

cnoremap $h     e ~/     " quick edit ~/
cnoremap $d     e ~/dev  " quick edit ~/dev
cnoremap $.     e .      " quick edit ./



map <C-J> <C-W>j<C-W>_
map <C-h> <C-w><Left>
map <C-h> <C-w><Left>
map <C-h> <C-w><Left>
map <C-j> <C-w><Down>

nnoremap <C-W>J :exe 'resize ' . winheight(0) / 2<CR>
nnoremap <C-W>K :exe 'resize ' . winheight(0) * 2<CR>
"map \| :vsplit<CR>
vnoremap S :        sort<CR>

" make those behave like ci' , ci"
nnoremap ci( f(ci(
nnoremap ci{ f{ci{
nnoremap ci[ f[ci[

vnoremap ci( f(ci(
vnoremap ci{ f{ci{
vnoremap ci[ f[ci[

" Titlecase The Current Line, thank you
nnoremap U          :s/\v[a-zåäö]+/\u&/g<CR>

" movement                                                                   {{{
nnoremap J  10j
nnoremap K  10k
vnoremap J  10j
vnoremap K  10k

inoremap jj <ESC>
inoremap jk <ESC>
nnoremap     <leader><TAB> :call ToggleSpell()<CR>
map <leader>cd :cd %:p:h<CR>

nnoremap <silent> <C-l> :noh<CR><C-l>

nnoremap <C-n>     :bnext<CR>
nnoremap <C-p>     :bprev<CR>
nnoremap 	   :ls<CR> :buffer<space>
nnoremap <leader>b :ls<CR>:buffer<space>
nnoremap <leader>g :e#<CR>
nnoremap <leader>l :ls<CR>

nnoremap <leader>1 :set ft=perl<CR>
nnoremap <leader>2 :set ft=c<CR>
nnoremap <leader>3 :set ft=lua<CR>
nnoremap <leader>4 :set ft=bash<CR>
nnoremap <leader>5 :set ft=config<CR>
nnoremap <leader>6 :set ft=vim<CR>

nnoremap <leader>7 :7b<CR>
nnoremap <leader>8 :8b<CR>
nnoremap <leader>9 :9b<CR>
nnoremap <leader>0 :10b<CR>

"nnoremap *     :1b<CR>
"nnoremap "     :2b<CR>
"nnoremap £     :3b<CR>
"nnoremap $     :4b<CR>
"nnoremap €     :5b<CR>
"nnoremap ¥     :6b<CR>
"nnoremap {     :7b<CR>
"nnoremap [     :8b<CR>
"nnoremap ]     :9b<CR>
"nnoremap <leader>a :bdelete!<CR>

nnoremap <leader>f :set paste<CR>
nnoremap <leader>s :call RemoveTrailingCrap()
nnoremap <leader>v V`]

cnoremap <c-a>   <home>
cnoremap <c-e>   <end>
cnoremap <c-b>   <left>
cnoremap <c-d>   <del>
cnoremap <c-f>   <right>
cnoremap <C-_>   <c-f>

cnoremap <c-n>   <down>
cnoremap <c-p>   <up>
cnoremap <C-*>   <c-a>
cnoremap <c-j>   <down>
cnoremap <c-k>   <up>
nnoremap <c-j>    <down>
nnoremap <c-k>    <up>

cnoremap <C-h> <S-Left>
cnoremap <C-l> <S-Right>
