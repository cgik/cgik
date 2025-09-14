syntax enable

if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

try
  colorscheme morning
catch
endtry

set number
set paste

set tabstop=2
set shiftwidth=2

set expandtab
set smarttab

set lb
set tw=500

set ai
set si
set wrap
