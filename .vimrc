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

" Essentials {{{
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tomtom/tcomment_vim'                                                            "  gcc for comment
Plug 'kshenoy/vim-signature'                                                          "  marks
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'                                                           "  [f for file, [q for tab, [<space> for empty line above, [e for moving line above
Plug 'tpope/vim-obsession'                                                            "  automatically saves buffers to session
Plug 'michaeljsmith/vim-indent-object'                                                "  >[count]ai/ii for indenting block
Plug 'godlygeek/tabular'                                                              "  tabularize lines
Plug 'github/copilot.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" }}}

" Appearance {{{
Plug 'drmingdrmer/vim-tabbar'
Plug 'chriskempson/base16-vim'
Plug 'itchyny/lightline.vim', {'commit': '6daec38c1da2cbfae43d4d0d67f6a4fa7680c2b5'}  "  commit for base16 color fix
Plug 'maximbaz/lightline-ale'
if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }                           "  file browser
else
  Plug 'Shougo/defx.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'Yggdroot/indentLine'                                                            "  display vertical lines for indentation
" }}}

" Linter & LSP {{{
Plug 'dense-analysis/ale'                                                             "  Asynchronous Lint Engine
Plug 'larrylv/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf'
Plug 'larrylv/vim-tagimposter'                                                        "  populate the tagstack when using coc to jump to definitions
""" }}}

" Git related {{{
Plug 'tpope/vim-fugitive'                                                             "  Git wrapper, GBrowse
Plug 'tpope/vim-rhubarb'                                                              "  Enable GBrowse to open link in browser
Plug 'airblade/vim-gitgutter'                                                         "  show git diffs
" }}}

" Language specific {{{
" Ruby
Plug 'kana/vim-textobj-user'                                                          "  dependency for vim-textobj-rubyblock
Plug 'nelstrom/vim-textobj-rubyblock'                                                 "  ar/ir for ruby block
Plug 'benmills/vimux'
Plug 'larrylv/vim-vroom'
Plug 'zackhsi/fzf-copy-ruby-token'                                                    "  copy fully qualified ruby class name

" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }


" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'preservim/vim-markdown'
Plug '907th/vim-auto-save'                                                            "  auto save files, I only use it for markdown files for notes

" Yaml
Plug 'Einenlum/yaml-revealer'                                                         "  shows yaml key hierarchy for current line

" Javascript
" Plug 'sbdchd/neoformat', {'for': ['javascript', 'javascript.jsx']}
" Plug 'mattn/emmet-vim'
" }}}
"
"
" Legacy {{{
" Plug 'ctrlpvim/ctrlp.vim'
" Plug 'ivalkeen/vim-ctrlp-tjump'
" Plug 'FelikZ/ctrlp-py-matcher'
"
" Plug 'AndrewRadev/splitjoin.vim'
" Plug 'tyru/open-browser.vim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Plug 'nvim-treesitter/nvim-treesitter-context'                                      "  show code context
" }}}

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => personal
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","
set nu

set cursorline
set splitbelow                             " New window goes below
set splitright
set wildchar=<Tab>                         " Character for CLI expansion (TAB-completion)
nmap Y y$
map <leader>ev :e $HOME/.vimrc<cr>
map <leader>vv :vsp $MYVIMRC<cr>
map <leader>eb :MyFiles ~/notes/2022/<cr>
map <leader>vb :vsp ~/.bot<cr>

function! NewNote()
  let l:year=strftime("%Y")
  let l:mmdd=strftime("%m%d")
  let l:filename="~/notes/".l:year."/".l:mmdd.".md"
  execute 'edit' l:filename
endfunction

map <leader>n :call NewNote()<cr>
map <leader>so :source $MYVIMRC <cr>:LightlineReload<cr>
nnoremap <leader><leader> <c-^>
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" colorscheme base16-default-dark
colorscheme base16-onedark
" colorscheme base16-one-light
let g:loaded_matchparen=1
set signcolumn=yes

let g:python3_host_prog = $HOME . '/.local/venv/nvim/bin/python'

augroup general_config
  autocmd!

  " Remap keys for auto-completion menu {{{
  inoremap <silent><expr> <C-n>
    \ coc#pum#visible() ? coc#pum#next(1) : "\<C-n>"
  inoremap <silent><expr> <C-p>
    \ coc#pum#visible() ? coc#pum#prev(1) : "\<C-p>"
  inoremap <silent><expr> <CR>
    \ coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
  inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#pum#next(1) :
    \ pumvisible() ? "\<C-n>" :
    \ "\<tab>"
  inoremap <silent><expr> <S-TAB>
    \ coc#pum#visible() ? coc#pum#prev(1) :
    \ pumvisible() ? "\<C-p>" :
    \ "\<s-tab>"
  inoremap <silent><expr> <C-space>
    \ coc#refresh()
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

nnoremap <C-g> :!google-chrome %<CR> " browser preview with ctrl-g

if filereadable($HOME.'/.vimrc.local')
  source $HOME/.vimrc.local
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => language specific configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.py
\ set tabstop=4
\ | set softtabstop=4
\ | set shiftwidth=4
\ | set textwidth=120
\ | set expandtab
\ | set autoindent
\ | set fileformat=unix

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

autocmd BufNewFile,BufRead,BufEnter,TabEnter,WinEnter,VimEnter,GUIEnter *.rbi set filetype=ruby syntax=ruby
autocmd BufNewFile,BufRead,BufEnter,TabEnter,WinEnter,VimEnter,GUIEnter *.md setlocal textwidth=100
autocmd Filetype gitcommit setlocal textwidth=100
autocmd Filetype gitcommit,markdown set colorcolumn=101

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
      \   'python': ['pylint', 'mypy'],
      \   'ruby': ['rubocop'],
      \   'go': ['golangci-lint'],
      \   'javascript': ['eslint'],
      \}
let g:ale_fixers = {
      \   'python': ['black'],
      \}
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'never' " lint only on save
let g:ale_lint_on_enter = 0 " don't lint on enter
let g:ale_sign_column_always = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '༅'
let g:ale_echo_msg_format = '[%linter%] %s'

" Language specific
let g:ale_go_golangci_lint_package = 1
let g:ale_go_golangci_lint_options = ''
let g:ale_ruby_rubocop_executable = 'scripts/bin/rubocop-daemon/rubocop'
let g:ale_javascript_eslint_executable = 'eslint_d'

" for python linters to work properly, `pip3 install pylint myppy` in the venv
" in the project path
let g:ale_python_pylint_executable = 'python3 -m pylint'
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

" coc.fzf {{{
" let g:coc_fzf_preview = ''
" let g:coc_fzf_opts = []
" }}}
"
" fzf.vim {{{
set rtp+=/opt/homebrew/bin/fzf " fzf is installed using Homebrew
" - Popup window (center of the screen)
" let g:fzf_layout = { 'down': '60%' }
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
let g:fzf_preview_window = ['right:hidden', 'ctrl-/']

" silent! nnoremap <unique> <silent> <leader>f :Files<CR>
nnoremap <leader>aa :Rg<Space>
nnoremap <silent> <leader>ag :Rg <C-R><C-W><CR>
xnoremap <silent> <leader>ag y:Rg <C-R>"<CR>
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

function! s:cache_list_cmd()
  let ref = system('/usr/local/bin/git symbolic-ref -q HEAD 2>/dev/null')
	if ref == ''
    return $FZF_DEFAULT_COMMAND
	endif

  " trim the newline output from rev-parse
  let head_commit = system('git rev-parse HEAD | tr -d "\n"')
  let cache_file = '/tmp/'.head_commit.'.files'
  if !filereadable(expand(cache_file))
    execute 'silent !' . $FZF_DEFAULT_COMMAND . ' > '.cache_file
  endif

  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ?
    \ printf('cat %s', cache_file) :
    \ printf('cat %s | proximity-sort %s', cache_file, expand('%'))
endfunction

command! -bang -nargs=? -complete=dir MyFiles
  \ call fzf#vim#files(<q-args>, {'source': s:cache_list_cmd(),
  \                               'options': ['--tiebreak=index']}, <bang>0)
command! -bang -nargs=* FilesNoIgnore
  \ call fzf#run(fzf#wrap({'source': 'fd --hidden --follow --no-ignore --type f', 'width': '90%', 'height': '60%', 'options': '--expect=ctrl-t,ctrl-x,ctrl-v --multi' }))
" Show search results from files and directories that would otherwise be ignored
" by '.gitignore' files.
command! -bang -nargs=* FilesNoIgnoreVcs
  \ call fzf#run(fzf#wrap({'source': 'fd --hidden --follow --no-ignore-vcs --type f', 'width': '90%', 'height': '60%', 'options': '--expect=ctrl-t,ctrl-x,ctrl-v --multi' }))

silent! nnoremap <unique> <silent> <leader>f :MyFiles<CR>
silent! nnoremap <unique> <silent> <leader>F :FilesNoIgnore<cr>
" }}}

" copilot {{{
let g:copilot_enabled = 0

function! ToggleCopilot()
  if g:copilot_enabled == 0
    execute 'Copilot enable'
    echo "Copilot enabled"
  else
    execute 'Copilot disable'
    echo "Copilot disabled"
  endif
endfunction

nnoremap <leader>co <CR>:call ToggleCopilot()<CR>
" }}}

" defx.nvim {{{
nnoremap <F2> :Defx `getcwd()` -search_recursive=`expand('%:p')` -toggle<CR>
" Move the cursor to the already-open Defx, and then switch back to the file
nnoremap <leader>dn :Defx `getcwd()` -search_recursive=`expand('%:p')` -no-focus<CR>

let g:extra_whitespace_ignored_filetypes = ['unite']
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  setlocal nonu
  setlocal norelativenumber

  highlight! default link Defx_filename_root Statement
  highlight! default link Defx_filename_root_marker Statement
  highlight! default link Defx_icon_root_icon Statement
  highlight! default link Defx_filename_directory Directory
  highlight! default link Defx_icon_directory_icon Directory
  highlight! default link Defx_icon_opened_icon Directory

  " Define mappings
  nnoremap <silent><buffer><expr> o
        \ defx#is_directory() ?
        \ defx#do_action('open_tree', 'toggle') :
        \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> <CR>
        \ defx#is_directory() ?
        \ defx#do_action('open_tree', 'toggle') :
        \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> c
        \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
        \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
        \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> i
        \ defx#do_action('multi', [['drop', 'split']])
  nnoremap <silent><buffer><expr> s
        \ defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> K
        \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N
        \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M
        \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> d
        \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> r
        \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> yy
        \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> q
        \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Space>
        \ defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> *
        \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> j
        \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
        \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> R
        \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> >
        \ defx#do_action('resize', defx#get_context().winwidth + 10)
  nnoremap <silent><buffer><expr> <
        \ defx#do_action('resize', defx#get_context().winwidth - 10)
  nnoremap <silent><buffer><expr> <leader>p
        \ defx#do_action('print')
  nnoremap <silent><buffer><expr> P
        \ defx#do_action('search', fnamemodify(defx#get_candidate().action__path, ':h'))
endfunction

call defx#custom#option('_', {
      \ 'root_marker': '',
      \ 'columns': 'indent:icon:filename',
      \ 'winwidth': 42,
      \ 'split': 'vertical',
      \ 'direction': 'topleft',
      \ 'buffer_name': 'DEFX',
      \ })

call defx#custom#column('icon', {
      \ 'directory_icon': '▸ ',
      \ 'file_icon': '  ',
      \ 'opened_icon': '▾ ',
      \ 'root_icon': '  ',
      \ })

call defx#custom#column('indent', {
      \ 'indent': '  ',
      \ })

call defx#custom#column('filename', {
      \ 'min_width': 80,
      \ 'max_width': 120,
      \ })
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
      \     [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok', 'cocstatus', 'obsession_status' ],
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
      \   'cocstatus': 'MyCocStatus',
      \   'obsession_status': 'LightlineObsession',
      \ },
      \ 'component_expand': {
      \   'linter_checking': 'lightline#ale#checking',
      \   'linter_warnings': 'lightline#ale#warnings',
      \   'linter_errors': 'lightline#ale#errors',
      \   'linter_ok': 'lightline#ale#ok',
      \   'cocstatus': 'MyCocStatus',
      \ },
      \ 'component_type': {
      \  'linter_checking': 'left',
      \  'linter_warnings': 'warning',
      \  'linter_errors': 'error',
      \  'linter_ok': 'left',
      \  'cocstatus': 'left',
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \ }

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

function! CurrentLspStatus(cocstatus)
  if len(a:cocstatus) == 0
    return a:cocstatus
  endif

  " find the lsp for current file
  let lsp = &ft == 'ruby' ? 'sorbet' :
      \ (
      \   &ft == 'go' ? 'gopls' :
      \   &ft == 'scala' ? 'metals' :
      \   &ft =~ 'typescript\|typescriptreact\|typescript.tsx\|typescript.jsx\|javascript\|javascriptreact\|javascript.jsx' ? 'tsserver' :
      \   &ft == 'json' ? 'json' : ''
      \ )

  if len(lsp) == 0
    return ''
  endif

  " replace json lsp with a shorter name
  let cocstatus = substitute(a:cocstatus, 'Json language server', 'json', '')
  let cocstatus = substitute(cocstatus, 'Initializing tsserver [^\s]*', 'tsserver:starting', '')
  let cocstatus = substitute(cocstatus, 'TSC [^\s]*', "tsserver:running", '')
  let cocstatus = substitute(cocstatus, 'Metals', "metals:running", '')

  " get a list of lsp status
  let statuslist = split(cocstatus)

  " return the lsp status
  for status in statuslist
    if status =~ lsp
      return status
    endif
  endfor

  " don't return anything if the file doesn't use lsp
  return ''
endfunction

function! GetFilename(fname)
  let fname = a:fname
  let ufname = fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ (
        \   fname =~ 'Tagbar' ? 'Tagbar' :
        \   fname =~ 'CocTree' ? 'CocTree' :
        \   fname =~ '__Gundo\|NERD_tree\|\[defx\]' ? 'Explorer' :
        \   fname =~ ';#FZF' ? '[FZF]' :
        \   fname =~ '!sh' ? '[FZF]' :
        \   &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \   &ft == 'unite' ? unite#get_status_string() :
        \   &ft == 'vimshell' ? vimshell#get_status_string() :
        \   ('' != fname ? "\uf0f6 " . fname : '[No Name]')
        \ )
  return ufname
endfunction

function! MyCocStatus()
  let fname = GetFilename(expand('%:t'))
  let cocstatus = coc#status()
  return fname == 'ControlP' ? '' :
      \ (
      \   fname =~ 'Tagbar' ? '' :
      \   fname =~ 'CocTree' ? '' :
      \   fname =~ 'Explorer' ? '' :
      \   fname =~ '\[FZF\]' ? '' :
      \   fname =~ '\[No Name\]' ? '' :
      \   CurrentLspStatus(cocstatus)
      \ )
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

function LightlineObsession()
    return ObsessionStatus("\uf46a", "\ueb9f")
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
  echo "Lightline reloaded"
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
" nnoremap <c-]> :CtrlPtjump<cr>
" vnoremap <c-]> :CtrlPtjumpVisual<cr>
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
let g:ctrlp_tjump_only_silent = 1
"}}}

" fzf-copy-ruby-token
" <cword> expansion relies on `iskeyword`. This fixes tag jumping.
augroup RubySpecialKeywordCharacters
  autocmd!
  autocmd Filetype ruby setlocal iskeyword+=!
  autocmd Filetype ruby setlocal iskeyword+=?
augroup END
nmap <leader>ry <Plug>(fzf_copy_ruby_token)

" markdown-preview
" nmap <C-m> <Plug>MarkdownPreview
nmap <leader>pp <Plug>MarkdownPreview
" let vim_markdown_preview_hotkey='<C-m>'
let vim_markdown_preview_browser='Google Chrome'
let vim_markdown_preview_toggle=1
let vim_markdown_preview_github=1
let g:mkdp_command_for_global = 1

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

let g:coc_snippet_next = '<tab>'

" Disable transparent cursor when CocList is activated.
let g:coc_disable_transparent_cursor = 1

" coc will install missing extensions after coc.nvim service starts.
let g:coc_global_extensions = [
  \ 'coc-json',
  \ 'coc-go',
  \ 'coc-omni',
  \ 'coc-tag',
  \ ]

" this is commented out because vim-go already does this
" autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

autocmd FileType go nmap <leader>gtj :CocCommand go.tags.add json<cr>
autocmd FileType go nmap <leader>gty :CocCommand go.tags.add yaml<cr>
autocmd FileType go nmap <leader>gtx :CocCommand go.tags.clear<cr>

function! ToggleOutline() abort
  let winid = coc#window#find('cocViewId', 'OUTLINE')
  if winid == -1
    call CocActionAsync('showOutline')
  else
    call coc#window#close(winid)
  endif
endfunction
autocmd FileType go nnoremap <F3> :call ToggleOutline()<cr>

function! g:CocShowDocumentation()
  " supports jumping to vim documentation as well using built-ins.
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

nnoremap <leader>ci :CocInfo<cr>
nnoremap <leader>cr :CocRestart<cr>

" jump to definition(s) of current symbol
nnoremap <silent> <c-]> :<C-u> TagImposterAnticipateJump <Bar> call CocAction('jumpDefinition', v:false)<cr>
nnoremap <silent> <leader>gd :<C-u> TagImposterAnticipateJump <Bar> call CocAction('jumpDefinition')<cr>
nnoremap <silent> <leader>gv :<C-u> TagImposterAnticipateJump <Bar> call CocAction('jumpDefinition', 'vsplit')<cr>
nnoremap <silent> <leader>gs :<C-u> TagImposterAnticipateJump <Bar> call CocAction('jumpDefinition', 'split')<cr>
" nnoremap <silent> <leader>gt :<C-u> TagImposterAnticipateJump <Bar> call CocAction('jumpDefinition', 'tabe')<cr>

" let g:coc_enable_locationlist = 0
" autocmd User CocLocationsChange CocFzfList --normal location

" jump to references of current symbol
nmap <silent> <leader>gu <Plug>(coc-references)
" jump to declaration(s) of current symbol
nmap <silent> <leader>gc <Plug>(coc-declaration)
" jump to implementation(s) of current symbol
nmap <silent> <leader>gi <Plug>(coc-implementation)
" rename symbol under cursor
nmap <silent> <leader>rn <Plug>(coc-rename)
" show documentation of  current symbol
nnoremap <silent> K :call CocShowDocumentation()<cr>

" redraw the status line when coc#status changes
augroup AutoCocStatus
  autocmd!
  autocmd User CocStatusChange call lightline#update()
augroup END
" }}}

""" vim-auto-save {{{
let g:auto_save = 0
augroup ft_markdown
  au!
  au FileType markdown let b:auto_save = 1
augroup END
" }}}

""" vim-markdown {{{
" Enable conceal feature
autocmd FileType markdown setlocal conceallevel=1
autocmd FileType markdown setlocal concealcursor=nc

let g:vim_markdown_conceal = 1
let g:vim_markdown_conceal_code_blocks = 0
" }}}

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

" Syntax coloring lines that are too long just slows down the world
set synmaxcol=500
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
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" user Alt+<num> to switch tabs
nnoremap <M-1> 1gt
nnoremap <M-2> 2gt
nnoremap <M-3> 3gt
nnoremap <M-4> 4gt
nnoremap <M-5> 5gt
nnoremap <M-6> 6gt
nnoremap <M-7> 7gt
nnoremap <M-8> 8gt
nnoremap <M-9> 9gt

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
" coc popup menu highlighting overrides
exe 'hi default CocMenuSel '.coc#highlight#create_bg_command('CocFloating', &background ==# 'dark' ? -20 : 20)
exe 'hi default CocFloatThumb '.coc#highlight#create_bg_command('CocFloating', &background ==# 'dark' ? -40 : 40)
hi default link CocFloatSbar CocFloating
hi default link CocFloating NormalFloat

set noshowmode
