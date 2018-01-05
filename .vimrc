set nocompatible
" Set shell (fixes issue when using the fish shell)
set shell=/bin/zsh

" Pathogen
call pathogen#infect()
call pathogen#helptags()

if has('clipboard')
	if has('unnamedplus')  " When possible use + register for copy-paste
		set clipboard=unnamed,unnamedplus
	else         " On mac and Windows, use * register for copy-paste
		set clipboard=unnamed
	endif
endif

"============ Searching ============"
"Highlight searches by default"
set hlsearch
set showmatch
set incsearch
set showcmd

"============ Tab width ============"
set tabstop=4
set shiftwidth=4
set expandtab "Makes vim substitute tab character with spaces"
set smartindent
set autoindent
set showbreak=...
set modeline
set modelines=5

set backspace=indent,eol,start

"============ Swap files ============"
"No swap files"
set noswapfile
set nobackup
set nowb

"============ Movement ============"
"Move one row instead of one line"
" nmap j gj
" nmap k gk

"============ Auto completion ============"
set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*.obj,*.pdf
set ignorecase
set smartcase

"========== Number toggle ============"
set relativenumber
set number

"========== Theme ============"
syntax enable

if has('gui_running')
	set guioptions-=T           " Remove the toolbar
	set lines=40                " 40 lines of text instead of 24
else
	if &term == 'xterm' || &term == 'xterm-256color' || &term == 'screen'
        " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
		set t_Co=256
	endif
endif

"if has('termguicolors')
"	set termguicolors
"endif

set background=dark

"set term=xterm-256color
"set t_Co=256
"set t_ut=

"set t_8f=^[[38;2;%lu;%lu;%lum
"set t_8b=^[[48;2;%lu;%lu;%lum
"let &t_AB="\e[48;5;%dm"
"let &t_AF="\e[38;5;%dm"

let g:gruvbox_italic=1

colorscheme gruvbox

let python_highlight_all=1

"============ Cursor ============"
"au InsertEnter * hi CursorLine ctermbg=238
function! HighlightLine()
  hi CursorLine ctermbg=237 cterm=NONE
endfunction

function! UnHighlightLine()
  hi CursorLine ctermbg=235 cterm=NONE
endfunction

au InsertEnter * call HighlightLine()
au InsertLeave * call UnHighlightLine()
set cul
call UnHighlightLine()

" conceal in insert (i), normal (n) and visual (v) modes
set concealcursor=inv
" hide concealed text completely unless replacement character is defined
set conceallevel=2

" Auto resource vimrc
au! BufWritePost .vimrc nested source %

"filetype plugin on
filetype indent off

"============ Page width ============"
"set textwidth=80
" hi ColorColumn ctermbg=235
" execute "set colorcolumn=" . join(range(81,82), '|')
set listchars=tab:\>\ ,eol:$,trail:~
set list
hi NonText ctermfg=237

" Set all SpecialKey colors to yellow on red (to get trailing whitespace to
" really pop). We'll fix prepending SpecialKeys with indent_guides later
hi SpecialKey ctermfg=237

"========== Map ============"

let mapleader=" "
nmap <silent> <leader>/ :nohlsearch<CR>
nmap <C-n> :NERDTreeToggle<CR>
nmap <C-h> :TlistToggle<CR>
"nmap <F4> :A<CR>
"nmap <F3> :AV<CR>
nmap do ddO
nmap <leader>w :w<CR>

nnoremap <leader>b :buffers<CR>:buffer<Space>
nnoremap <leader>l :bn<CR>
nnoremap <leader>h :bp<CR>
nnoremap <leader>B :bd<CR>

map <leader>p :CtrlPBuffer<CR>
map <leader>P :CtrlPMRU<CR>
map <leader><leader>p :CtrlPClearAllCaches<CR>
set timeoutlen=600
set ttimeoutlen=600

" Remove trailing whitespace
map <leader>tw :%s/\s\+$//g<CR><C-O>
" Fix indentation
map <leader>in mzgg=G`z<CR><C-O>
"This unsets the last search pattern register by hitting return
nnoremap <silent><CR> :noh<CR>

"== w!! to sudo write =="
command! W execute ':silent w !sudo tee % >/dev/null' | edit!

if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" MacOSX/Linux
set wildignore+=*/tmp/*,*.o,*.so,*.hi,*.pdf,*.swp,*.zip,*/build/*,*.git/*,CMakeLists\.txt\.*
"Windows
"set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

" vim-indent-guides
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=234 ctermfg=238
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=236 ctermfg=240

" vim-airline
set noshowmode
"set statusline=%F\ %y%m\ %=\ %c:(%l/%L)
"set statusline=
"set statusline+=[%n]\ %<%F\ \ \ [%M%R%H%W%Y][%{&ff}]\ \ %=\ line:%l/%L\ col:%c\ \ \ %p%%\ \ \ @%{strftime(\"%H:%M\")}
set laststatus=2
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing', 'long' ]

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.whitespace = 'Ξ'

let airline#extensions#syntastic#error_symbol = '!!:'
let airline#extensions#syntastic#warning_symbol = '>>:'

" enable/disable YCM integration >
let g:airline#extensions#ycm#enabled = 1

" set error count prefix >
let g:airline#extensions#ycm#error_symbol = '!!:'

" set warning count prefix >
let g:airline#extensions#ycm#warning_symbol = '>>:'

let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#buffer_nr_show = 1

"let g:airline_section_y  = airline#section#create(['fileformat'])
"let g:airline#extensions#tmuxline#enabled = 0
"let g:Powerline_symbols = 'fancy'

function! RefreshUI()
  if exists(':AirlineRefresh')
    AirlineRefresh
  else
    " Clear & redraw the screen, then redraw all statuslines.
    redraw!
    redrawstatus!
  endif
endfunction

au BufWritePost .vimrc source $MYVIMRC | :call RefreshUI()

" nerdtree
let NERDTreeIgnore = ["\.pyc", "\.so$", "\.a$", "build/*", "CMakeLists\.txt\..*"]

" syntastic
let g:syntastic_quiet_messages = { "type": "style" }
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

"let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']

"==== Refactor ===="
"Create property
imap <C-c><C-p><C-s> <Esc>:call CreateProperty("string")<CR>a
imap <C-c><C-p><C-i> <Esc>:call CreateProperty("int")<CR>a
function! CreateProperty(type)
  exe "normal bim_\<Esc>b\"yywiprivate ".a:type." \<Esc>A;\<CR>public ".a:type.
        \ " \<Esc>\"ypb2xea\<CR>{\<Esc>oget\<CR>{\<CR>return " .
        \ "\<Esc>\"ypa;\<CR>}\<CR>set\<CR>{\<CR>\<Tab>\<Esc>\"yPa = value;\<CR>}\<CR>}\<CR>\<Esc>"
  normal! 12k2wi
endfunction

"Extract Method
vmap \em :call ExtractMethod()<CR>
function! ExtractMethod() range
  let name = inputdialog("Name of new method:")
  '<
  exe "normal! O\<BS>private " . name ."()\<CR>{\<Esc>"
  '>
  exe "normal! oreturn ;\<CR>}\<Esc>k"
  s/return/\/\/ return/ge
  normal! j%
  normal! kf(
  exe "normal! yyPi// = \<Esc>wdwA;\<Esc>"
  normal! ==
  normal! j0w
endfunction

"========== OmniSharp ============"

" OmniSharp won't work without this setting
filetype plugin on

"This is the default value, setting it isn't actually necessary
let g:OmniSharp_host = "http://localhost:2000"

"Set the type lookup function to use the preview window instead of the status line
let g:OmniSharp_typeLookupInPreview = 1

"Timeout in seconds to wait for a response from the server
let g:OmniSharp_timeout = 1

"Showmatch significantly slows down omnicomplete
"when the first match contains parentheses.
set noshowmatch

"Super tab settings - uncomment the next 4 lines
"let g:SuperTabDefaultCompletionType = 'context'
"let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
"let g:SuperTabDefaultCompletionTypeDiscovery = ["&omnifunc:<c-x><c-o>","&completefunc:<c-x><c-n>"]
"let g:SuperTabClosePreviewOnPopupClose = 1

"don't autoselect first item in omnicomplete, show if only one item (for preview)
"remove preview if you don't want to see any documentation whatsoever.
set completeopt=longest,menuone,preview
" Fetch full documentation during omnicomplete requests.
" There is a performance penalty with this (especially on Mono)
" By default, only Type/Method signatures are fetched. Full documentation can still be fetched when
" you need it with the :OmniSharpDocumentation command.
" let g:omnicomplete_fetch_documentation=1

"Move the preview window (code documentation) to the bottom of the screen, so it doesn't move the code!
"You might also want to look at the echodoc plugin
set splitbelow

" Get Code Issues and syntax errors
let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
" If you are using the omnisharp-roslyn backend, use the following
" let g:syntastic_cs_checkers = ['code_checker']
augroup omnisharp_commands
    autocmd!

    "Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
    autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

    " Synchronous build (blocks Vim)
    "autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
    " Builds can also run asynchronously with vim-dispatch installed
    autocmd FileType cs nnoremap <leader>b :wa!<cr>:OmniSharpBuildAsync<cr>
    " automatic syntax check on events (TextChanged requires Vim 7.4)
    autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

    " Automatically add new cs files to the nearest project on save
    autocmd BufWritePost *.cs call OmniSharp#AddToProject()

    "show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    "The following commands are contextual, based on the current cursor position.

    autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
    autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
    autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
    autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
    autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
    "finds members in the current buffer
    autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr>
    " cursor can be anywhere on the line containing an issue
    autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
    autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
    autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
    autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
    "navigate up by method/property/field
    autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr>
    "navigate down by method/property/field
    autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr>

augroup END


" this setting controls how long to wait (in ms) before fetching type / symbol information.
set updatetime=500
" Remove 'Press Enter to continue' message when type information is longer than one line.
set cmdheight=2

" Contextual code actions (requires CtrlP or unite.vim)
nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
" Run code actions with text selected in visual mode to extract method
vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>

" rename with dialog
nnoremap <leader>nm :OmniSharpRename<cr>
nnoremap <F2> :OmniSharpRename<cr>
" rename without dialog - with cursor on the symbol to rename... ':Rename newname'
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

" Force OmniSharp to reload the solution. Useful when switching branches etc.
nnoremap <leader>rl :OmniSharpReloadSolution<cr>
nnoremap <leader>cf :OmniSharpCodeFormat<cr>
" Load the current .cs file to the nearest project
nnoremap <leader>tp :OmniSharpAddToProject<cr>

" Add syntax highlighting for types and interfaces
nnoremap <leader>th :OmniSharpHighlightTypes<cr>
"Don't ask to save when changing buffers (i.e. when jumping to a type definition)
set hidden

"======== YouCompleteMe ========="

let g:ycm_server_python_interpreter = '/usr/bin/python3'
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"

" Settings for integration with Airline
let g:ycm_error_symbol = '!!'
let g:ycm_warning_symbol = '>>'

" Additional autocomplete settings
let g:ycm_complete_in_comments = 0
let g:ycm_complete_in_strings = 1

let g:ycm_min_num_of_chars_for_completion = 99
let g:ycm_autoclose_preview_window_after_completion = 1
"======== Python with virtualenv support ======"
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF
