
set nocompatible

" 画面表示
"------------------------------------------------------------

set number 		    " 行番号を表示する

set laststatus=2 	" ステータス行を常に表示

set cmdheight=2 	" メッセージ表示欄を2行確保

set showcmd         " 入力中のコマンドを表示する

set showmatch 		" 対応する括弧を強調表示

set helpheight=999 	" ヘルプを画面いっぱいに開く

syntax on           " 文字に色を付ける


" Shift-JIS形式のファイルの文字化けを防ぐ
" :set encoding=utf-8
" :set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8


" 全角スペースを見やすく表示する
if has('syntax')
  syntax enable
  function! ActivateInvisibleIndicator()
    highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=#FF0000
    match ZenkakuSpace /　/
  endfunction
  augroup InvisibleIndicator
    autocmd!
    autocmd BufEnter * call ActivateInvisibleIndicator()
  augroup END
endif

" カーソル移動関連
"---------------------------------------------------------------------------

set backspace=indent,eol,start  " Backspaceキーの影響範囲に制限を設けない

set whichwrap=b,s,h,l,<,>,[,]   " 行頭行末の左右移動で行をまたぐ

" 括弧入力時にカーソルを中に移動する
function! MyInsertBracket(lbrackets, rbracket)
    if index(a:lbrackets, getline('.')[col('.') - 2]) != -1
        return a:rbracket . "\<Left>"
    else
        return a:rbracket
    endif
endfunction
inoremap <expr> ) MyInsertBracket(['('], ')')
inoremap <expr> } MyInsertBracket(['{'], '}')
inoremap <expr> ] MyInsertBracket(['['], ']')
inoremap <expr> > MyInsertBracket(['<'], '>')
inoremap <expr> " MyInsertBracket(['"'], '"')
inoremap <expr> ' MyInsertBracket(['''', '`'], '''')



" ファイル処理関連
"---------------------------------------------------------------------------

set confirm    		" 保存されていないファイルがあるときは終了前に保存確認

set autoread   		" 外部でファイルに変更がされた場合は読みなおす

set noswapfile      " スワップファイルを作らない





" 検索/置換の設定
" -----------------------------------------------------------

set hlsearch   		" 検索文字列をハイライトする

set ignorecase 		" 大文字と小文字を区別しない

set smartcase       "ただし大文字小文字の両方が含まれている場合は大文字小文字を区別する





" タブ/インデントの設定
" ------------------------------------------------------------------------------------

set expandtab     " タブ入力を複数の空白入力に置き換える

set tabstop=4     " 画面上でタブ文字が占める幅

set shiftwidth=4  " インデントでずれる幅

set softtabstop=4 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅

set autoindent    " 改行時に前の行のインデントを継続する







" OS/環境との統合
"---------------------------------------------------------

" ZZ で強制終了するのを禁止 
nnoremap ZZ <Nop>

set mouse=a  " マウスの入力を受け付ける




source $VIMRUNTIME/mswin.vim  " Ctrl-V、Ctrl-C、Ctrl-Xが使えるようにする
                              " Ctrl-Cのプログラム動作停止はCtrl-BREAKで代用
                              " Ctrl-Vの方形視覚選択はCtrl-Qで代用

" mswin.vimスクリプトを使用すると、いくつかの機能で制限を受けます。
" ●「:set guioptions+=a」で使用できる、ビジュアルモードで選択したテキストがクリップボードに入る機能が無効になります。
" ●「Ctrl-a」による数字のインクリメント機能は、全選択のマッピングと置き換えられてしまいます。（使えなくなります。）




" 挿入モード時、ステータスラインの色を変更
"-----------------------------------------------------------------
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction



" プラグイン
"----------------------------------------------------------------------

if has ('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" NeoBundleをNeoBundleで管理する
NeoBundleFetch 'Shougo/neobundle.vim'

" ファイルオープンを便利に
NeoBundle 'Shougo/unite.vim'

" Unite.vimで最近使ったファイルを表示できるようにする
NeoBundle 'Shougo/neomru.vim'

" 入力補完=============================================================
NeoBundle 'Shougo/neocomplcache'
" AutoComplPopの無効化
let g:acp_enableAtStartup = 0
" vimを立ち上げた時に、自動でneocomplcacheをONにする
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Enable heavy features.
" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

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
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

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
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
" =====================================================================

" Ruby向けにendを自動挿入してくれる
NeoBundle 'tpope/vim-endwise'

" コメントON/OFFを手軽に実行
NeoBundle 'tomtom/tcomment_vim'

" インデントに色を付けて見やすくする======================================
NeoBundle 'nathanaelkane/vim-indent-guides'

" vimを立ち上げた時に、自動でvim-indent-guidesをONにする
let g:indent_guides_enable_on_vim_startup = 1

" ガイドをスタートするインデントの量
let g:indent_guides_start_level=2

" 自動カラー無効
let g:indent_guides_auto_colors=0

" 奇数インデントのカラー
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=#444433 ctermbg=gray

" 偶数インデントのカラー
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#333344 ctermbg=darkgray

" ハイライト色の変化の幅
let g:indent_guides_color_change_percent = 30

" ガイドの幅
let g:indent_guides_guide_size = 1

"=========================================================================

" solarized カラースキーム
  NeoBundle 'altercation/vim-colors-solarized'
" mustang カラースキーム
  NeoBundle 'croaker/mustang-vim'
" wombat カラースキーム
  NeoBundle 'jeffreyiacono/vim-colors-wombat'
" jellybeans カラースキーム
  NeoBundle 'nanotech/jellybeans.vim'
" lucius カラースキーム
  NeoBundle 'vim-scripts/Lucius'
" zenburn カラースキーム
  NeoBundle 'vim-scripts/Zenburn'
" mrkn256 カラースキーム
  NeoBundle 'mrkn/mrkn256.vim'
" railscasts カラースキーム
  NeoBundle 'jpo/vim-railscasts-theme'
" pyte カラースキーム
  NeoBundle 'therubymug/vim-pyte'
" molokai カラースキーム
  NeoBundle 'tomasr/molokai'
" カラースキーム一覧表示に Unite.vim を使う
  NeoBundle 'ujihisa/unite-colorscheme'
" コマンドラインで :Unite colorscheme -auto-previewすると試し見


call neobundle#end()

filetype plugin indent on

" Vim起動時に未インストールのbundleがないかどうかをチェック
NeoBundleCheck

" カラースキームの選択
colorscheme molokai



