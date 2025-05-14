" General vimrc settings to make vim into a decent lightweight code editor
" Note that you can use ':so %' to re-source your vimrc while editing it
set nocompatible	" turn off backwards compatibility with vi

" You can grab a big colorscheme pack from: https://github.com/flazz/vim-colorschemes
" The colorschemes in question can also be previed visually at: https://vimcolorschemes.com/flazz/vim-colorschemes
" To install colorschemes, simply copy all the .vim files into your ~/.vim
" directory (make if needed)
colorscheme darkblue

" Code Editing Settings
" - Note that if you place this block AFTER any spacing/coloring settigns you will get odd/inconsistent results
" - Turning the filetype handling on applies a bunch of type-specific color/spacing settings
syntax on			" Enable syntax highlighting
filetype on			" Enable filetype checking
filetype plugin on	" Enable filetype-specific plugin usage
filetype indent on	" Enable filetype-specific indentation

" Tab settings
" - Note that you might want to remove or change these depending on how they interact with the filetype settings above
" - Moving them above the filetype block should cause them be the defaults, unless they are overridden by particular filetype settings
set ts=4
set autoindent
set smartindent
set shiftwidth=4
set softtabstop=4

" General editor settings
set nu				" File numbering
set nowrap			" disable wrapping by default
set hlsearch		" highlight words as you search for them
set incsearch		" enable incremental search highlighting
set guioptions+=b	" Add horizontal scroll bar
set backspace=2		" allow backspacing over whitespace

" Maximum text/comment width settings.
set textwidth=80	" Maximum line width (if automatic linebreaking is enabled)
set formatoptions-=t	" do not automatically linebreak at textwidth
set formatoptions-=c	" do not automatically linebreak COMMENTS at textwidth, because that's different for some reason
set colorcolumn=80	" Add colored column to indicate maximum linewidth
" Color column settings. Uncomment these and use :help colorcolumn to choose a good color if you don't like the default in your colorscheme
highlight ColorColumn guibg=darkblue
highlight ColorColumn ctermbg=darkblue


" === BEGIN NetRW File Browser Settings ===
" NetRW is the build-in file browser in vim
" It can be set up to work similarly to the file explorer sidebar in most IDEs (i.e. VSCode), but it has some quirks out of the box
" Many users prefer to use the NERDTree plugin, but it's a a bit overkill for what most people really need

" General netrw file browser settings
let g:netrw_liststyle = 3		" Tree-style file list
let g:netrw_browse_split = 3	" Where to open new files. 1: new horizontal split. 2: new vertical split. 3: new tab. 4: previous window (where you opened netrw from)
let g:netrw_altv = 1			" opens netrw on the left instead of the right when using a vertical split
let g:netrw_winsize = 15		" Window size in % of screen
let g:netrw_keepdir = 0			" Keep current directory and browsing directory synced

" Fix Lexplore toggling issues
" This will fix some issues with extra buffers piling up while using netrw
let g:NetrwIsOpen=0
function! ToggleNetrw()
	" By default Lexplore/Vexplore leave a bunch of empty buffers behind
	" Clear these out when we toggle netrw off
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i 
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
		" silent Lexplore " Use Lexplore here if you have a remotely modern version of vim/netrw. This should let you toggle the file explorer on and off in different tabs
        silent Vexplore " Use Vexplore here if you have an older version of vim/netrw. This will mean you can only have the file explorer open in one tab, and you'll have to double toggle it if it's already open in another tab
    endif
endfunction

" Macro for opening Netrw
noremap <silent> <C-E> :call ToggleNetrw()<CR>
" === END NetRW File Browser Settings


