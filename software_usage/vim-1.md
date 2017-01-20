


* hjkl: left-up-down-right
* Ctrl + E: scroll window down
* Ctrl + Y: scroll window up
* Ctrl + F: scroll down one page
* Ctrl + B: scroll up one page
* H: move cursor to the top of the window
* M: move cursor to the middle of the window
* L: move cursor to the bottom of the windwo
* gg: go to top of file
* G: got to bottom of file
* w: 下一个单词开头
* e: 下一个单词结尾


text objects

* w: words
* s: sentences
* p: paragraphs
* t: tags

key:



motions

* a: all
* i: in
* t: til
* f: find forward
* F: find backward

combined with commands

* d: delete(also cut)
* c: change(delet, then place in insert mode)
* y: yank(cpoy)
* v: visually select


`{command}{text object or motion}`

ex:

* diw: delete in word
* dw: delete cursor to word end
* caw: change all word
* di[/da[: delete in next [
* yi): copy in next (
* dl_: delete until the space
* df_: delete to the space
* va": visually select all inside doublequotes including dobulequotes


reptetition the dot command

* .: repeate last operations


additional commands

* dd/yy: delete/yank the current line
* D/C: delete/change until end of line
* ^/$: move to the beginning/end of line
* I/A: move to the beginning/end of line and insert
* o/O: insert new line above/below current line and insert
* p/P: paste below/above

macros: a sequence of commadn recorded to a register

record a macro:

* q{register}
* (do the things)
* q

play a macro

* @{register}


plugins

* vundle: plugin manager
* nerdtree: file drawer
* ctrlp: fuzzy file finder
* fugitive: git tool
* syntastic: syntax checker/linter

tmux

* tmux new-session -s {session-name}
* 