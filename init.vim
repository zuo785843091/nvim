

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
au BufNewFile,BufRead *.py set tabstop=4
au BufNewFile,BufRead *.py set softtabstop=4
au BufNewFile,BufRead *.py set shiftwidth=4
au BufNewFile,BufRead *.py set textwidth=79
au BufNewFile,BufRead *.py set expandtab
"au BufNewFile,BufRead *.py set autoindent
au BufNewFile,BufRead *.py set fileformat=unix
"set noexpandtab                             " 不用空格展开<Tab>
"set tabstop=4
"set shiftwidth=4
"set softtabstop=4
"set textwidth=79
"set wrap                                    " 设置文本达到textwidth宽度时自动换行，但实际文件还是一行
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

set colorcolumn=80 " 设置竖线
set updatetime=1000
set virtualedit=block  " ctrl+v 模式下选中方块

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" ===
" === Basic Mappings
" ===
" Set <LEADER> as <SPACE>, ; as :
let mapleader=" "
"noremap ; :

" Save & quit
noremap Q :q<CR>
noremap <C-q> :qa<CR>
noremap S :up<CR>
"inoremap <C-s> <ESC>:up<CR>i


" ===
" === Cursor Movement
" ===
" New cursor movement (the default arrow keys are used for resizing windows)
"     ^
"     i
" < j   l >
"     k
"     v

"noremap i k
"noremap k j
"noremap j h

" K/J keys for 5 times k/j (faster navigation)
noremap K 5k
noremap J 5j

" Ctrl + K or J will move up/down the view port without moving the cursor
noremap <C-J> 5<C-e>
noremap <C-K> 5<C-y>

" Insert model remap
"noremap h i
"noremap H I

" 输入模式下的光标移动
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-b> <PageUp>
inoremap <C-f> <PageDown>


" ===
" === Window management
" ===
" Use <space> + new arrow keys for moving the cursor around windows
noremap <LEADER>w <C-w>w
noremap <LEADER>k <C-w>k
noremap <LEADER>j <C-w>j
noremap <LEADER>h <C-w>h
noremap <LEADER>l <C-w>l

" 缩进健
nnoremap < <<
nnoremap > >>

" open the vimrc file anytime
noremap <LEADER>rc :e ~/.config/nvim/init.vim<CR>
noremap <LEADER>sr :source ~/.config/nvim/init.vim<CR>

" make Y to copy till the end of the line
nnoremap Y y$

" Copy to system clipboard
vnoremap Y "+y
noremap P "+p

" Folding
noremap <silent> <LEADER>o za

" Press <SPACE> + q to close the window below the current window
noremap <LEADER>q <C-w>j:q<CR>

" Disable the default s key
noremap s <nop>

" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap sj :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap sk :set splitbelow<CR>:split<CR>
noremap sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap sl :set splitright<CR>:vsplit<CR>


" ===
" === Tab management
" ===
" Create a new tab with tu
noremap tn :tabe<LEADER>
noremap tc :tabc<CR>
" Move around tabs with tn and ti
noremap th :-tabnext<CR>
noremap tl :+tabnext<CR>
" Move the tabs with tmn and tmi
noremap tj :-tabmove<CR>
noremap tk :+tabmove<CR>

" ===
" === Compile function
" ===
"noremap <F5> :call CompileRunGcc()<CR>
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

" #### 快速自动对齐插件
Plug 'junegunn/vim-easy-align'

" #### 输入法状态切换
"Plug 'https://github.com/vim-scripts/fcitx.vim.git'

" #### Pretty Dress
" 状态栏
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'theniceboy/eleline.vim'
"Plug 'bling/vim-bufferline'
"Plug 'liuchengxu/space-vim-theme'
"Plug 'morhetz/gruvbox'
"Plug 'ayu-theme/ayu-vim'
"Plug 'rakr/vim-one'
"Plug 'mhartington/oceanic-next'
"Plug 'kristijanhusak/vim-hybrid-material'
Plug 'ajmwagar/vim-deus'  " deus theme
"Plug 'arzg/vim-colors-xcode'

" #### File navigaton
"Plug 'preservim/nerdtree'
"Plug 'jistr/vim-nerdtree-tabs'
Plug 'junegunn/fzf.vim'
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}

" #### Auto Complete 
"Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-jedi'
"Plug 'ncm2/ncm2-github'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
"Plug 'ncm2/ncm2-match-highlight'
"Plug 'ncm2/ncm2-markdown-subscope'
Plug 'ncm2/float-preview.nvim'
Plug 'ncm2/ncm2-ultisnips'
"" based on snipmate
"Plug 'ncm2/ncm2-snipmate'
"" snipmate dependencies
"Plug 'tomtom/tlib_vim'
"Plug 'marcweber/vim-addon-mw-utils'
"Plug 'garbas/vim-snipmate'

"Plug 'ycm-core/YouCompleteMe'

" #### Error checking
Plug 'dense-analysis/ale'

" #### Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" #### Formatter
Plug 'Chiel92/vim-autoformat'

" #### Python
Plug 'tmhedberg/SimpylFold', { 'for' :['python', 'vim-plug'] }
Plug 'Vimjas/vim-python-pep8-indent', { 'for' :['python', 'vim-plug'] }
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for' :['python', 'vim-plug'] }
Plug 'tweekmonster/braceless.vim'

" #### Tex
"Plug 'lervag/vimtex'

" #### Taglist
Plug 'liuchengxu/vista.vim'

" #### Debugger
Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-c --enable-python'}

" #### Editor Enhancement"
" "Plug 'Raimondi/delimitMate'
" Plug 'jiangmiao/auto-pairs'
" Plug 'mg979/vim-visual-multi'
Plug 'scrooloose/nerdcommenter' " in <space>cn to comment a line
Plug 'AndrewRadev/switch.vim' " gs to switch
" Plug 'tpope/vim-surround' " type yskw' to wrap the word with '' or type cs'` to change 'word' to `word`
" Plug 'gcmt/wildfire.vim' " in Visual mode, type k' to select all text in '', or type k) k] k} kp
" Plug 'junegunn/vim-after-object' " da= to delete what's after =
" Plug 'junegunn/vim-easy-align' " gaip= to align the = in paragraph, 
" Plug 'tpope/vim-capslock'	" Ctrl+L (insert) to toggle capslock
" Plug 'easymotion/vim-easymotion'
" Plug 'Konfekt/FastFold'
" "Plug 'junegunn/vim-peekaboo'
" "Plug 'wellle/context.vim'
" Plug 'svermeulen/vim-subversive'

" #### Mini Vim-APP
"Plug 'voldikss/vim-floaterm'
"Plug 'liuchengxu/vim-clap'
"Plug 'jceb/vim-orgmode'
Plug 'mhinz/vim-startify'  " 打开vim时显示打开选项

" #### Other visual enhancement
" Plug 'ryanoasis/vim-devicons'
" Plug 'luochen1990/rainbow'
" Plug 'mg979/vim-xtabline'
" Plug 'wincent/terminus'




call plug#end()


" ===
" === Dress up my vim
" ===
set termguicolors	" enable true colors support
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark
"let ayucolor="mirage"
"let g:oceanic_next_terminal_bold = 1
"let g:oceanic_next_terminal_italic = 1
"let g:one_allow_italics = 1

"color dracula
"color one
color deus
"color gruvbox
"let ayucolor="light"
"color ayu
"set background=light
"color xcodedark

hi NonText ctermfg=gray guifg=grey10
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
let g:airline_powerline_fonts = 0

"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline#extensions#tabline#formatter = 'default'

"map <F2> :NERDTreeToggle<CR>

" ===
" === rnvimr
" ===
let g:rnvimr_ex_enable = 1
let g:rnvimr_pick_enable = 1
nnoremap <silent> R :RnvimrSync<CR>:RnvimrToggle<CR><C-\><C-n>:RnvimrResize 0<CR>
let g:rnvimr_presets = [{'width': 1.0, 'height': 1.0}]


" ===
" === NCM2
" ===
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
""inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>": "\<CR>")
autocmd BufEnter * call ncm2#enable_for_buffer() "缓存
set completeopt=noinsert,menuone,noselect "补全模式设置 noselect:不自动选择第一行
set	shortmess+=c
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

let g:float_preview#docked = 1
" ======== ncm2_ultisnips ================================
" Press enter key to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')
" c-j c-k for moving in snippet
"let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
"let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
"let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0

"" ======== snipmate =====================================
"" Press enter key to trigger snippet expansion
"" " The parameters are the same as `:help feedkeys()`
"inoremap <silent> <expr> <CR> ncm2_snipmate#expand_or("\<CR>", 'n')
"" wrap <Plug>snipMateTrigger so that it works for both completin and normal
"" snippet
"" inoremap <expr> <c-u> ncm2_snipmate#expand_or("\<Plug>snipMateTrigger", "m")
"" c-j c-k for moving in snippet
"let g:snips_no_mappings = 1
"vmap <c-j> <Plug>snipMateNextOrTrigger
"vmap <c-k> <Plug>snipMateBack
"imap <expr> <c-k> pumvisible() ? "\<c-y>\<Plug>snipMateBack" : "\<Plug>snipMateBack"
"imap <expr> <c-j> pumvisible() ? "\<c-y>\<Plug>snipMateNextOrTrigger" : "\<Plug>snipMateNextOrTrigger"


" ===
" === ale
" ===
"let b:ale_linters = ['pylint']
"let b:ale_fixers = ['autopep8', 'yapf']

" ===
" === Taglist Vista.vim
" ===
noremap <silent> T :Vista!!<CR>
let g:vista_icon_indent = ["╰▸ ", "├▸ "]
let g:vista_default_executive = 'ctags'
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
	\   "function": "\uf794",
	\   "variable": "\uf71b",
	\  }
function! NearestMethodOrFunction() abort
	return get(b:, 'vista_nearest_method_or_function', '')
endfunction
set statusline+=%{NearestMethodOrFunction()}
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()


" ===
" === Ultisnips
" ===
let g:tex_flavor = "latex"
inoremap <c-n> <nop>
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"
let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/UltiSnips/']
silent! au BufEnter,BufRead,BufNewFile * silent! unmap <c-r>


" ===
" === FZF
" ===
" set rtp+=/usr/local/opt/fzf
" set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf
set rtp+=~/.fzf
noremap <C-p> :FZF<CR>
" noremap <C-f> :Ag<CR>
" noremap <C-h> :MRU<CR>
" noremap <C-t> :BTags<CR>
" noremap <C-l> :LinesWithPreview<CR>
" noremap <C-w> :Buffers<CR>
" "noremap ; :History:<CR>

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noruler
	\| autocmd BufLeave <buffer> set laststatus=2 ruler

command! -bang -nargs=* Buffers
	\ call fzf#vim#buffers(
	\   '',
	\   <bang>0 ? fzf#vim#with_preview('up:60%')
	\           : fzf#vim#with_preview('right:0%', '?'),
	\   <bang>0)

command! -bang -nargs=* LinesWithPreview
	\ call fzf#vim#grep(
	\   'rg --with-filename --column --line-number --no-heading --color=always --smart-case . '.fnameescape(expand('%')), 1,
	\   fzf#vim#with_preview({}, 'up:50%', '?'),
	\   1)

command! -bang -nargs=* Ag
	\ call fzf#vim#ag(
	\   '',
	\   <bang>0 ? fzf#vim#with_preview('up:60%')
	\           : fzf#vim#with_preview('right:50%', '?'),
	\   <bang>0)

command! -bang -nargs=* MRU call fzf#vim#history(fzf#vim#with_preview())

command! -bang BTags
	\ call fzf#vim#buffer_tags('', {
	\     'down': '40%',
	\     'options': '--with-nth 1
	\                 --reverse
	\                 --prompt "> "
	\                 --preview-window="70%"
	\                 --preview "
	\                     tail -n +\$(echo {3} | tr -d \";\\\"\") {2} |
	\                     head -n 16"'
	\ })



" ===
" === :Autoformat
" ===
nnoremap \f :Autoformat<CR>

" ===
" === vimspector
" ===
let g:vimspector_enable_mappings = 'HUMAN'
function! s:read_template_into_buffer(template)	
	" has to be a function to avoid the extra space fzf#run insers otherwise	
	execute '0r ~/.config/nvim/sample_vimspector_json/'.a:template
endfunction
command! -bang -nargs=* LoadVimSpectorJsonTemplate call fzf#run({
			\   'source': 'ls -1 ~/.config/nvim/sample_vimspector_json',
			\   'down': 20,
			\   'sink': function('<sid>read_template_into_buffer')
			\ })
noremap <leader>vs :tabe .vimspector.json<CR>:LoadVimSpectorJsonTemplate<CR>
nmap <C-S-c> :VimspectorReset<CR>
sign define vimspectorBP text=☛ texthl=Normal
sign define vimspectorBPDisabled text=o texthl=Normal
sign define vimspectorPC text=> texthl=SpellBad


