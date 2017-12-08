set shellslash

" python support setup
let g:python3_host_prog='C:/Users/elhatch.REDMOND/.local/virtualenvs/neovim3/Scripts/python.exe'
let g:python_host_prog='C:/Users/elhatch.REDMOND/.local/virtualenvs/neovim2/Scripts/python.exe'

" PLUGIN SETUP
" vim-airline/vim-airline
"let g:airline#extensions#tabline#enabled = 1
"let g:airline_theme='luna'
"
"let g:airline_powerline_fonts = 1
"let g:airline_extensions = ['tabline']

" neomake/neomake
let g:neomake_open_list = 2

" Shougo/deoplete.nvim
let g:deoplete#enable_at_startup = 1

" load plugins with vim-plug
call plug#begin('~/.local/share/nvim/plugged')

" core
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'neomake/neomake'

" editor
Plug 'scrooloose/nerdcommenter'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'kshenoy/vim-signature'

" git
Plug 'tpope/vim-fugitive'

" grep
 Plug 'mileszs/ack.vim'

" visual
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'elliothatch/burgundy.vim'

Plug 'chrisbra/Colorizer'

Plug 'scrooloose/nerdtree'
Plug 'mbbill/undotree'

" syntax
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'leafgarland/typescript-vim'
Plug 'rust-lang/rust.vim'
Plug 'octol/vim-cpp-enhanced-highlight'

" typescript
"Plug 'mhartington/nvim-typescript'

" nyaovim
Plug 'rhysd/nyaovim-markdown-preview'

"Plug 'D:/workspace/nyaovim-color-picker'

call plug#end()

" EDITOR SETTINGS
set hidden
set shiftwidth=4
set tabstop=4
set softtabstop=-4
set copyindent                  " carry indentation on newline
set clipboard=unnamed
set incsearch                   " search as you type
set ignorecase                  " ignore case in search
set smartcase                   " case sensitive when using capital letters
set undofile                    " save undo history to file
set textwidth=0                 " disable automatic word wrap

" DISPLAY SETTINGS
set number                      " show line numbers
set showmatch                   " show matching parentheses
set matchtime=2                 " ms to show matching parens in showmatch
set list
set listchars=tab:>-,trail:.,extends:#,nbsp:.
set cursorline                  " hilight current line
set scrolloff=3                 " scroll before cursor is at edge of screen
set colorcolumn=81
set termguicolors

" AUTOCMDS
augroup myautocmds
	" automatically add the current extension to 'gf' paths
	autocmd!
	autocmd BufNewFile,BufRead * execute 'setl suffixesadd+=.' . expand('%:e')
	" make  '-' part of words in css files
	autocmd FileType css,sass execute 'setl iskeyword+=-'
	" skip quickfix list on :bn
	autocmd FileType qf set nobuflisted
augroup END

" BINDINGS
" use space as mapleader (silent off)
map <space> <leader>
map <space><space> <leader><leader>

" NORMAL MODE
" window bindings
nnoremap <leader>Q :q<cr>

" Map ctrl-movement keys to window switching
noremap <C-k> <C-w><Up>
noremap <C-j> <C-w><Down>
noremap <C-l> <C-w><Right>
noremap <C-h> <C-w><Left>

" clear search highlight
nnoremap <silent> <leader>, :nohlsearch<CR>

" toggle paste mode
set pastetoggle=<leader>p

" save
nnoremap <leader>w :w<cr>

" buffer bindings
nnoremap <leader>l :bnext<cr>
nnoremap <leader>h :bprevious<cr>
nnoremap <leader>q :bd<cr>
nnoremap <leader>n :enew<cr>

" wrap word in quotes
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel

" quickfix list
nnoremap <leader>co :copen<cr>
nnoremap <leader>cl :cnext<cr>
nnoremap <leader>ch :cprevious<cr>

" location list
nnoremap <leader>Co :lopen<cr>
nnoremap <leader>Cl :lnext<cr>
nnoremap <leader>Ch :lprevious<cr>

" set grep to ack
set grepprg=ack\ -k

" get highlight group under cursor
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

nnoremap <leader>. :call SynStack()<cr>

" VISUAL MODE
" don't exit visual mode when indenting
vnoremap > >gv
vnoremap < <gv

" TERMINAL MODE
" esc to exit terminal mode
tnoremap <Esc> <C-\><C-n>

" PLUGIN BINDINGS
" scrooloose/nerdcommenter
nmap <leader>/ <leader>c<Space>
vmap <leader>/ <leader>c<Space>

" scrooloose/nerdtree
"" open file explorer
nnoremap <leader>F :NERDTreeToggle<cr>

" mbbill/undotree
nnoremap <leader>u :UndotreeToggle<cr>

" Shougo/denite.nvim
nnoremap <C-p> :<C-u>Denite file_rec/git<CR>
nnoremap <C-Space> :<C-u>Denite buffer<CR>

" tpope/vim-fugitive
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>ga :Gwrite<CR>
nnoremap <leader>gU :Gread<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gb :Gblame<CR>

" mileszs/ack.vim
function! InputOrCancel(prefix, prompt, suffix)
	call inputsave()
	let result = input(a:prompt)
	if result == ''
		return '<cr>'
	endif
	call inputrestore()
	return a:prefix . result . a:suffix
endfunc

"nnoremap <expr> <leader>ss ':Ack! '          . input('[ack]: ')              . ' ' . expand('%:p:h') . '<cr>'
nnoremap <expr> <leader>ss InputOrCancel(':Ack! ',    '[ack]: ',       ' ' . expand('%:p:h') . '<cr>')
nnoremap <expr> <leader>sl InputOrCancel(':LAck ',    '[ack]\|L: ', ' ' . expand('%:p:h') . '<cr>')
nnoremap <expr> <leader>sf InputOrCancel(':AckFile ', '[ack file]: ', ' ' . expand('%:p:h') . '<cr>')
nnoremap <expr> <leader>s/ ':AckFromSearch ' . expand('%:p:h') . '<cr>'

nnoremap <expr> <leader>Ss InputOrCancel(':Ack! ',    '[ack project]: ',       '<cr>')
nnoremap <expr> <leader>Sl InputOrCancel(':LAck ',    '[ack project]\|L: '), '<cr>')
nnoremap <expr> <leader>Sf InputOrCancel(':AckFile ', '[ack project file]: '), '<cr>')
nnoremap <expr> <leader>S/ ':AckFromSearch ' . '<cr>'

" PLUGIN SETUP
"
" Shougo/denite.nvim
" add git ls-files source
call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command',
\ ['git', 'ls-files', '-co', '--exclude-standard'])
nnoremap <silent> <C-p> :<C-u>Denite
\ `finddir('.git', ';') != '' ? 'file_rec/git' : 'file_rec'`<CR>

" move cursor up/down with Ctrl-j and Ctrl-k
call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')

" neomake/neomake
" automatically run on load and save
call neomake#configure#automake('rw', 1000)

" VISUAL SETTINGS
colorscheme burgundy

" statusline
set statusline=
set statusline+=[%n]                                  "buffernr
" TODO: change the color for modified
set statusline+=%#DiffChange#%m%r%w%*                           " modified/readonly
"set statusline+=%#LineNr#%{fugitive#statusline()}%*             " git branch
set statusline+=%#LineNr#%{fugitive#head()}%*             " git branch
set statusline+=\ %<%F\                                "File+path
set statusline+=%*\ %=\  "divider
set statusline+=%{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
set statusline+=%{(&bomb?\",BOM\":\"\")}            "Encoding2
set statusline+=[%{&ff}]\                              "FileFormat (dos/unix..)
set statusline+=%y\                                  "FileType
set statusline+=0x%04B\          "character under cursor
set statusline+=%l:%v\  "row:col
set statusline+=%p%%\  "row %
"set statusline+=%P\ \                      "Modified? Readonly? Top/bot.
