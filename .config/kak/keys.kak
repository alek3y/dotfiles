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
# - <a-[hl]> and <home>, <end> (both without sel)
# - <c-a> (as %)
# - <c-[ud]>
# - , (as ;)
# - <a-,> (as <a-;>)

# Changes:
# - i
# - d (as <a-d>)
# - <a-d> (as d)
# - o, O (as <a-[oO]>)
# - y, p, r (as R)
# - <a-j>
# - >, <
# - u, U
# - ` (as <a-`>)
# - _
# - | (as !) and ! (as <a-|>)

# Searching:
# - /, <a-/>
# - n and <a-n>

# Goto:
# - g, G (all)

# View:
# - v, V (all)

# Marks:
# - Z, z
# - <a-z> (all)

# Macros:
# - Q (or <esc>) and q

# Jump list:
# - <c-[io]>, <c-s>

## Insert mode ##

# TODO: Close pairs automatically
#map global insert { '{}<esc>hi'

# Map '<a-i>' to '<esc>'
map global insert <a-n> <esc>

# Map '<a-d>' to '<del>'
map global insert <a-d> <del>

# Bind movements on insert mode too
map global insert <a-h> <left>
map global insert <a-j> <down>
map global insert <a-k> <up>
map global insert <a-l> <right>
map global insert <a-H> <home>
map global insert <a-L> <end>
map global insert <a-b> '<esc>b;i'
map global insert <a-w> '<esc>e;i'

# Disable '<c-[rvu]>'
map global insert <c-r> ''
map global insert <c-v> ''
map global insert <c-u> ''

# Disable '<a-;>'
map global insert '<a-;>' ''

## Movement ##

# Replace 'w' with 'e' and remove selection on 'w' and 'b'
map global normal w 'e;'
map global normal e ''
map global normal W E
map global normal E ''
map global normal b 'b;'

# Multiline scrolling
map global normal <c-k> '10k'
map global normal <ret> '10j'		# Unfortunately, <c-j> is <ret> for ncurses

# Disable '<a-[wbe]>'
map global normal <a-w> ''
map global normal <a-b> ''
map global normal <a-e> ''

# Disable 'f', 't' and '<a-[ft]>'
map global normal f ''
map global normal t ''
map global normal <a-f> ''
map global normal <a-t> ''
map global normal <a-.> ''

# Disable 'M' and remove selection on 'm'
map global normal M ''
map global normal m 'm;'

# Disable '<a-[mM]>'
map global normal <a-m> ''
map global normal <a-M> ''

# Disable '<a-[xX]>'
map global normal <a-x> ''
map global normal <a-X> ''

# Deselect after moving with '<a-[hl]>'
map global normal <a-h> '<a-h>;'
map global normal <a-l> '<a-l>l'
map global normal <home> '<home>;'
map global normal <end> '<end>l'

# Replace '%' with '<c-a>'
map global normal <c-a> '%'
map global normal '%' ''

# Disable '<c-[bf]>'
map global normal <c-b> ''
map global normal <c-f> ''

# Replace ';' with ','
map global normal ',' ';'
map global normal ';' ''

# Replace '<a-;>' with '<a-,>'
map global normal '<a-,>' '<a-;>'
map global normal '<a-;>' ''

# Disable '<a-:>'
map global normal '<a-:>' ''

## Changes ##

# Disable 'a', 'c' and '.'
map global normal a ''
map global normal c ''
map global normal . ''

# Replace 'o' with '<a-o>' and 'O' with '<a-O>'
map global normal o <a-o>
map global normal O <a-O>
map global normal <a-o> ''
map global normal <a-O> ''

# Swap 'd' and '<a-d>'
map global normal d <a-d>
map global normal <a-d> d

# Disable 'I' and 'A'
map global normal I ''
map global normal A ''

# Replace 'P' with 'p' and disable 'P' and '<a-[pP]>'
map global normal p P
map global normal P ''
map global normal <a-p> ''
map global normal <a-P> ''

# Replace 'R' with 'r' and use register 'r' instead of '"'
map global normal r %{
	: set-register t %reg{/}<ret>
	: set-register u %reg{"}<ret>

	: set-register \" %reg{r}<ret>
	: evaluate-commands %sh{if [ -n "$kak_reg_dquote" ]; then printf "execute-keys R"; else printf "nop"; fi}<ret>

	: set-register \" %reg{u}<ret>
	: set-register / %reg{t}<ret>
}

# Disable 'R', '<a-[rR]>'
map global normal R ''		# Do what 'r' does but delete whole sel and put next entered char
map global normal <a-R> ''
map global normal <a-r> ''

# Disable '<a-J>' and remove selection on '<a-j>'
map global normal <a-j> '<a-j>;'
map global normal <a-J> ''

# Disable '<a-_>', '<a->>' and '<a-<>'
map global normal '<a-_>' ''
map global normal '<a-gt>' ''
map global normal '<a-lt>' ''

# Remove multiple selections on 'u' and 'U'
map global normal u 'u; '
map global normal U 'U; '

# Disable '<a-[uU]>' as pressing '[uU]' multiple times works
map global normal <a-u> ''
map global normal <a-U> ''

# Disable '&' and '<a-&>'
map global normal & ''
map global normal <a-&> ''

# Replace '<a-`>' with '`'
map global normal ` <a-`>

# Disable '~', '<a-`>'
map global normal ~ ''
map global normal <a-`> ''

# Disable '@', '<a-@>'
map global normal @ ''
map global normal <a-@> ''

# Disable '<a-)>' and '<a-(>'
map global normal <a-)> ''
map global normal <a-(> ''

# Replace '!' with '|' and '<a-|>' with '!'
map global normal | !
map global normal ! <a-|>

# Disable '<a-|>' and '<a-!>'
map global normal <a-|> ''
map global normal <a-!> ''

## Searching ##

# Select and search with '<a-/>'
map global normal <a-/> '<a-*>/'

# Disable '?', '<a-?>'
map global normal ? ''
map global normal <a-?> ''

# Disable 'N', '<a-N>'
map global normal N ''
map global normal <a-N> ''

# Disable '*', '<a-*>'
map global normal * ''
map global normal <a-*> ''

## Marks ##

map global normal <a-Z> ''

# TODO: https://github.com/mawww/kakoune/blob/master/doc/pages/keys.asciidoc#multiple-selections
# TODO: Replace ':' with '.' on prompt section (?)
