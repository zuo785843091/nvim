

"" ===
"" === Auto load for first time uses
"" ===
"if empty(glob('~/.config/nvim/autoload/plug.vim'))
	"silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
				"\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	"autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
"endif
"
"" ===
"" === Create a _machine_specific.vim file to adjust machine specific stuff, like python interpreter location
"" ===
"let has_machine_specific_file = 1
"if empty(glob('~/.config/nvim/_machine_specific.vim'))
	"let has_machine_specific_file = 0
	"silent! exec "!cp ~/.config/nvim/default_configs/_machine_specific_default.vim ~/.config/nvim/_machine_specific.vim"
"endif
"source ~/.config/nvim/_machine_specific.vim

"let g:python_host_skip_check=1
"let g:python_host_prog = '/usr/bin/python'
"let g:python3_host_skip_check=1
"let g:python3_host_prog = '/usr/bin/python3'

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
"au BufNewFile,BufRead *.py set tabstop="4
"au BufNewFile,BufRead *.py set softtabstop=4
"au BufNewFile,BufRead *.py set shiftwidth=4
"au BufNewFile,BufRead *.py set textwidth=79
"au BufNewFile,BufRead *.py set expandtab
""au BufNewFile,BufRead *.py set autoindent
"au BufNewFile,BufRead *.py set fileformat=unix

"au BufNewFile,BufRead *.json set tabstop=2
"au BufNewFile,BufRead *.json set softtabstop=2
"au BufNewFile,BufRead *.json set shiftwidth=2
set expandtab                             " 用空格展开<Tab>
set tabstop=4
set shiftwidth=4
set softtabstop=4
set textwidth=79
set fileformat=unix
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
set inccommand=split
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
inoremap <A-k> <Up>
inoremap <A-j> <Down>
inoremap <A-h> <Left>
inoremap <A-l> <Right>
inoremap <A-b> <PageUp>
inoremap <A-f> <PageDown>

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
"vnoremap Y "+y
noremap P "+p
autocmd FileType * vnoremap Y :w !xclip -i -sel c<CR><CR>

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
noremap <LEADER>rr :call CompileRunGcc()<CR>
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
Plug 'theniceboy/eleline.vim'
Plug 'ajmwagar/vim-deus'  " deus theme

" #### File navigaton
"Plug 'preservim/nerdtree'
"Plug 'jistr/vim-nerdtree-tabs'
Plug 'junegunn/fzf.vim'
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}

" #### Auto Complete 
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-jedi'
"Plug 'ncm2/ncm2-github'
"Plug 'ncm2/ncm2-bufword'
"Plug 'ncm2/ncm2-path'
"Plug 'ncm2/ncm2-match-highlight'
"Plug 'ncm2/ncm2-markdown-subscope'
Plug 'ncm2/float-preview.nvim'
Plug 'ncm2/ncm2-ultisnips'

"Plug 'ycm-core/YouCompleteMe'

"" #### Error checking
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

" #### Debugger
Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-c --enable-python'}

" #### Editor Enhancement"
Plug 'mg979/vim-visual-multi'
Plug 'scrooloose/nerdcommenter' " in <space>cn to comment a line
Plug 'AndrewRadev/switch.vim' " gs to switch
Plug 'easymotion/vim-easymotion'
" Plug 'Konfekt/FastFold'

" #### Mini Vim-APP
Plug 'mhinz/vim-startify'  " 打开vim时显示打开选项

" #### Other visual enhancement
" Plug 'ryanoasis/vim-devicons'


" #### indentline
Plug 'Yggdroot/indentLine'

call plug#end()


" ===
" === Dress up my vim
" ===
set termguicolors	" enable true colors support
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark

color deus

hi NonText ctermfg=gray guifg=grey10
"hi SpecialKey ctermfg=blue guifg=grey70


" ===================== Start of Plugin Settings =====================
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


" ===
" === eleline.vim
" ===
let g:airline_powerline_fonts = 0


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
"set completeopt=longest,noinsert,menuone,noselect,preview " 补全模式设置
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
" 悬浮窗设置
let g:float_preview#docked = 0

" ======== ncm2_ultisnips ================================
" Press enter key to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')
" c-j c-k for moving in snippet
"let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
"let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
"let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0
 

" ===
" === coc
" ===
" fix the most annoying bug that coc has
" "silent! au BufEnter,BufRead,BufNewFile * silent! unmap if
" 
"let g:coc_global_extensions = ['coc-python', 'coc-vimlsp', 'coc-html', 'coc-json', 'coc-css', 'coc-tsserver', 'coc-yank', 'coc-gitignore', 'coc-vimlsp', 'coc-tailwindcss', 'coc-stylelint', 'coc-tslint', 'coc-lists', 'coc-git', 'coc-explorer', 'coc-pyright', 'coc-sourcekit', 'coc-translator', 'coc-flutter']
let g:coc_global_extensions = ['coc-json', 'coc-yank', 'coc-translator']
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"nmap <silent> <TAB> <Plug>(coc-range-select)
"xmap <silent> <TAB> <Plug>(coc-range-select)
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]	=~ '\s'
endfunction
inoremap <silent><expr> <Tab>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<Tab>" :
	\ coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <c-space> coc#refresh()

" Open up coc-commands
"nnoremap <c-c> :CocCommand<CR>
" Text Objects
"xmap kf <Plug>(coc-funcobj-i)
"xmap af <Plug>(coc-funcobj-a)
"omap kf <Plug>(coc-funcobj-i)
"omap af <Plug>(coc-funcobj-a)
" Useful commands
nnoremap <silent> <space>y :<C-u>CocList -A --normal yank<cr>
nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)
"nmap <leader>rn <Plug>(coc-rename)
"nmap tt :CocCommand explorer<CR>
" coc-translator
nmap ts <Plug>(coc-translator-p)
vmap ts <Plug>(coc-translator-pv)
" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
"xmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction-selected)


" ===
" === ale
" ===
let g:ale_linters={'python': ['pylint']}
"let b:ale_fixers=['yapf']
let g:ale_fixers={'python': ['yapf', 'autopep8']}
let g:ale_fix_on_save=1
"let g:ale_set_balloons=1
"let g:ale_hover_to_preview=1
"let g:ale_sign_error = '>>'
"let g:ale_sign_warning = '--'
"let g:airline#extensions#ale#enabled = 1
"let g:ale_echo_msg_error_str = 'E'
"let g:ale_echo_msg_warning_str = 'W'
"let g:ale_echo_msg_format = '[%linter%] %code%: %s [%severity%]'
"let g:ale_set_loclist = 0
"let g:ale_set_quickfix = 1
"let g:ale_open_list = 1
" Set this if you want to.
" This can be useful if you are combining ALE with
" some other plugin which sets quickfix errors, etc.
"let g:ale_keep_list_window_open = 1
"noremap gd :ALEGoToDefinition<CR>


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
noremap <F7> :VimspectorReset<CR>
sign define vimspectorBP text=☛ texthl=Normal
sign define vimspectorBPDisabled text=o texthl=Normal
sign define vimspectorPC text=> texthl=SpellBad

" ===
" === indentline
" ===
let g:indentLine_setColors = 0
"let g:indentLine_color_term = 202
"let g:indentLine_bgcolor_term = 2


" ===
" === startify
" ===
nnoremap st :Startify<CR>
