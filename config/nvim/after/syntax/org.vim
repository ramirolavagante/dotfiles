" Extra Org highlighting on top of Neovim's built-in org syntax.

" Make list markers visible across colorschemes.
highlight default link orgUnorderedListMarker Special
highlight default link orgOrderedListMarker Special

" Property drawer boundaries and property lines.
syntax match orgPropertyDrawer /^\s*:PROPERTIES:\s*$/
syntax match orgPropertyDrawer /^\s*:END:\s*$/
syntax match orgPropertyLine /^\s*:[A-Za-z0-9_@#%-][A-Za-z0-9_@#%_-]*:\s\+.*$/

" Active and inactive timestamps.
syntax match orgTimestampActive /<\d\{4}-\d\{2}-\d\{2}\s\+[A-Za-z]\{3}\%(\s\+\d\{1,2}:\d\{2}\)\?>/
syntax match orgTimestampInactive /\[\d\{4}-\d\{2}-\d\{2}\s\+[A-Za-z]\{3}\%(\s\+\d\{1,2}:\d\{2}\)\?\]/

highlight default link orgPropertyDrawer PreProc
highlight default link orgPropertyLine Identifier
highlight default link orgTimestampActive Constant
highlight default link orgTimestampInactive Comment
