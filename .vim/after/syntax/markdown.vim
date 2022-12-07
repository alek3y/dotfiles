" Fix highlighting of tabbed list items (see $VIMRUNTIME/syntax/markdown.vim)
syn cluster markdownListItem contains=@Spell,@markdownInline,markdownListMarker,markdownOrderedListMarker
syn region markdownCodeBlockFix start="^\n\( \{4,}\|\t\)" end="^\ze \{,3}\S.*$" contains=@markdownListItem keepend
