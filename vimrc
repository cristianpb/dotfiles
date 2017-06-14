""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype plugin on

" Highligh
syntax on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations like <leader>w
" saves the current file
let mapleader = ','
let g:mapleader = ','
let maplocalleader = ';'
let g:maplocalleader = ';'

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Show matching brackets when text indicator is over them
set showmatch

" Indent
filetype indent on

" Insert space characters whenever the tab key is pressed
set tabstop=4
set shiftwidth=4
set expandtab

" Read modelines at the end and begging
set modeline

" Vim insert delete over line breaks, or automatically-inserted indentation
"set backspace=indent,eol,start

" Set relative numbers
"set relativenumber

" Position of cursor
"set ruler

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Save movements larger than 5 lines to the jumplist.
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

" Buffer movement
:nnoremap <C-n> :bnext<CR>
:nnoremap <C-p> :bprevious<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
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

" Clipboard to use it exterior
"set clipboard=unnamedplus
"set clipboard=unnamed

" Format-Flowed text
setlocal fo+=aw

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" Set local language (en_us, en_gb, fr, es)
nmap <Leader>sf :setlocal spell! spelllang=fr<CR>
nmap <Leader>sl :setlocal spell! spelllang=es<CR>
nmap <Leader>se :setlocal spell! spelllang=en_gb<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Shortcuts
map <F8> : !w <bar> ./% <CR> " Compile
nnoremap <F5> :w <CR> :!make <CR> " Makefile

"" Vundle 
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'benmills/vimux'
Plugin 'davidhalter/jedi-vim'
Plugin 'edkolev/promptline.vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'epeli/slimux'
Plugin 'honza/vim-snippets'
Plugin 'itchyny/calendar.vim'
Plugin 'jalvesaq/Nvim-R'
"Plugin 'jgors/vimux-ipy'
Plugin 'junegunn/vim-easy-align'
Plugin 'lervag/vimtex' "Latex suite that replace gerw/vim-latex-suite
Plugin 'majutsushi/tagbar'
Plugin 'pangloss/vim-javascript'
Plugin 'roxma/vim-paste-easy'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'sirver/ultisnips'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'ryanoasis/vim-devicons'
Plugin 'easymotion/vim-easymotion'
Plugin 'junegunn/vim-emoji'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'othree/html5.vim'
Plugin 'luochen1990/rainbow'
Plugin 'maralla/completor.vim'
Plugin 'vimwiki/vimwiki'
call vundle#end()            " required
filetype plugin indent on    " required

" NerdTreeToogle
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
nmap <silent> <F3> :NERDTreeToggle<CR>

" Airline
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#hunks#enabled=0
let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'

" Tmuxline
let g:airline#extensions#tmuxline#enabled = 1
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'b'    : '#(~/Documents/Script/new_mail.sh)',
      \'win'  : ['#W'],
      \'cwin' : '#F #W',
      \'y'    : '#(~/Documents/Script/tmux-slack-notifier.sh)',
      \'z'    : '%R'}

" Promptline
"":PromptlineSnapshot! .shell_prompt.sh airline
let g:promptline_preset = {
        \'a'    : [ promptline#slices#host() ],
        \'b'    : [ promptline#slices#cwd() ],
        \'c'    : [ promptline#slices#vcs_branch() ],
        \'warn' : [ promptline#slices#last_exit_code() ],
        \'z'    : [ promptline#slices#python_virtualenv() ]}



" Nvim-R options
let R_pdfviewer = 'zathura'
let R_in_buffer = 0 " tmux and R
let R_applescript = 0
let R_tmux_split = 1
let R_assign = 0 " disable _ to <-
"let R_setwidth = 0 " need of setwith Console width adapted to window
let R_hl_term = 1 " need of colorout 
autocmd VimLeave * if exists("g:SendCmdToR") && string(g:SendCmdToR) != "function('SendCmdToR_fake')" | call RQuit("nosave") | endif

" Jedi
let python_highlight_all = 1
let g:jedi#completions_command = '<C-N>'
let g:jedi#usages_command = '<leader>z'
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
let g:jedi#max_doc_height = 30
let g:jedi#smart_auto_mappings = 0 " no automatic import after from
"map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

" UltiSnips
let g:UltiSnipsEditSplit='vertical' " If you want :UltiSnipsEdit to split your window.
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger='<tab>'
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
set runtimepath+=~/.vim/my-snippets
let g:UltiSnipsSnippetsDir='~/.vim/my-snippets'

" Vimux Vslime
let g:VimuxUseNearest = 1
let g:VimuxHeight = '30'
map <Leader>vp :VimuxPromptCommand<CR> 
map <Leader>rb :call VimuxRunCommand("")<CR> " Run the current file with rspec
function! VimuxSlime()
 call VimuxSendText(@v)
 call VimuxSendKeys('Enter')
endfunction

" Slimux
let g:slimux_python_ipython = 1
"nnoremap <C-c><C-c> :SlimuxREPLSendLine<CR>
"vnoremap <C-c><C-c> :SlimuxREPLSendLine<CR>
"nnoremap <C-c><C-v> :SlimuxREPLConfigure<CR>
map <Leader>s :SlimuxREPLSendLine<CR>
vmap <Leader>s :SlimuxREPLSendSelection<CR>
"map <Leader>b :SlimuxREPLSendBuffer<CR>
"map <Leader>a :SlimuxShellLast<CR>
"map <Leader>k :SlimuxSendKeysLast<CR>

" Vimuxslime
" If text is selected, save it in the v buffer and send that buffer it to tmux
vmap <LocalLeader><ENTER> "vy :call VimuxSlime()<CR>
" Select current paragraph and send it to tmux
nmap <LocalLeader><ENTER> vip<LocalLeader>vs<CR>

" Easy Align
"" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
"" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Syntastic
nnoremap <leader>sc :SyntasticToggleMode<CR> 
let g:syntastic_mode_map                 = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_enable_highlighting      = 1 " Highlight
let g:syntastic_auto_loc_list            = 1 " No erros list
let g:syntastic_enable_signs             = 1 " No sign column
let g:syntastic_check_on_open            = 1
let g:syntastic_check_on_wq              = 0
" Use vint for vim style
let g:syntastic_vim_checkers=['vint'] " requires vint: pip install vim-vint

" Tagbar
nmap <F6> :TagbarToggle<CR>

" Solarized
let g:solarized_termcolors = 16
set background=dark
colorscheme solarized
let g:solarized_termtrans = 1
syntax enable


" Fugitive
set diffopt+=vertical "Vertical split by default

" Folding
"set foldmethod=indent
"set foldnestmax=2

" Git gutter (Git diff)
let g:gitgutter_enabled=0
nnoremap <silent> <leader>d :GitGutterToggle<cr>

" Calendar
"let g:calendar_google_calendar = 1

" Emoji completion for md files (:app<CTRL-X><CTRL-U> to find :apple:)
setlocal completefunc=emoji#complete

" JavaScript vim
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

" Vimwiki
let g:vimwiki_list = [{'path': '~/vimwiki', 'template_path': '~/vimwiki/templates/',
          \ 'template_default': 'default', 'syntax': 'markdown', 'ext': '.wiki',
          \ 'path_html': '~/vimwiki/site_html/', 'custom_wiki2html': 'vimwiki_markdown',
          \ 'template_ext': '.tpl'}]

nmap <silent> <leader>wah :VimwikiAll2HTML<cr>
let g:vimwiki_table_mappings = 0

" Raibow parenteses
let g:rainbow_active = 0 "0 if you want to enable it later via :RainbowToggle
nmap <leader>R :RainbowToggle<cr>
