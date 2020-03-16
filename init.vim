

" ===
" === Auto load for first time uses
" ===
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ===
" === Create a _machine_specific.vim file to adjust machine specific stuff, like python interpreter location
" ===
let has_machine_specific_file = 1
if empty(glob('~/.config/nvim/_machine_specific.vim'))
	let has_machine_specific_file = 0
	silent! exec "!cp ~/.config/nvim/default_configs/_machine_specific_default.vim ~/.config/nvim/_machine_specific.vim"
endif
source ~/.config/nvim/_machine_specific.vim

" ====================
" === Editor Setup ===
" ====================
" ===
" === System
" ===
"set clipboard=unnamedplus
let &t_ut=''
set autochdir                               " 自动切换当前目录为文件所在目录



" ===================== Editor behavior ======================
"
set mouse=a                                 " 启用鼠标
set number                                  " 显示行号
" set relativenumber                        " 特殊行号显示模式
" set cursorline                            " 突出显示当前行
set encoding=utf-8                          " 设置utf-8编码
" " 缩进设置
set noexpandtab                             " 不用空格展开<Tab>
set tabstop=4
set shiftwidth=4
set softtabstop=4
set textwidth=88
set wrap                                    " 设置文本达到textwidth宽度时自动换行，但实际文件还是一行

set autoindent                              " 插入模式下输入<cr>或使用"o"或"O"命令开新行，从当前行复制缩进距离
set list
set listchars=tab:\|\ ,trail:▫              " Tab 和 空格显示符

set scrolloff=6                             " 始终显示前后几行
set ttimeoutlen=0
set notimeout
set viewoptions=cursor,folds,slash,unix
set tw=0
set indentexpr=
" " 代码折叠设置
set foldmethod=indent
set foldlevel=99
set foldenable
set formatoptions-=tc
" " 设置分割窗口
set splitright
set splitbelow
set noshowmode                              "
set showcmd                                 " 显示输入中的命令
set wildmenu                                "
set ignorecase                              " 搜索忽略大小写
set smartcase                               " 有大写时不忽略
set shortmess+=c
set inccommand=split
"set completeopt=longest,noinsert,menuone,noselect,preview " 补全模式设置
set ttyfast "should make scrolling faster
set lazyredraw "same as above
set visualbell
" 退出时保存编辑的位置
silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
"silent !mkdir -p ~/.config/nvim/tmp/sessions
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
if has('persistent_undo')
	set undofile
	set undodir=~/.config/nvim/tmp/undo,.
endif

set colorcolumn=88 " 设置竖线
set updatetime=1000
set virtualedit=block  " ctrl+v 模式下选中方块

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif



" ===
" === Basic Mappings
" ===
" Set <LEADER> as <SPACE>, ; as :
let mapleader=" "
"noremap ; :

" ===
" === Cursor Movement
" ===
" New cursor movement (the default arrow keys are used for resizing windows)
"     ^
"     i
" < j   l >
"     k
"     v

noremap i k
noremap k j
noremap j h
" Insert model remap
noremap h i
noremap H I

" 输入模式下的光标移动
"inoremap <C-i> <Up>
inoremap <C-k> <Down>
inoremap <C-j> <Left>
inoremap <C-l> <Right>
inoremap <C-b> <PageUp>
inoremap <C-f> <PageDown>

" 缩进健
nnoremap < <<
nnoremap > >>

" open the vimrc file anytime
noremap <LEADER>rc :e ~/.config/nvim/init.vim<CR>

" make Y to copy till the end of the line
nnoremap Y y$

" Copy to system clipboard
vnoremap Y "+y
noremap P "+p

" Folding
noremap <silent> <LEADER>o za


" Compile function
noremap <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	endif
endfunc


" ===
" === Install Plugins with Vim-Plug
" ===

call plug#begin('~/.config/nvim/plugged')

" 快速自动对齐插件
Plug 'junegunn/vim-easy-align'

" 输入法状态切换
"Plug 'https://github.com/vim-scripts/fcitx.vim.git'

" 状态栏
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Pretty Dress
"Plug 'theniceboy/eleline.vim'
"Plug 'bling/vim-bufferline'
"Plug 'liuchengxu/space-vim-theme'
"Plug 'morhetz/gruvbox'
"Plug 'ayu-theme/ayu-vim'
"Plug 'rakr/vim-one'
"Plug 'mhartington/oceanic-next'
"Plug 'kristijanhusak/vim-hybrid-material'
"Plug 'ajmwagar/vim-deus'
"Plug 'arzg/vim-colors-xcode'

" File navigaton
Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
"Plug 'junegunn/fzf.vim'
"Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}


" ####
" Auto Complete
"Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-jedi'
"Plug 'ncm2/ncm2-github'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
"Plug 'ncm2/ncm2-match-highlight'
"Plug 'ncm2/ncm2-markdown-subscope'


"Plug 'ycm-core/YouCompleteMe'


" ####
" Error checking
"Plug 'w0rp/ale'
Plug 'dense-analysis/ale'


" ####
" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'


" ####


" Tex
Plug 'lervag/vimtex'




" ###
call plug#end()


" ===
" === Dress up my vim
" ===
"set termguicolors	" enable true colors support
"let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"set background=dark
"let ayucolor="mirage"
"let g:oceanic_next_terminal_bold = 1
"let g:oceanic_next_terminal_italic = 1
"let g:one_allow_italics = 1

"color dracula
"color one
"color deus
"color gruvbox
"let ayucolor="light"
"color ayu
"set background=light
"color xcodedark

"hi NonText ctermfg=gray guifg=grey10
"hi SpecialKey ctermfg=blue guifg=grey70

" ===================== Start of Plugin Settings =====================
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


" ===
" === Airline
" ===
"let g:airline_theme='dracula'
"let g:airline#extensions#coc#enabled = 0
"let g:airline#extensions#branch#enabled = 0
"let g:airline#extensions#tabline#enabled = 0
"let g:airline#extensions#tabline#formatter = 'unique_tail'
"let g:airline_powerline_fonts = 1
"let g:airline#extensions#tabline#show_buffers = 0
"let g:airline_left_sep = ''
"let g:airline_right_sep = ''
"let g:airline_mode_map = {
      "\ '__' : '-',
      "\ 'n'  : 'Nor',
      "\ 'i'  : 'Ins',
      "\ 'R'  : 'Rpl',
      "\ 'c'  : 'Cmd',
      "\ 'v'  : 'Vis',
      "\ 'V'  : 'Vli',
      "\ '' : 'Vbl',
      "\ 's'  : 'S',
      "\ 'S'  : 'S',
      "\ '' : 'S',
      "\ }


" ===
" === eleline.vim
" ===
"let g:airline_powerline_fonts = 0

"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline#extensions#tabline#formatter = 'default'

map <F2> :NERDTreeToggle<CR>

" ===
" === rnvimr
" ===
"let g:rnvimr_ex_enable = 1
"let g:rnvimr_pick_enable = 1
"nnoremap <silent> R :RnvimrSync<CR>:RnvimrToggle<CR><C-\><C-n>:RnvimrResize 0<CR>
"let g:rnvimr_presets = [{'width': 1.0, 'height': 1.0}]


" ===
" === NCM2
" ===
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
""inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>": "\<CR>")
autocmd BufEnter * call ncm2#enable_for_buffer() "缓存
set completeopt=noinsert,menuone,noselect  "补全模式设置

let ncm2#popup_delay = 5    " 延迟弹窗，这样提示更加流畅
let g:ncm2#matcher = "substrfuzzy"   "模糊匹配模式
let g:ncm2_jedi#python_version = 3
let g:ncm2#match_highlight = 'bold'
let g:jedi#auto_initialization = 1
""let g:jedi#completion_enabled = 0
""let g:jedi#auto_vim_configuration = 0
""let g:jedi#smart_auto_mapping = 0
"let g:jedi#popup_on_dot = 1
"let g:jedi#completion_command = ""
"let g:jedi#show_call_signatures = "1"


" ===
" === coc
" ===
"" fix the most annoying bug that coc has
""autocmd WinEnter * call timer_start(1000, { tid -> execute('unmap if')})
""silent! autocmd BufEnter * silent! call silent! timer_start(600, { tid -> execute('unmap if')})
""silent! autocmd WinEnter * silent! call silent! timer_start(600, { tid -> execute('unmap if')})
"silent! au BufEnter * silent! unmap if
""au TextChangedI * GitGutter
"" Installing plugins
"let g:coc_global_extensions = ['coc-python', 'coc-vimlsp', 'coc-snippets', 'coc-emmet', 'coc-html', 'coc-json', 'coc-css', 'coc-tsserver', 'coc-yank', 'coc-lists', 'coc-gitignore']
"" use <tab> for trigger completion and navigate to the next complete item
"function! s:check_back_space() abort
	"let col = col('.') - 1
	"return !col || getline('.')[col - 1]  =~ '\s'
"endfunction
"inoremap <silent><expr> <Tab>
	"\ pumvisible() ? "\<C-n>" :
	"\ <SID>check_back_space() ? "\<Tab>" :
	"\ coc#refresh()
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : \<S-Tab>"
"" Useful commands
"nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)
"nmap <leader>rn <Plug>(coc-rename)



" ===
" === ale
" ===
"let b:ale_linters = ['pylint']
"let b:ale_fixers = ['autopep8', 'yapf']


" ===
" === Ultisnips
" ===
let g:tex_flavor = "latex"
inoremap <c-n> <nop>
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-e>"
let g:UltiSnipsJumpBackwardTrigger="<c-n>"
let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/Ultisnips/', 'UltiSnips']
silent! au BufEnter,BufRead,BufNewFile * silent! unmap <c-r>

