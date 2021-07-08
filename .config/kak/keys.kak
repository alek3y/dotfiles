##
# Key mappings
#

# Insert mode:
# - <a-i> or <esc>
# - <backspace>, <del> (or <a-d>)
# - <left>, <right>, <up>, <down>
# - <home>, <end>
# - <a-[hjkl]>, <a-[HL]> and <a-[bw]> (for movement)
# - <c-o>, <c-n> and <c-p>
# - <c-x>

# Movement:
# - h, j, k, l
# - <c-[jk]> (multiline scrolling)
# - w (as e), b (both without sel)
# - m (without sel)
# - x, X
# - <a-h>, <home> (both as gi)
# - <a-l>, <end> (both without sel)
# - <a-[HL]> (with sel)
# - a (as %)
# - <c-[ud]>
# - , (as ;)
# - <a-,> (as <a-;>)

# Changes:
# - i
# - d (as <a-d>)
# - <a-d> (as d)
# - o, O (as <a-[oO]>)
# - y, p
# - Y, P (with `xclip`)
# - r, R
# - >, <
# - t
# - u, U
# - ` (as <a-`>)
# - _
# - | (as !) and ! (as <a-|>)

# Searching:
# - /, <a-/>, *, r
# - n and <a-n>

# Goto:
# - g, G (all)

# View:
# - v, V (all)

# Marks:
# - z (as Z), <a-Z> (as z)
# - <a-z> (all)

# Macros:
# - Q (or <esc>) and q

# Jump list:
# - <c-[io]>, <c-s>

# Multiple selections:
# - <space>

## Insert mode ##

map global insert <a-n> <esc>
map global insert <a-d> <del>

# Bind some movements on insert mode too
map global insert <a-h> <left>
map global insert <a-j> <down>
map global insert <a-k> <up>
map global insert <a-l> <right>
map global insert <a-H> '<esc>gii'
map global insert <a-L> <end>
map global insert <a-b> '<esc>b;i'
map global insert <a-w> '<esc>e;i'

map global insert <c-r> ''
map global insert <c-v> ''
map global insert <c-u> ''
map global insert '<a-;>' ''

## Movement ##

map global normal w 'e;'		# Move through words and deselect
map global normal b 'b;'		# ...
map global normal W E		# Select word without following whitespaces
map global normal e ''
map global normal E ''
map global normal <c-k> '10k'		# Multiline scrolling
map global normal <ret> '10j'		# ... Unfortunately, '<c-j>' is '<ret>' for ncurses
map global normal <a-w> ''
map global normal <a-b> ''
map global normal <a-e> ''
map global normal f ''
map global normal t ''
map global normal <a-f> ''
map global normal <a-t> ''
map global normal <a-.> ''
map global normal M ''
map global normal m 'm;'		# Deselect after moving to matching delimeters
map global normal <a-m> ''
map global normal <a-M> ''
map global normal <a-x> ''
map global normal <a-X> ''
map global normal <a-h> 'gi'		# Move to non blank start
map global normal <home> 'gi'		# ...
map global normal <a-l> '<a-l>l'		# ...
map global normal <end> '<end>l'		# ...
map global normal <a-H> 'Gi'		# Select to non blank start
map global normal a '%'		# Select everything with 'a' (as '%')
map global normal '%' ''
map global normal <c-b> ''
map global normal <c-f> ''
map global normal ',' ';'		# Deselect with ',' (as ';')
map global normal ';' ''
map global normal '<a-,>' '<a-;>'		# Flip selection direction with '<a-,>' (as '<a-;>')
map global normal '<a-;>' ''
map global normal '<a-:>' ''

## Changes ##

map global normal . ''
map global normal o <a-o>		# Add an empty line but do not enter insert mode
map global normal O <a-O>		# ...
map global normal <a-o> ''
map global normal <a-O> ''
map global normal d <a-d>		# Delete with 'd' (as '<a-d>')
map global normal <a-d> d		# Yank and delete with '<a-d>' (as 'd')
map global normal I ''
map global normal A ''
map global normal p P		# Paste before selection using 'p' (as 'P')

# Paste with `xclip`
map global normal P %{
! xclip -sel c -o<ret>
}

# Copy with `xclip`
map global normal Y %{
<a-|> xclip -sel c<ret>
: echo "yanked to system clipboard"
}

map global normal <a-p> ''
map global normal <a-P> ''

# Replace next (from replace command) with 'r' but use register 'r' instead of '"'
map global normal r %{
: set-register t "%reg{/}"<ret>
: set-register u "%reg{dquote}"<ret>

: set-register dquote "%reg{r}"<ret>
: evaluate-commands %sh{if [ -n "$kak_reg_dquote" ]; then printf "execute-keys R"; else printf "nop"; fi}<ret>

: set-register dquote "%reg{u}"<ret>
: set-register / "%reg{t}"<ret>
}

map global normal R r
map global normal <a-R> ''
map global normal <a-r> ''

# Indent *empty line* with the previous one
map global normal t %{
i<backspace><ret><esc>
}

map global normal <a-j> ''
map global normal <a-J> ''
map global normal '<a-_>' ''
map global normal '<a-gt>' ''
map global normal '<a-lt>' ''
map global normal u 'u; '		# Undo and remove selection
map global normal U 'U; '		# ...
map global normal <a-u> ''
map global normal <a-U> ''
map global normal & ''
map global normal <a-&> ''
map global normal ` <a-`>		# Swap case with '`' (as '<a-`>')
map global normal ~ ''
map global normal <a-`> ''
map global normal @ ''
map global normal <a-@> ''
map global normal <a-)> ''
map global normal <a-(> ''
map global normal | !
map global normal ! <a-|>
map global normal <a-|> ''
map global normal <a-!> ''

## Searching ##

map global normal <a-/> '/(?i)'		# Case insensitive search
map global normal ? ''
map global normal <a-?> ''
map global normal N ''
map global normal <a-N> ''
map global normal * '<a-*>/<up>'		# Search current selection
map global normal <a-*> ''

## View ##
map global normal c 'vc'

## Marks ##

map global normal z Z
map global normal <a-z> z
map global normal Z ''
map global normal <a-Z> ''

## Multiple selections ##

map global normal s ''
map global normal S ''
map global normal <a-s> ''
map global normal <a-S> ''
map global normal C ''
map global normal <a-C> ''
map global normal <a-space> ''
map global normal <a-k> ''
map global normal <a-K> ''
map global normal $ ''
map global normal ) ''
map global normal ( ''

# TODO: https://github.com/mawww/kakoune/blob/master/doc/pages/keys.asciidoc#object-selection
map global normal . :
map global normal : ''
