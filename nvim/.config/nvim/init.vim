"*****************************************************************************
" Vim-Plug core
"*****************************************************************************

if has('vim_starting')
  set nocompatible               " Be iMproved
endif

let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

let g:vim_bootstrap_langs = ""
let g:vim_bootstrap_editor = "nvim"				" nvim or vim

if !filereadable(vimplug_exists)
  echo "Installing Vim-Plug..."
  echo ""
  silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:not_finish_vimplug = "yes"

  " Run shell script if exist on custom select language

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.config/nvim/plugged'))

"*****************************************************************************
" Plugins
"*****************************************************************************

" Core
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'

" Easy movement around text
Plug 'Lokaltog/vim-easymotion'

" Better bullet points
Plug 'dkarter/bullets.vim'

" Fuzzy search
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Color schemes
Plug 'drewtempelmeyer/palenight.vim'
Plug 'nightsense/snow'
Plug 'cocopon/iceberg.vim'

" Generate ctags automatically
Plug 'ludovicchabant/vim-gutentags'

" GUI for the undo tree
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}

" Rearrange text into tables
Plug 'godlygeek/tabular', {'on': 'Tabularize'}

" Match HTML tags
Plug 'Valloric/MatchTagAlways'

" Distraction-free writing mode
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}

" Qdo command for search/replace in quickfix list
Plug 'henrik/vim-qargs'

" Syntax highlighting
Plug 'sheerun/vim-polyglot'

" Completion / Snippets
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'epilande/vim-es2015-snippets'
Plug 'epilande/vim-react-snippets'

" Linting
Plug 'w0rp/ale'

"----------------------------
" Additional Language Support
"----------------------------

" Ruby
Plug 'tpope/vim-rails'
Plug 'tonekk/vim-ruby-capybara'
Plug 'keith/rspec.vim'
Plug 'thoughtbot/vim-rspec'

" Javascript
Plug 'pangloss/vim-javascript', {'for': ['javascript', 'javascript.jsx']}

" HTML
Plug 'alvan/vim-closetag'
Plug 'mattn/emmet-vim'

" CSS
Plug 'ap/vim-css-color'
Plug 'cakebaker/scss-syntax.vim'

" JSON
Plug 'tpope/vim-jdaddy'

" Custom bundles
" Include user's extra bundle
if filereadable(expand("~/.config/nvim/local_bundles.vim"))
  source ~/.config/nvim/local_bundles.vim
endif

call plug#end()

" Shortcut for checking if a plugin is loaded
function! s:has_plugin(plugin)
  let lookup = 'g:plugs["' . a:plugin . '"]'
  return exists(lookup)
endfunction

" Required:
filetype plugin indent on

"*****************************************************************************
" Basic Setup
"*****************************************************************************

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" Open items from quickfix in existing tab if it contains target buffer
set switchbuf+=usetab,newtab

" Fix backspace indent
set backspace=indent,eol,start

" Disable wrapping
set wrap!

" Map leader to space
let mapleader="\<Space>"

" Enable hidden buffers
set hidden

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Directories for swp files
set nobackup
set noswapfile

" Show additional Visual mode info in last line
set showcmd

" Don't show current mode in status line
set noshowmode

" Configure EOL detection
set fileformats=unix,mac

set shell=/bin/zsh

" Don't redraw for actions that haven't been typed
set lazyredraw

" Personal spellfile location
set spellfile=~/.config/nvim/spell/en.utf-8.add

 " Copy/Paste/Cut
if (executable('pbcopy') || executable('xclip') || executable('xsel')) && has('clipboard')
  set clipboard+=unnamed,unnamedplus
endif

"*****************************************************************************
" Plugin Config
"*****************************************************************************

if s:has_plugin('bullets.vim')
  let g:bullets_enabled_file_types = [
      \ 'markdown',
      \ 'text',
      \ 'gitcommit',
      \]
endif

if s:has_plugin('emmet-vim')
  let g:user_emmet_install_global = 0
  autocmd FileType html,css,javascript EmmetInstall
endif

if s:has_plugin('vim-closetag')
  let g:closetag_filenames = "*.html,*.js,*.jsx"
  let g:closetag_close_shortcut = ''
endif

if s:has_plugin('fzf.vim')
  let g:fzf_height = '30%'
  let g:fzf_commits_log_options = '--color --graph --pretty=format:"%C(yellow)%h%Creset -%C(auto)%d%Creset %s %C(bold blue)(%cr) %Cred<%an>%Creset" --abbrev-commit'

  nnoremap <c-p> :FZF<cr>
  nnoremap <leader>bu :Buffers<cr>
  nnoremap <leader>bl :BLines<cr>
  nnoremap <leader>hi :History:<cr>
  nnoremap <leader>co :Commits<cr>

  let g:fzf_colors =
  \ { 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Boolean'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }
endif

if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " bind K to grep word under cursor
  nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

  " bind \ (backward slash) to grep shortcut
  command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
  nnoremap \ :Ag<SPACE>
endif

if s:has_plugin('vim-gutentags')
  let g:gutentags_ctags_tagfile = '.vim_tags'
  let g:gutentags_ctags_exclude = [
        \ 'node_modules',
        \ 'dist',
        \ 'vendor',
        \ 'bower_components']
endif

if s:has_plugin('vim-airline')
  let g:airline#extensions#branch#enabled = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#formatter = 'unique_tail'
  let g:airline#extensions#tabline#show_buffers = 0
  let g:airline#extensions#tabline#show_close_button = 0
  let g:airline#extensions#tabline#show_splits = 0
  let g:airline#extensions#tabline#show_tab_nr = 0
  let g:airline#extensions#tabline#show_tab_type = 0
  let g:airline#extensions#tabline#show_tabs = 1
  let g:airline_powerline_fonts = 1
  let g:airline_section_error = ''
  let g:airline_section_warning = ''
  let g:airline_section_y = ''
endif

if s:has_plugin('vimfiler.vim')
  let g:vimfiler_as_default_explorer = 1

  call vimfiler#custom#profile('default', 'context', {
       \ 'safe' : 0,
       \ 'edit_action' : 'tabopen',
       \ })
  let g:loaded_netrwPlugin = 1
  nnoremap - :VimFiler -find<CR>

  " VimFiler autocmd
  augroup vimfiler-custom
    autocmd!
    " prefer tab navigation to opening 2nd vimfiler
    autocmd FileType vimfiler nunmap <buffer> <Tab>
    autocmd FileType vimfiler nnoremap <Tab> gt
    autocmd FileType vimfiler nnoremap <S-Tab> gT

    " change shortcut for mark current line
    autocmd FileType vimfiler nunmap <buffer> <Space>
    autocmd FileType vimfiler nmap <buffer> , <Plug>(vimfiler_toggle_mark_current_line)

    " prefer Ag's '\' search to viewing root
    autocmd FileType vimfiler nunmap <buffer> \

    " switch off relativenumber, too damn slow
    autocmd FileType vimfiler setlocal norelativenumber
  augroup end
endif

if s:has_plugin('vim-polyglot')
  let g:polyglot_disabled = ['css']
  let g:jsx_ext_required = 0
endif

if s:has_plugin('deoplete.nvim')
  " Completion / Snippets
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#enable_ignore_case = 1
  let g:deoplete#enable_smart_case = 1
  " always use completions from all buffers
  if !exists('g:deoplete#same_filetypes')
    let g:deoplete#same_filetypes = {}
  endif
  let g:deoplete#same_filetypes._ = '_'
  " <TAB>: completion.
  inoremap <expr> <Tab> pumvisible() ? "\<C-y>" : "\<Tab>"
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<tab>"
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif

if s:has_plugin('vim-easymotion')
  " Easymotion
  let g:EasyMotion_do_mapping = 0 " Disable default mappings
  nmap s <Plug>(easymotion-s)
endif


let g:rspec_command = "tabnew | term bundle exec rspec {spec}"

if s:has_plugin('ale')
  let g:ale_sign_column_always = 1
  nmap <silent> <C-k> <Plug>(ale_previous_wrap)
  nmap <silent> <C-j> <Plug>(ale_next_wrap)
  nmap <silent> <leader>f <Plug>(ale_fix)
  let g:ale_ruby_rubocop_executable = 'bundle'
  let g:ale_linters = { 'ruby': ['rubocop'] }
  let g:ale_fixers = { 'ruby': ['rubocop'] }
endif



"*****************************************************************************
" Visual Settings
"*****************************************************************************

syntax sync minlines=200
syntax sync maxlines=300
set synmaxcol=300

set ruler
set relativenumber
set number
set colorcolumn=80

let no_buffers_menu=1

set mousemodel=popup

" Highlight tailing whitespace
set list listchars=tab:\ \ ,trail:·

if has('termguicolors')
  set termguicolors
endif

if $COLORTERM == 'gnome-terminal'
  set term=gnome-256color
else
  if $TERM == 'xterm'
    set term=xterm-256color
  endif
endif

" Minimum number of lines above and below cursor
set scrolloff=5

" Use modeline overrides
set modeline
set modelines=10


"*****************************************************************************
" Abbreviations
"*****************************************************************************

" Remap common Normal mode typos to something useful
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev Wqa wqa
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qa q
cnoreabbrev Qall qall


"*****************************************************************************
" Color schemes
"*****************************************************************************

function! ColorsDark()
  set background=dark
  colorscheme iceberg
  let g:airline_theme='iceberg'
endfunction

function! ColorsLight()
  set background=light
  colorscheme snow
endfunction

call ColorsDark()


"*****************************************************************************
" Autocmd Rules
"*****************************************************************************

augroup vimrc-defaults
  autocmd!
  " Do syntax highlight syncing from start
  autocmd BufEnter * :syntax sync fromstart
  " Default tab settings in everything, overriding anything set by ftplugin
  au BufRead,BufNewFile * setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  " remove whitespace on save
  autocmd BufWritePre * :%s/\s\+$//e
augroup END

" Function to preview markdown in Atom
function! s:setupMarkdownPreview()
  nnoremap <leader>mp :silent !open -a iA\ Writer.app '%:p'<cr>
endfunction

" Markdown
augroup vimrc-markdown-settings
  autocmd!
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn}
        \ setlocal wrap linebreak nolist textwidth=0 wrapmargin=0 |
        \ setlocal fo+=t spell spelllang=en_gb |
        \ setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2 |
        \ call s:setupMarkdownPreview() |
        \ setlocal comments+=fb:-,fb:* |
        \ set colorcolumn=
augroup END

" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" Pleco flashcard import file
autocmd BufRead,BufEnter *.pleco.txt setlocal nowrap noexpandtab fo-=t tw=0

" ruby
augroup vimrc-ruby
  autocmd!
  autocmd BufNewFile,BufRead *.rb,*.rbw,*.gemspec setlocal filetype=ruby
  autocmd FileType ruby setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType ruby setlocal comments+=fb:#
augroup END

" eruby
augroup vimrc-eruby
  autocmd!
  autocmd FileType eruby setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" javascript
augroup vimrc-javascript
  autocmd!
  autocmd Filetype javascript setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" autoread files that have changed outside of vim
set autoread


"*****************************************************************************
" Custom Key Mappings
"*****************************************************************************

" --- Leader Key - single character

" Splits
noremap <leader>- :<C-u>split<CR>
noremap <leader><bar> :<C-u>vsplit<CR>
" Set working directory
noremap <leader>. :lcd %:p:h<CR>
" MatchTagAlways jump shortcut
noremap <leader>% :MtaJumpToOtherTag<cr>
" Close buffer
noremap <leader>c :bd<CR>
" Opens an edit command with the path of the currently edited file filled in
noremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
" Clear search highlight
noremap <silent> <leader>l :noh<cr>
" Insert newline below or above
noremap <leader>j o<Esc>
noremap <leader>k O<Esc>
" Tabs
noremap <leader>o :tabonly<cr>
" Replace within Quickfix with Qdo
noremap <leader>r :Qdo %s/
" Goyo distraction-free writing mode
noremap <leader>G :Goyo 100<CR>

" --- Leader Key - multiple character

" Color schemes
noremap <leader>cd :call ColorsDark()<CR>
noremap <leader>cl :call ColorsLight()<CR>

" Git
noremap <leader>ga :Gwrite<CR>
noremap <leader>gc :Gcommit<CR>
noremap <leader>gsh :Gpush<CR>
noremap <leader>gll :Gpull<CR>
noremap <leader>gs :Gstatus<CR>
noremap <leader>gb :Gblame<CR>
noremap <leader>gd :Gvdiff<CR>
noremap <leader>gr :Gremove<CR>
noremap <leader>go :Gbrowse<CR>

" Line number toggles
noremap <leader>ln :set nu!<CR>
noremap <leader>lr :set relativenumber!<CR>

" Ruby
noremap <leader>rb orequire 'pry-byebug';binding.pry;sleep 1<CR><Esc>

"copy filename
noremap <leader>cf :let @*=expand("%")<CR>

" vim-rspec
noremap <leader>sc :call RunCurrentSpecFile()<CR>
noremap <leader>sn :call RunNearestSpec()<CR>
noremap <leader>sl :call RunLastSpec()<CR>
noremap <leader>sa :call RunAllSpecs()<CR>

" --- Misc

" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
noremap <silent> <leader>t :tabnew<CR>

" nullify ctrl+space in insert mode (used in macos)
imap <Nul> <Space>

" disable Ex mode shortcut
nnoremap Q <nop>

" command shortcut to sudo save
command SW w !sudo tee %

