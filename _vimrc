set nocompatible

" Disable menu.vim
if has('gui_running')
  set guioptions=M
endif

source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin
nunmap <c-a>
colorscheme candycode
set guifont=consolas:h13
set shortmess=aTI

"���뷽ʽ���ã�
set encoding=utf-8
set fileencoding=chinese
language message zh_CN.utf-8

set diffexpr=MyDiff()
function MyDiff()
	let opt = '-a --binary '
	if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
	if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
	let arg1 = v:fname_in
	if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
	let arg2 = v:fname_new
	if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
	let arg3 = v:fname_out
	if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
	let eq = ''
	if $VIMRUNTIME =~ ' '
		if &sh =~ '\<cmd'
			let cmd = '""' . $VIMRUNTIME . '\diff"'
			let eq = '"'
		else
			let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
		endif
	else
		let cmd = $VIMRUNTIME . '\diff'
	endif
	silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
source $VIMRUNTIME/macros/matchit.vim
autocmd BufEnter *.m    compiler mlint
:set showmatch
set matchpairs+=<:>

if has("autocmd") && exists("+omnifunc") 
	autocmd Filetype * 
				\	if &omnifunc == "" | 
				\	 setlocal omnifunc=syntaxcomplete#Complete | 
				\	endif 
endif



source $VIMRUNTIME/macros/MakeMatlabComment.vim 
map <M-c> :call MakeMatlabComment()<CR> 
imap <M-c> <ESC>:call MakeMatlabComment()<CR>

au GUIEnter * simalt ~x	"Maxmize the startup window
set nowritebackup
set nobackup
set ignorecase smartcase
set report=0
set noswapfile
set shiftwidth=4

if has("gui_running")
	set guioptions-=m " ���ز˵���
	set guioptions-=T " ���ع�����
	set guioptions-=L " ������������
	set guioptions-=r " �����Ҳ������
	set guioptions-=b " ���صײ�������
	" set showtabline=0 " ����Tab��
endif


"keys map:


" ����ģʽ�����������ƶ����
inoremap <s-h> <left>
inoremap <s-l> <right>
inoremap <s-j> <c-o>gj
inoremap <s-k> <c-o>gk

" ������Wrapped lines ֮���ƶ� 
nnoremap j gj
nnoremap k gk

" ���ڼ��ƶ�:
map <M-Right> <c-w>l
map <M-Left> <c-w>h
map <M-Up> <c-w>k
map <M-Down> <c-w>j
imap <M-Right> <ESC><c-w>l
imap <M-Left> <ESC><c-w>h
imap <M-Up> <ESC><c-w>k
imap <M-Down> <ESC><c-w>j

"normalģʽ�»��У�
map <c-CR>  :put=''<CR>

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" <C-p> paste the yank word, not the deleted
nnoremap <silent> <C-p> "0p<CR>k

"����SmartClose�������ݹر�buffer��
let g:smartclose_set_default_mapping = 0
nnoremap <silent><m-q> :SmartClose<CR>

"���õ�ǰ�༭�ļ���·��Ϊ��ǰ·��:
map <F2> :lcd %:h<CR>

"�˸���趨��һ��Ŀ¼Ϊ��ǰ·����
noremap <BS> :cd..<CR>:cd<CR>

"���Ƶ�������:
vmap <F3> "+y

"ͨ��"%%" ������뵱ǰbufferĿ¼(windows�汾��linux���轫"\"�滻Ϊ"/")
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'\' : '%%'

"�򿪺͹ر���������:
map <a-m> :set nohlsearch<CR>
map <a-n> :set hlsearch<CR>


"����visualģʽ������ѡ�в��ֹ���(*��ǰ��#���):
"ͨ��vim-visual-star-search���

"Ϊ�Զ����ϰ�ߣ�
imap <c-j> <c-x><c-o>
inoremap <expr> <c-k> pumvisible()?"\<Up>":"\<c-k>"  
inoremap <expr> <c-j> pumvisible()?"\<Down>":"\<c-j>"  

"Voom �趨:
map <F12> :Voom<CR>
:set fmr=<<<,>>>

"������ƥ���ɫ��ʾ(rainbow ���)
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"TagHighlight���ã�
if ! exists('g:TagHighlightSettings')
	let g:TagHighlightSettings = {}
endif
let g:TagHighlightSettings['IncludeLocals'] =1 		

"Pathogen :
call pathogen#infect() 

"Tagbar����:
nmap <silent> <F11> :TagbarToggle<cr>		
let g:tagbar_width = 30


"NeoCompleteCache :
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
"select first:
let g:neocomplcache_enable_auto_select=0
"Fuzzy match setting(fuzzy enabled default in V8.1, here to show fewer candidates,):
call neocomplcache#custom_source('_', 'matchers', ['matcher_head'])
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
" Define dictionary.
" let g:neocomplcache_dictionary_filetype_lists = {
" 			\ 'default' : '',
" 			\ 'python'  : 'D:\Programe files\Vim\vimfiles\bundle\pydiction-1.2.1\complete-dict', 
" 			\ 'vimshell' : $HOME.'/.vimshell_hist',
" 			\ 'scheme' : $HOME.'/.gosh_completions'
" 			\ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
	let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

"Space to select items:
inoremap <expr><space>  pumvisible() ? neocomplcache#close_popup()  : "\<SPACE>"
"Caching everywhere:
noremap <Leader>neo :NeoComplCacheCachingBuffer<CR>:NeoComplCacheCachingTags<CR>
" using vimproc
let g:neocomplcache_use_vimproc=1

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
	let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" For rank priority setting in the popup list
let g:neocomplcache_source_rank = {
			\'snippets_complete' : 4,
			\ 'buffer_complete' : 8
			\ }



"NERDTree ���ã�
let g:NERDTree_title='NERD Tree'
function! NERDTree_Start()
	exec 'NERDTree'
endfunction

"һֱ��ʾ��ǩ
let NERDTreeShowBookmarks=1 

"NERDTree ��ݼ���
map <F10> :NERDTree<CR>
map <s-F10> :NERDTreeClose<CR>

function! NERDTree_IsValid()
	return 1
endfunction

"NERDTree�в���ʾ���ļ���׺����Ŀ¼���ƣ�
let NERDTreeIgnore=['\.uvopt$', '\~$','\.uvproj','\.dll','\makefile','\.svn','\.bak','\.dep','\.plg','\.taghl','\.out']

"����ȫ��&&����״̬��:
map <a-F12> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR> :call ToggleStatusline()<CR>

" ���ݵ�ǰ״̬�򿪻�ر�״̬��
function! ToggleStatusline()
    if &ls==0
	:set laststatus=2
    else
	:set laststatus=0
    endif
endfunction

"Cscope
"��������
nmap <C-Space>s :cs find s <C-R>=expand("<cword>")<CR><CR>
"���Ҷ���
nmap <C-Space>g :cs find g <C-R>=expand("<cword>")<CR><CR>
"���ҵ���
nmap <C-Space>c :cs find c <C-R>=expand("<cword>")<CR><CR>
"����ָ�����ַ���
nmap <C-Space>t :cs find t <C-R>=expand("<cword>")<CR><CR>
"����egrepģʽ���൱��egrep���ܣ��������ٶȿ����
nmap <C-Space>e :cs find e <C-R>=expand("<cword>")<CR><CR>
"�����ļ�
nmap <C-Space>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
"���Ұ������ļ����ļ�
nmap <C-Space>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
"���ұ��������õĺ���
nmap <C-Space>d :cs find d <C-R>=expand("<cword>")<CR><CR>


"�� txt �ı��ļ������⴦��(��������VIMIM���뷨):
autocmd FileType txt  :NeoComplCacheDisable	
autocmd FileType txt set completeopt=longest
let g:vimim_cloud='sogou'


"�� easybuffer ������п�ݼ�:
nmap ,b :EasyBufferHorizontal<CR>

"�� a ������п�ݼ�(��.h��.c֮���л�):
noremap <Leader>a :A<CR>  
noremap <Leader>ta :AT<CR>  

"����python: 
let python_highlight_all = 1

"pydiction ����:
let g:pydiction_location = 'D:\Programe files\Vim\vimfiles\bundle\pydiction-1.2.1\complete-dict' 

"Python Mode ����: 
noremap <Leader>pp :PyLint<CR>  
noremap <Leader>pc :PyLintAuto<CR>
" <ctrl-shift-sapce>�󶨵�RopeCodeAssist��������<ctrl-space>
let g:pymode_rope_map_space = 0
imap <cs-space> <C-R>=RopeCodeAssistInsertMode()<CR>
let g:pymode_lint_write=0 		"д��ʱ�����
"ת�������ݼ�
autocmd FileType python nmap <buffer> <C-]> :RopeGotoDefinition<CR> 
"��ʾ������Ϣ
autocmd FileType python nmap <buffer> <Leader>d :RopeShowDoc<CR> 
let pymode_rope_vim_completion=1
let pymode_rope_extended_complete=1

"python���ն����п�ݼ�
autocmd FileType python nmap <buffer> <F5> :w<CR>:!python.exe %<CR> 

"vdebug(����python)�����ݼ�
let g:vdebug_keymap = {
			\    "run" : "<S-F5>",
			\    "run_to_cursor" : "<S-F1>",
			\    "step_over" : "<S-F2>",
			\    "step_into" : "<S-F3>",
			\    "step_out" : "<S-F4>",
			\    "close" : "<S-F6>",
			\    "detach" : "<S-F7>",
			\    "set_breakpoint" : "<S-F9>",
			\    "get_context" : "<S-F11>",
			\    "eval_under_cursor" : "<S-F12>",
			\}
let g:vdebug_options= {
			\    "port" : 9000,
			\    "server" : 'localhost',
			\    "timeout" : 20,
			\    "on_close" : 'detach',
			\    "break_on_open" : 0,
			\    "ide_key" : '',
			\    "remote_path" : "",
			\    "local_path" : "",
			\    "debug_window_level" : 0,
			\    "debug_file_level" : 0,
			\    "debug_file" : "",
			\}
let g:vdebug_options = {
			\  "marker_default" : '*',
			\  "marker_closed_tree" : '+',
			\  "marker_open_tree" : '-'
			\}

"doxygen toolkit ������ã�
let g:DoxygenToolkit_briefTag_pre=""
let g:DoxygenToolkit_paramTag_pre=""
let g:DoxygenToolkit_returnTag="@Returns   "
let g:DoxygenToolkit_blockHeader="**************************************************************************"
let g:DoxygenToolkit_blockFooter="**************************************************************************"
let g:DoxygenToolkit_authorName="Xiong"
let g:DoxygenToolkit_licenseTag="All right reserved"   
let g:DoxygenToolkit_briefTag_funcName="yes"
let g:doxygen_enhanced_color=1

" For Python Django Template SnipMate
autocmd FileType html set ft=htmldjango.html 

"For NeoSnippet,as SnipMate cann't be used in Python(Tab key conflicts with python-dict)
set completeopt-=preview
imap  <S-space> <Plug>(neosnippet_expand_or_jump)
smap  <S-space> <Plug>(neosnippet_expand_or_jump)
xmap  <S-space> <Plug>(neosnippet_expand_target)

"For tcomment 
let g:tcommentOpModeExtra='>'

"For Fuzzy Finder
let g:fuf_modesDisable = []
let g:fuf_mrufile_maxItem = 1000
let g:fuf_mrucmd_maxItem = 400
let g:fuf_mrufile_exclude = '\v\~$|\.(bak|sw[po])$|^(\/\/|\\\\|\/mnt\/)'
nnoremap <silent> ,m      :FufMruFile<CR>
nnoremap <silent> ,c      :FufMruCmd<CR>
nnoremap <silent> ,t      :FufTag<CR>
nnoremap <silent> ,h      :FufHelp<CR>
nnoremap <silent> ,f      :FufFileWithFullCwd<CR>
let g:fuf_keyOpenSplit = '<S-j>'
let g:fuf_keyOpenVsplit = '<S-k>'

" For jedi-Vim
let g:jedi#auto_vim_configuration = 0
let g:jedi#show_function_definition = "0"
let g:jedi#popup_select_first = 0
"Make jedi integreted  in NeoCompleteCache
if !exists('g:neocomplcache_omni_functions')
    let g:neocomplcache_omni_functions = {}
endif
let g:neocomplcache_omni_functions.python = 'jedi#complete'
let g:jedi#popup_on_dot = 1

" For indent-guides
let g:indent_guides_guide_size = 1
nmap <Leader>ig :IndentGuidesToggle<CR> 
