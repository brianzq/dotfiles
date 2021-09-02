"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: 
"       Amir Salihefendic — @amix3k
"
" Awesome_version:
"       Get this config, nice color schemes and lots of plugins!
"
"       Install the awesome version from:
"
"           https://github.com/amix/vimrc
"
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/bundle')

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ivalkeen/vim-ctrlp-tjump'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'chriskempson/base16-vim'
Plug 'scrooloose/nerdtree'
Plug 'w0rp/ale'
Plug 'tomtom/tcomment_vim'
Plug 'larrylv/vim-vroom'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'benmills/vimux'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'airblade/vim-gitgutter'
Plug 'kshenoy/vim-signature'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'ludovicchabant/vim-gutentags'
Plug 'zackhsi/fzf-copy-ruby-token'
Plug 'drmingdrmer/vim-tabbar'
Plug 'michaeljsmith/vim-indent-object'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'fatih/vim-go'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'neoclide/coc.nvim', {'branch': 'release', 'tag': '*'}
Plug 'sbdchd/neoformat', {'for': ['javascript', 'javascript.jsx']}
Plug 'mattn/emmet-vim'
Plug 'tyru/open-browser.vim'
Plug 'vim-syntastic/syntastic'
Plug 'Yggdroot/indentLine'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => personal
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","
set nu

" set cursorline
set splitbelow                             " New window goes below
set splitright
set wildchar=<Tab>                         " Character for CLI expansion (TAB-completion)
nmap Y y$
map <leader>ev :e $MYVIMRC<cr>
map <leader>vv :vsp $MYVIMRC<cr>
map <leader>eb :e ~/.bot<cr>
map <leader>vb :vsp ~/.bot<cr>

function! NewNote()
  let l:year=strftime("%Y")
  let l:mmdd=strftime("%m%d")
  let l:filename="~/notes/".l:year."/".l:mmdd.".md"
  execute 'edit' l:filename
endfunction

map <leader>n :call NewNote()<cr>
map <leader>so :source $MYVIMRC<cr>:call LightlineReload()<cr>
nnoremap <leader><leader> <c-^>
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" colorscheme base16-default-dark
colorscheme base16-onedark
" colorscheme base16-one-light
let g:loaded_matchparen=1
set signcolumn=yes

augroup general_config
  autocmd!

  " set norelativenumber for insert mode
  " autocmd InsertEnter * set norelativenumber
  " autocmd InsertLeave * set relativenumber

  " Only use cursorline in current window and not when being in insert mode
  " autocmd WinEnter    * set cursorline
  " autocmd WinLeave    * set nocursorline
  " autocmd InsertEnter * set nocursorline
  " autocmd InsertLeave * set cursorline

  " Remap keys for auto-completion menu {{{
  inoremap <expr><tab>  pumvisible() ? "\<C-n>" : "\<tab>"
  inoremap <expr><s-tab> pumvisible() ? "\<C-p>" : "\<s-tab>"
  " }}}

  " Highlight trailing whitespace"{{{
  highlight ExtraWhitespace ctermbg=red guibg=red
  match ExtraWhitespace /\s\+$/
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()
  " }}}
augroup END

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

set relativenumber
" map <leader>r :set relativenumber! <bar> :set scl=no<cr>
map <leader>r :set relativenumber!<cr>
map <silent> <C-n> <Esc>:set nu!<CR>

" Quick move under insert mode (Ctrl-f, Ctrl-b)"{{{
imap <c-f> <c-o>w
imap <c-b> <c-o>b

"}}}

" This seems to cause lag for horizontal scrolling
" set showcmd

set tags=./tags;

" system yank: will copy into the system clipboard on OS X
map <leader>y "+y
map <leader>p "+p

set foldenable                             " Enable folding
set foldlevelstart=99                      " Open all folds by default
set foldmethod=indent                      " Syntax are used to specify folds
" set foldminlines=0                         " Allow folding single lines
" set foldnestmax=5                          " Set max fold nesting level

map <leader>cl :set cursorline!<cr>
set re=1
set tw=100                          " Line length for gq to split

nnoremap <C-g> :!google-chrome %<CR> " browser preview with ctrl-g

if filereadable($HOME.'/.vimrc.local')
  source $HOME/.vimrc.local
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => language specific configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.py
\ set tabstop=2
\ | set softtabstop=2
\ | set shiftwidth=2
\ | set textwidth=120
\ | set expandtab
\ | set autoindent
\ | set fileformat=unix

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" deoplete.nvim {{{
" let g:deoplete#enable_at_startup = 0
" call deoplete#custom#option({
"     \ 'auto_complete_delay': v:false,
"     \ 'max_list': 20,
"     \ 'on_insert_enter': v:false,
"     \ 'skip_chars': ['(', ')', '<', '>'],
"     \ 'skip_multibyte': v:true,
"     \ 'smart_case': v:true,
"     \ })
" autocmd FileType css,csv,html,json,tex,txt
"     \ call deoplete#custom#buffer_option('auto_complete', v:false)
" }}}

" vim-rhubarb {{{
map <leader>Gb :GBrowse<cr>
map <leader>Gc :GBrowse!<cr>
" }}}

" vim-gitgutter {{{
" call gitgutter#highlight#define_highlights()
let g:gitgutter_max_signs = 1024
set updatetime=100
" }}}

" vim-ruby {{{
" let g:ruby_path = system('echo $HOME/.rbenv/shims')
" let ruby_no_expensive = 1
" }}}

" vim-go
let g:go_fmt_command = "goimports"
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_gocode_autobuild = 0
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_list_type = "quickfix"

let g:go_decls_mode = 'fzf'
let g:go_def_mode = 'gopls'
let g:go_info_mode = 'gopls'

function! SetupMapForVimGo()
  " run :GoBuild or :GoTestCompile based on the go file
  function! s:build_go_files()
    let l:file = expand('%')
    if l:file =~# '^\f\+_test\.go$'
      call go#test#Test(0, 1)
    elseif l:file =~# '^\f\+\.go$'
      call go#cmd#Build(0)
    endif
  endfunction

  nmap <leader>gb :<C-u>call <SID>build_go_files()<CR>
  " nmap <leader>gb  <Plug>(go-build)
  nmap <leader>gi <Plug>(go-info)
  nmap <leader>gr <Plug>(go-run)
  nmap <leader>gt <Plug>(go-test)

  nmap <leader>gc :<C-u>GoChannelPeers<CR>

  nmap <leader>gl :<C-u>GoReferrers<CR>

  nmap <leader>tj :<C-u>GoDeclsDir<CR>
  nmap <leader>ts :<C-u>GoDecls<CR>

	" :GoDef but opens in a vertical split
	nmap <Leader>gv <Plug>(go-def-vertical)
	" :GoDef but opens in a horizontal split
	nmap <Leader>gs <Plug>(go-def-split)
  autocmd Filetype go
    \  command! -bang A call go#alternate#Switch(<bang>0, 'edit')
    \| command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
    \| command! -bang AS call go#alternate#Switch(<bang>0, 'split')
endfunction

autocmd FileType go call SetupMapForVimGo()

" ALE {{{
augroup AutoALE
  autocmd!
  autocmd User ALELint call lightline#update()
augroup END

let g:ale_linters = {
      \   'ruby': ['rubocop'],
      \   'go': ['golangci-lint'],
      \   'javascript': ['eslint'],
      \}

let g:ale_lint_on_text_changed = 'never' " lint only on save
let g:ale_lint_on_enter = 0 " don't lint on enter
let g:ale_sign_column_always = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '༅'
let g:ale_echo_msg_format = '[%linter%] %s'
" let g:ale_set_highlights = 0
let g:ale_ruby_rubocop_executable = 'scripts/bin/rubocop-daemon/rubocop'
let g:ale_javascript_eslint_executable = 'eslint_d'
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
"}}}

" UltiSnips {{{
" let g:UltiSnipsExpandTrigger="<c-l>"
" let g:UltiSnipsJumpForwardTrigger="<c-j>"
" let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" let g:UltiSnipsEditSplit="vertical"
" let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
" let g:UltiSnipsUsePythonVersion = 3
" }}}

" fzf.vim {{{
set rtp+=/usr/local/opt/fzf " fzf is installed using Homebrew
" - Popup window (center of the screen)
" let g:fzf_layout = { 'down': '60%' }
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
let g:fzf_preview_window = ['right:hidden', 'ctrl-/']

silent! nnoremap <unique> <silent> <leader>f :Files<CR>
nnoremap <leader>aa :Rg<Space>
nnoremap <silent> <leader>ag :Rg <C-R><C-W><CR>
xnoremap <silent> <leader>ag y:Rg <C-R>"<CR>"
nnoremap <silent> <leader>AG :Rg <C-R><C-A><CR>
silent! nnoremap <unique> <silent> <leader>bb :Buffers<CR>
silent! nnoremap <unique> <silent> <leader>bl :BLines<CR>
nnoremap <leader>tj :Tags 
" list bookmarks
nnoremap <leader>tm :Marks<CR>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-d': 'split',
  \ 'ctrl-e': 'split',
  \ 'ctrl-v': 'vsplit' }

" set rtp+=/usr/local/opt/fzf " fzf is installed using Homebrew
" silent! nnoremap <unique> <silent> <leader>f :FZF<CR>
" nnoremap <leader>aa :Ag<Space>
" nnoremap <silent> <leader>ag :Ag <C-R><C-W><CR>
" xnoremap <silent> <leader>ag y:Ag <C-R>"<CR>"
" nnoremap <silent> <leader>AG :Ag <C-R><C-A><CR>
" silent! nnoremap <unique> <silent> <leader>bb :Buffers<CR>
" silent! nnoremap <unique> <silent> <leader>bl :BLines<CR>
" silent! nnoremap <unique> <silent> <leader>ll :Lines<CR>
" nnoremap <leader>tj :Tags
" nnoremap <leader>tm :Marks<CR>
" nnoremap <leader>ts :Tags
" map <leader>gs :GFiles?<cr>
"
" let g:fzf_action = {
"   \ 'ctrl-t': 'tab split',
"   \ 'ctrl-x': 'split',
"   \ 'ctrl-d': 'split',
"   \ 'ctrl-e': 'split',
"   \ 'ctrl-v': 'vsplit' }
" let s:ag_opts = {"options": ["-d:"]}
" let g:fzf_layout = { 'down': '40%' }
" let g:fzf_preview_window = ['right:50%', 'ctrl-/']
"
" if &columns >= 160
"   let s:horiz_preview_layout = 'right:50%'
" else
"   let s:horiz_preview_layout = 'right:50%:hidden'
" endif
" command! -bang -nargs=* Ag
"   \ call fzf#vim#ag(<q-args>,
"   \                 <bang>0 ? fzf#vim#with_preview(s:ag_opts, 'down:60%')
"   \                         : fzf#vim#with_preview(s:ag_opts, s:horiz_preview_layout, '?'),
"   \                 <bang>0)
" command! -bang -nargs=* Ag
"   \ call fzf#vim#grep(
"   \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
"   \   <bang>0 ? fzf#vim#with_preview(s:ag_opts, 'down:50%')
"   \           : fzf#vim#with_preview(s:ag_opts, s:horiz_preview_layout, '?'),
"   \   <bang>0)
" }}}

" nerdtree {{{
let NERDTreeWinSize = 50
let NERDTreeAutoCenter=1
let NERDTreeChDirMode=2
let g:NERDTreeMinimalUI=1
let g:NERDTreeHijackNetrw=1
let g:NERDTreeWinPos="left"
let g:NERDTreeIgnore=['\~$']
nnoremap <F7> :call NERDTreeToggleInCurDir()<CR>
nnoremap <F2> :call NERDTreeToggleInCurDir()<CR>
function! NERDTreeToggleInCurDir()
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
    exe ":NERDTreeClose"
  elseif (bufname('%') == '' || bufname('%') =~ 'Startify')
    exe ":NERDTreeToggle"
  else
    exe ":NERDTreeFind"
  endif
endfunction
" }}}

" lightline.vim {{{
let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_infos = "\uf129"
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
let g:lightline#ale#indicator_ok = "\uf00c"

let g:lightline = {
      \ 'colorscheme': '16color',
      \ 'active': {
      \   'left': [
      \     [ 'mode' ],
      \     [ 'filename' ],
      \     [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
      \     [ 'ctag' ],
      \   ],
      \   'right': [
      \     [ 'percent', 'lineinfo' ],
      \     [ 'fugitive' ],
      \   ]
      \ },
      \ 'inactive': {
      \   'left': [
      \     [ 'filename' ],
      \   ],
      \   'right': [
      \     [ 'lineinfo' ],
      \     [ 'winnr' ]
      \   ]
      \ },
      \ 'component': {
      \   'lineinfo': "\uf124 ".'%3l:%-2v',
		  \   'percent': "\uf110 ".'%3p%%',
      \   'vim_logo': " \ue7c5 ",
      \ },
      \ 'tabline': {
      \   'left': [ [ 'vim_logo', 'tabs' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \   'winnr': 'MyWinnr',
      \   'ctrlpmark': 'CtrlPMark',
      \   'ctag': 'GetGutentagsStatus',
      \ },
      \ 'component_expand': {
      \   'linter_checking': 'lightline#ale#checking',
      \   'linter_warnings': 'lightline#ale#warnings',
      \   'linter_errors': 'lightline#ale#errors',
      \   'linter_ok': 'lightline#ale#ok',
      \ },
      \ 'component_type': {
      \  'linter_checking': 'left',
      \  'linter_warnings': 'warning',
      \  'linter_errors': 'error',
      \  'linter_ok': 'left',
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \ }

" refresh status line after gutentag tag generation
augroup MyGutentagsStatusLineRefresher
    autocmd!
    autocmd User GutentagsUpdating call lightline#update()
    autocmd User GutentagsUpdated call lightline#update()
augroup END

function! s:get_gutentags_status(mods) abort
    let l:msg = ''
    if index(a:mods, 'ctags') >= 0
       let l:msg .= "\uf02c"
     endif
     if index(a:mods, 'cscope') >= 0
       let l:msg .= "\ue222"
     endif
     return l:msg
endfunction

function! GetGutentagsStatus()
    return gutentags#statusline_cb(function('<SID>get_gutentags_status'))
endfunction

function! MyModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! MyWinnr()
  let fname = expand('%:t')
  let nr = winnr()
  return fname == 'ControlP' ? '' : nr
endfunction

function! MyFilename()
  let fname = expand('%:t')
  let ufname = fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ (
        \   fname == '__Tagbar__' ? g:lightline.fname :
        \   fname =~ '__Gundo\|NERD_tree' ? '' :
        \   &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \   &ft == 'unite' ? unite#get_status_string() :
        \   &ft == 'vimshell' ? vimshell#get_status_string() :
        \   ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \   ('' != fname ? fname : '[No Name]') .
        \   ('' != MyModified() ? ' ' . MyModified() : '')
        \ )
  return "\uf0f6 ".ufname
endfunction

function! LightlineFugitive()
	if exists('*fugitive#head')
		let branch = fugitive#head()
		return branch !=# '' ? "\uf7a1 ".branch : ''
	endif
	return ''
endfunction

function! MyFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = '⭠ '  " edit here for cool mark
      let _ = fugitive#head()
      return strlen(_) ? mark._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  let fname = expand('%:t')
  let mode = fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
  return "\ufcb5 ".mode

endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

" fix statusline after reloading vimrc
command! LightlineReload call LightlineReload()

function! LightlineReload()
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction
" }}}

" ctrlp.vim"{{{
silent! nnoremap <unique> <silent> <leader>cl :CtrlPClearCache<CR>
silent! nnoremap <unique> <silent> <leader>tt :CtrlPTag<CR>
silent! nnoremap <unique> <silent> <leader>d :CtrlP<CR>
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_by_filename = 0
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:20,results:20'
let g:ctrlp_map = '<\-t>'
let g:ctrlp_max_files = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_extensions = [ 'ctrlp-filetpe' ]
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_switch_buffer = 0
let g:ctrlp_mruf_max = 0
let g:ctrlp_mruf_relative = 1
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("h")': ['<c-d>', '<c-cr>', '<c-e>', '<c-x>'],
    \ 'ToggleByFname()':      ['<c-f>'],
    \}
nnoremap <c-]> :CtrlPtjump<cr>
vnoremap <c-]> :CtrlPtjumpVisual<cr>
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v(_build|build|bower_components|deps|dist|node_modules|public|tmp|vendor\/bundle|elm-stuff)$',
  \ }
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files . -co --exclude-standard'],
    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
  \ 'fallback': 'find %s -type f'
  \ }
" let g:ctrlp_tjump_only_silent = 1
"}}}
      
" fzf-copy-ruby-token
nmap <leader>ry <Plug>(fzf_copy_ruby_token)

" markdown-preview
let vim_markdown_preview_hotkey='<C-m>'
let vim_markdown_preview_browser='Google Chrome'
let vim_markdown_preview_toggle=1
let vim_markdown_preview_github=1
let g:mkdp_command_for_global = 1

" Gutentags.
" noremap <Leader>c :GutentagsUpdate!<CR>
let g:gutentags_exclude_filetypes = ['gitcommit']
let g:gutentags_ctags_exclude = [
  \ '.eggs',
  \ '.mypy_cache',
  \ 'venv',
  \ 'tags',
  \ 'tags.temp',
  \ '.ijwb',
  \ 'bazel-*',
  \ 'build',
  \ 'log',
  \ 'node_modules',
  \ 'target',
\ ]
let g:gutentags_ctags_executable_ruby = 'ripper-tags'

""" coc.nvim {{{
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" nmap <silent> <C-d> <Plug>(coc-range-select)
" xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
"}}}

" Neoformat {{{
autocmd BufWritePre *.js Neoformat prettier
autocmd BufWritePre *.jsx Neoformat prettier
" }}}

" tyru/open-browser.vim
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-open)
vmap gx <Plug>(openbrowser-open)

" IndentLine
let g:indentLine_char = "\ue621"
" let g:indentLine_char = '┆'
nnoremap <leader>i :IndentLinesToggle<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => base16_vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" function! s:base16_customize() abort
"   call Base16hi("MatchParen", g:base16_gui05, g:base16_gui03, g:base16_cterm05, g:base16_cterm00, "bold,italic", "")
" endfunction
" 
" augroup on_change_colorschema
"   autocmd!
"   autocmd ColorScheme * call s:base16_customize()
" augroup END

" Bind <leader>d to go-to-definition.
nmap <silent> <leader>d <Plug>(ale_go_to_definition)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
runtime macros/matchit.vim
set nocompatible
if has("autocmd")
  filetype indent plugin on
endif

" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en' 
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
" set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
" set showmatch 
" How many tenths of a second to blink when matching brackets
" set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" Add a bit extra margin to the left
set foldcolumn=0

set synmaxcol=500                          " Syntax coloring lines that are too long just slows down the world
nnoremap <C-l> <NOP>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable 
syntax sync minlines=10000

set background=dark

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" I can move around in insert
inoremap <C-k> <C-o>gk
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-j> <C-o>gj

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
map <leader>vsp :vsp <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.rb,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>er :e ~/buffer.rb<cr>

" Quickly open a markdown buffer for scribble
map <leader>em :e ~/buffer.md<cr>

" Copy current filename to system clipboard
map <leader>cf :let @+=@%<cr>:echo @% "copied to system clipboard"<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Hightlight group overrides
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi! LineNr ctermbg=0
hi! CursorLineNR ctermbg=11
hi! clear SignColumn
hi! GitGutterAdd ctermbg=0
hi! GitGutterChange ctermbg=0
hi! GitGutterDelete ctermbg=0
hi! GitGutterChangeDelete ctermbg=0
hi! ALEErrorSign ctermbg=0 ctermfg=1
hi! ALEWarningSign ctermbg=0 ctermfg=3
"
" function! s:base16_customize() abort
"   " call Base16hi("TabLine",     g:base16_gui03, g:base16_gui0D, g:base16_cterm0D, g:base16_cterm00, "", "")
"   " call Base16hi("TabLineFill",     g:base16_gui03, g:base16_gui0D, g:base16_cterm0D, g:base16_cterm00, "", "")
"   " call Base16hi("TabLineSel",     g:base16_gui03, g:base16_gui0D, g:base16_cterm0D, g:base16_cterm00, "", "")
"   call Base16hi('TabLine', '', '', g:base16_cterm03, g:base16_cterm01)
"   call Base16hi('TabLineFill', '', '', '', g:base16_cterm03)
"   call Base16hi('TabLineSel', '', '', '', g:base16_cterm06)
" endfunction
"
" augroup on_change_colorschema
"   autocmd!
"   autocmd ColorScheme * call s:base16_customize()
" augroup END
"
" hi TabLineSel term=bold cterm=bold ctermfg=6 ctermbg=11
" hi TabWinNumSel term=bold cterm=bold ctermfg=9 ctermbg=8
" hi TabNumSel term=bold cterm=bold ctermfg=6 ctermbg=3
set noshowmode
