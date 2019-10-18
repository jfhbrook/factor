" Vim syntax file
" Language:	factor
" Maintainer:	Alex Chapman <chapman.alex@gmail.com>
" Last Change:	2006 Mar 23

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" factor is case sensitive.
syn case match

"is there a better way to make vim treat any non-whitespace char as part of a word?
setlocal iskeyword+=-
setlocal iskeyword+=+
setlocal iskeyword+=(
setlocal iskeyword+=)
setlocal iskeyword+=>
setlocal iskeyword+=<
setlocal iskeyword+=?
setlocal iskeyword+=_
setlocal iskeyword+=,
setlocal iskeyword+=:
setlocal iskeyword+=#
setlocal iskeyword+=&
setlocal iskeyword+=\[
setlocal iskeyword+=\]
setlocal iskeyword+=\/
setlocal iskeyword+=\{
setlocal iskeyword+=\}
setlocal iskeyword+=\.
setlocal iskeyword+=\!
setlocal iskeyword+=\$
setlocal iskeyword+=\^


syn cluster factorCluster contains=factorComment,factorKeyword,factorRepeat,factorConditional,factorBoolean,factorColon,factorDefn,factorDefnBody,factorDefnEnd,factorString,@factorNumber

" Script headers highlighted like comments
syn match factorComment /\<#! .*/ contains=factorTodo
syn match factorComment /\<! .*/ contains=factorTodo
syn keyword factorTodo TODO FIXME XXX contained

syn keyword factorBoolean	boolean f general-t t

" use this to have keywords as all words from all vocabs (currently broken by | characters)


" use this to only have keywords highlighted from the kernel vocab
syn keyword factorKeyword continuation-name set-datastack wrapper continuation-catch set-continuation-name cli-bool-param slip pick 2slip tuple 2nip set-boot default-cli-args with-datastack clone cpu tuck -rot swapd <continuation> >boolean wrapper? ifcc dupd dup 3dup callstack windows? os-env over = continue <wrapper> ? 2dup continuation cond win64? set-path run-user-init 3drop when hashcode cli-param default-shell millis set-callstack unless >r version die callcc0 callcc1 num-types or os depth 3keep cli-var-param continue-with if exit tuple? unix? cli-args (continue-with) general-t continuation? hashcode* parse-command-line macosx? r> rot win32? 2apply >continuation< type continuation-call clear no-cond call continuation-data 2drop cli-arg set-continuation-call drop set-continuation-data keep-datastack and when* swap ?if 2swap literalize datastack set-continuation-catch unless* not eq? with wrapped keep 2keep <=> nip if* 


syn cluster factorNumber contains=factorInt,factorFloat,factorRatio,factorComplex
syn cluster factorReal   contains=factorInt,factorFloat,factorRatio
syn match   factorInt 		/\<-\=\d\+\>/
syn match   factorFloat		/\<-\=\d*\.\d\+\>/
syn match   factorRatio		/\<-\=\d*\.*\d\+\/-\=\d*\.*\d\+\>/
syn region  factorComplex	start=/\<C{\>/ end=/\<}\>/ contains=@factorReal,factorComplexErr

"syn region factorColon matchgroup=Keyword start=/\<:\s\+\S\+\>/ matchgroup=Keyword end=/\<;\>/ contains=ALL

syn region factorString start=/"/ skip=/\\"/ end=/"/ oneline
syn region factorComment start=/\<(\>/ end=/\<)\>/

syn region factorCons     matchgroup=Delimiter start=/\<\[\[\>/  matchgroup=Delimiter end=/\<\]\]\>/ contains=ALL
syn region factorVector   matchgroup=Delimiter start=/\<V{\>/ matchgroup=Delimiter end=/\<}\>/ contains=ALL
syn region factorHash     matchgroup=Delimiter start=/\<H{\>/ matchgroup=Delimiter end=/\<}\>/ contains=ALL
syn region factorTuple    matchgroup=Delimiter start=/\<T{\>/ matchgroup=Delimiter end=/\<}\>/ contains=ALL
syn region factorWrapper  matchgroup=Delimiter start=/\<W{\>/ matchgroup=Delimiter end=/\<}\>/ contains=ALL

"adapted from lisp.vim
if exists("g:factor_norainbow") 
    syn region factorQuotation matchgroup=Delimiter start=/\<\[\>/ matchgroup=Delimiter end=/\<\]\>/ contains=ALL
else
    syn region factorQuotation0           matchgroup=hlLevel0 start=/\<\[\>/ end=/\<\]\>/ contains=@factorCluster,factorQuotation1
    syn region factorQuotation1 contained matchgroup=hlLevel1 start=/\<\[\>/ end=/\<\]\>/ contains=@factorCluster,factorQuotation2
    syn region factorQuotation2 contained matchgroup=hlLevel2 start=/\<\[\>/ end=/\<\]\>/ contains=@factorCluster,factorQuotation3
    syn region factorQuotation3 contained matchgroup=hlLevel3 start=/\<\[\>/ end=/\<\]\>/ contains=@factorCluster,factorQuotation4
    syn region factorQuotation4 contained matchgroup=hlLevel4 start=/\<\[\>/ end=/\<\]\>/ contains=@factorCluster,factorQuotation5
    syn region factorQuotation5 contained matchgroup=hlLevel5 start=/\<\[\>/ end=/\<\]\>/ contains=@factorCluster,factorQuotation6
    syn region factorQuotation6 contained matchgroup=hlLevel6 start=/\<\[\>/ end=/\<\]\>/ contains=@factorCluster,factorQuotation7
    syn region factorQuotation7 contained matchgroup=hlLevel7 start=/\<\[\>/ end=/\<\]\>/ contains=@factorCluster,factorQuotation8
    syn region factorQuotation8 contained matchgroup=hlLevel8 start=/\<\[\>/ end=/\<\]\>/ contains=@factorCluster,factorQuotation9
    syn region factorQuotation9 contained matchgroup=hlLevel9 start=/\<\[\>/ end=/\<\]\>/ contains=@factorCluster,factorQuotation0
endif

if exists("g:factor_norainbow") 
    syn region factorArray    matchgroup=Delimiter start=/\<{\>/  matchgroup=Delimiter end=/\<}\>/ contains=ALL
else
    syn region factorArray0           matchgroup=hlLevel0 start=/\<{\>/ end=/\<}\>/ contains=@factorCluster,factorArray1
    syn region factorArray1 contained matchgroup=hlLevel1 start=/\<{\>/ end=/\<}\>/ contains=@factorCluster,factorArray2
    syn region factorArray2 contained matchgroup=hlLevel2 start=/\<{\>/ end=/\<}\>/ contains=@factorCluster,factorArray3
    syn region factorArray3 contained matchgroup=hlLevel3 start=/\<{\>/ end=/\<}\>/ contains=@factorCluster,factorArray4
    syn region factorArray4 contained matchgroup=hlLevel4 start=/\<{\>/ end=/\<}\>/ contains=@factorCluster,factorArray5
    syn region factorArray5 contained matchgroup=hlLevel5 start=/\<{\>/ end=/\<}\>/ contains=@factorCluster,factorArray6
    syn region factorArray6 contained matchgroup=hlLevel6 start=/\<{\>/ end=/\<}\>/ contains=@factorCluster,factorArray7
    syn region factorArray7 contained matchgroup=hlLevel7 start=/\<{\>/ end=/\<}\>/ contains=@factorCluster,factorArray8
    syn region factorArray8 contained matchgroup=hlLevel8 start=/\<{\>/ end=/\<}\>/ contains=@factorCluster,factorArray9
    syn region factorArray9 contained matchgroup=hlLevel9 start=/\<{\>/ end=/\<}\>/ contains=@factorCluster,factorArray0
endif

syn match factorQuotationError /\<\]\>/

syn sync lines=100

if version >= 508 || !exists("did_factor_syn_inits")
    if version <= 508
	let did_factor_syn_inits = 1
	command -nargs=+ HiLink hi link <args>
    else
	command -nargs=+ HiLink hi def link <args>
    endif

    HiLink factorComment	Comment
    HiLink factorTodo		Todo
    HiLink factorInclude	Include
    HiLink factorRepeat		Repeat
    HiLink factorConditional	Conditional
    HiLink factorKeyword	Keyword
    HiLink factorOperator	Operator
    HiLink factorBoolean	Boolean
"    HiLink factorColon		Typedef
    HiLink factorDefn		Function
    HiLink factorDefnEnd	Typedef
    HiLink factorString		String
    HiLink factorQuotationError Error
    HiLink factorInt		Number
    HiLink factorFloat		Float
    HiLink factorRatio		Number
    HiLink factorComplex	Number
    HiLink factorComplexErr	Error

    if &bg == "dark"
	hi   hlLevel0 ctermfg=red         guifg=red1
	hi   hlLevel1 ctermfg=yellow      guifg=orange1
	hi   hlLevel2 ctermfg=green       guifg=yellow1
	hi   hlLevel3 ctermfg=cyan        guifg=greenyellow
	hi   hlLevel4 ctermfg=magenta     guifg=green1
	hi   hlLevel5 ctermfg=red         guifg=springgreen1
	hi   hlLevel6 ctermfg=yellow      guifg=cyan1
	hi   hlLevel7 ctermfg=green       guifg=slateblue1
	hi   hlLevel8 ctermfg=cyan        guifg=magenta1
	hi   hlLevel9 ctermfg=magenta     guifg=purple1
    else
	hi   hlLevel0 ctermfg=red         guifg=red3
	hi   hlLevel1 ctermfg=darkyellow  guifg=orangered3
	hi   hlLevel2 ctermfg=darkgreen   guifg=orange2
	hi   hlLevel3 ctermfg=blue        guifg=yellow3
	hi   hlLevel4 ctermfg=darkmagenta guifg=olivedrab4
	hi   hlLevel5 ctermfg=red         guifg=green4
	hi   hlLevel6 ctermfg=darkyellow  guifg=paleturquoise3
	hi   hlLevel7 ctermfg=darkgreen   guifg=deepskyblue4
	hi   hlLevel8 ctermfg=blue        guifg=darkslateblue
	hi   hlLevel9 ctermfg=darkmagenta guifg=darkviolet
    endif

    delcommand HiLink
endif

let b:current_syntax = "factor"

