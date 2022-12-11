" Fix highlighting of tabbed list items (see $VIMRUNTIME/syntax/markdown.vim)
syn cluster markdownListItem contains=@Spell,@markdownInline,markdownListMarker,markdownOrderedListMarker
syn region markdownCodeBlockFix start="^\n\( \{4,}\|\t\)" end="^\ze \{,3}\S.*$" contains=@markdownListItem keepend

" Add LaTeX highlighting
unlet b:current_syntax
syn include syntax/tex.vim
syn region markdownMath start="\$\$" end="\$\$" contains=@texMathZoneGroup keepend
syn match markdownMath "\$[^$].\{-}\$" contains=@texMathZoneGroup keepend
let b:current_syntax = "markdown"
