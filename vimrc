""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " Sets how many lines of history VIM has to remember
 set history=700
"
" " Enable filetype plugins
 filetype plugin on

"" Highligh
 syntax on

" " Set to auto read when a file is changed from the outside
 set autoread

" " With a map leader it's possible to do extra key combinations
" " like <leader>w saves the current file
 let mapleader = ","
 let g:mapleader = ","

" " Fast saving
 nmap <leader>w :w!<cr>

" " :W sudo saves the file 
" " (useful for handling the permission-denied error)
 command W w !sudo tee % > /dev/null


" Ignore case when searching
set ignorecase

" " When searching try to be smart about cases 
set smartcase


" " Highlight search results
 set hlsearch

" " Makes search act like search in modern browsers
 set incsearch


" Show matching brackets when text indicator is over them
set showmatch


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " Treat long lines as break lines (useful when moving around in them)
 map j gj
 map k gk
"
" " Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
" "map <space> /
" "map <c-space> ?

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " Turn backup off, since most stuff is in SVN, git et.c anyway...
 set nobackup
 set nowb
 set noswapfile

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
 set viminfo^=%

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

"" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" Set local language 
"setlocal spell spelllang=en_us
"setlocal spell spelllang=en_gb
"setlocal spell spelllang=fr
"setlocal spell spelllang=es

nmap <Leader>sf :setlocal spell! spelllang=fr<CR>
nmap <Leader>se :setlocal spell! spelllang=en_gb<CR>

""let g:LatexBox_latexmk_options = "-pvc -pdfps"
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "pdflatex"
let g:Tex_CompileRule_pdf = "pdflatex --src-specials --shell-escape --synctex=1 -interaction=nonstopmode $*"
"let g:Tex_CompileRule_pdf = 'latexmk -pdf'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRule_pdf = 'evince'

"indent
filetype indent on


"let b:tex_flavor = 'pdflatex'
"compiler tex
"set makeprg=pdflatex\ \-file\-line\-error\ \-interaction=nonstopmode
"set errorformat=%f:%l:\ %m

"compile gnuplot
map <F8> : !w <bar> ./% <CR>
"maximaxe window
map <F5> <C-W>_<C-W><Bar>   
"autocompile latex au save du buffer
"au BufWritePost *.tex silent call Tex_RunLaTeX()
""au BufWritePost *.tex silent !pkill -USR1 xdvi.bin
"Read modelines at the end and begging
set modeline

nmap <silent> <F3> :NERDTreeToggle<CR>

"airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline_powerline_fonts = 1

let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#branch#enabled=1

"Buffer movement
:nnoremap <C-n> :bnext<CR>
:nnoremap <C-p> :bprevious<CR>

"Syntastic
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
nnoremap <C-w>E :SyntasticCheck<CR> :SyntasticToggleMode<CR>

"clipboard to use it exterior
set clipboard=unnamedplus

"crtlp directory 
let g:ctrlp_working_path_mode = 'c'

"Nvim-R options
let R_pdfviewer = "evince"
"tmux and R
let R_in_buffer = 0                                     
let R_applescript = 0
let R_tmux_split = 1
let R_assign = 0 "_ not to <-
"let R_setwidth = 0 " need of setwith Console width adapted to window
let R_hl_term = 1 " need of colorout 
autocmd VimLeave * if exists("g:SendCmdToR") && string(g:SendCmdToR) != "function('SendCmdToR_fake')" | call RQuit("nosave") | endif

" Python IDE

augroup vimrc_autocmds
    autocmd!
    " highlight characters past column 120
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%120v.*/
    autocmd FileType python set nowrap
    augroup END

let g:jedi#usages_command = "<leader>z"
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>
