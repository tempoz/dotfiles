function! OpenFileFromVimTerminal(fn)
	exec 'leftabove vert split ' . a:fn
	return 0
endfunction

if len($VIM_TERMINAL)
	if len($VIM_SERVERNAME) && len(v:argv) == 2 && v:argv[1][0] != '-'
		let fn = fnamemodify(v:argv[1], ':p')
		let expr1 = 'OpenFileFromVimTerminal("' . fn . '")'
		" echo expr1
		call remote_expr($VIM_SERVERNAME, expr1)
		qa!
	else
		echo "Nested vim only supports 'vim <filename>'."
		cq!
	endif
endif
" if &shell =~# 'fish$'
    " set shell=sh
" endif

set number
set relativenumber
set ts=2
set sw=2
set noexpandtab
set backspace=indent,eol,start
set ignorecase
set termguicolors

let mapleader = ","

" Settings for powerline
set laststatus=2
set cmdheight=1
set noshowmode
set shortmess+=F
" set term=xterm-256color
set rtp+=/usr/share/vim/addons

" Settings for terminal use in vim
au TerminalOpen * if &buftype == 'terminal' | setlocal bufhidden=hide | endif
set termwinscroll=131072

call plug#begin()
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'morhetz/gruvbox'
Plug 'dag/vim-fish'
Plug 'tempoz/nerdtree', {'branch': 'splex'}
Plug 'ctrlpvim/ctrlp.vim', {'tag': '1.81'}
" Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
Plug 'habamax/vim-godot'
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': ':CocInstall coc-prettier coc-html coc-git coc-yaml coc-tsserver coc-sh coc-python coc-pyright coc-json coc-go coc-css coc-cmake coc-clangd coc-fish coc-vimlsp @onichandame/coc-proto3'}
Plug 'tpope/vim-fugitive'
Plug 'OmniSharp/omnisharp-vim'
Plug 'fladson/vim-kitty'
call plug#end()

" Disable vim-go code completion in favor of coc
let g:go_code_completion_enabled = 0

" Disable vim-go go to definition mapping
let g:go_def_mapping_enabled = 0

" let g:node_client_debug = 1 " :call coc#client#open_log()

set tagfunc=CocTagFunc

filetype plugin indent on

let g:gruvbox_italic=1
set background=dark
colorscheme gruvbox

let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1

" NERDTree Config

let NERDTreeShowHidden=1
let NERDTreeHijackNetrw=1
let g:ctrlp_dont_split = 'NERD'

let NERDTreeNaturalSort=1
let NERDTreeSplexMode=1

" mnemonic: x for eXplore
nnoremap <silent> <leader>x :NERDTreeFind<CR>

function! OpenTerminal()
	vert call term_start(
		\$SHELL,
		\	{
			\ 'term_finish': 'close',
			\	'ansi_colors': [
				\'#fbf1c7',
				\'#cc241d',
				\'#98971a',
				\'#d79921',
				\'#458588',
				\'#b16286',
				\'#689d6a',
				\'#7c6f64',
				\'#928374',
				\'#9d0006',
				\'#79740e',
				\'#b57614',
				\'#076678',
				\'#8f3f71',
				\'#427b58',
				\'#3c3836'
			\]
		\}
	\)
endfunction
	

" mnemonic: t for Terminal
nnoremap <silent> <leader>t :call OpenTerminal()<CR>

" mnemonic: s for syntax
nnoremap <silent> <leader>s :syntax sync fromstart<CR>

" mnemonic: c for copy/paste
nnoremap <silent> <leader>c :set signcolumn=no<CR>:set nonumber<CR>:set norelativenumber<CR>

" mnemonic: g for gutter
nnoremap <silent> <leader>g :set signcolumn=yes<CR>:set number<CR>:set relativenumber<CR>

autocmd FileType bzl setlocal shiftwidth=4 tabstop=4 expandtab

""" BEGIN COC.NVIM BOILERPLATE VIMRC


" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
  " But I don't like it.
  set signcolumn=yes
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Insert <tab> when previous text is space, refresh completion if not.
inoremap <silent><expr> <TAB>
\ coc#pum#visible() ? coc#pum#next(1):
\ <SID>check_back_space() ? "\<Tab>" :
\ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)

omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


""" END COC.NVIM BOILERPLATE VIMRC
