if exists('g:did_plugin_intero') && g:did_plugin_intero
    finish
endif
let g:did_plugin_intero = 1

if !exists('g:intero_use_neomake')
    let g:intero_use_neomake = 1
endif

" Starts the Intero process in the background.
command! -nargs=0 -bang InteroStart call intero#process#start()
" Kills the Intero process.
command! -nargs=0 -bang InteroKill call intero#process#kill()
" Opens the Intero buffer.
command! -nargs=0 -bang InteroOpen call intero#process#open()
" Hides the Intero buffer.
command! -nargs=0 -bang InteroHide call intero#process#hide()
" Loads the current module in Intero.
command! -nargs=0 -bang InteroLoadCurrentModule call intero#repl#load_current_module()
" Loads the current file in Intero.
command! -nargs=0 -bang InteroLoadCurrentFile call intero#repl#load_current_file()
" Prompts user for a string to eval
command! -nargs=0 -bang InteroEval call intero#repl#eval()
" Gets the specific type at the current point
command! -nargs=0 -bang InteroType call intero#repl#type(0)
" Gets the type at the current point
command! -nargs=0 -bang InteroGenericType call intero#repl#type(1)
" Gets info for the identifier at the current point
command! -nargs=0 -bang InteroInfo call intero#repl#info()
" Go to definition of item under cursor
command! -nargs=0 -bang InteroGoToDef call intero#loc#go_to_def()
" Insert type of thing below cursor
command! -nargs=0 -bang InteroTypeInsert call intero#repl#insert_type()
" Reload
command! -nargs=0 -bang InteroReload call intero#repl#reload()
" Highlight uses of the identifier under cursor
command! -nargs=0 -bang InteroUses call intero#repl#uses() | set hlsearch
" Kill and restart the Intero process
command! -nargs=0 -bang InteroRestart call intero#process#restart()
" Set the load targets for Intero.
command! -nargs=* -bang InteroSetTargets call intero#process#restart_with_targets(<f-args>)
" Reload Intero with all targets disabled.
command! -nargs=0 -bang InteroClearTargets call intero#targets#clear_load_targets()
" Set Intero to use all targets given by stack ide targets
command! -nargs=0 -bang InteroUseAllTargets call intero#targets#enable_all_targets()

if g:intero_use_neomake
    " Neomake integration
    let g:neomake_intero_maker = {
            \ 'exe': 'cat',
            \ 'args': [intero#maker#get_log_file()],
            \ 'errorformat':
                \ '%-G%\s%#,' .
                \ '%f:%l:%c:%trror: %m,' .
                \ '%f:%l:%c:%tarning: %m,'.
                \ '%f:%l:%c: %trror: %m,' .
                \ '%f:%l:%c: %tarning: %m,' .
                \ '%E%f:%l:%c:%m,' .
                \ '%E%f:%l:%c:,' .
                \ '%Z%m'
        \ }
endif

" Store the path to the plugin directory, so we can lazily load the Python module
let g:intero_plugin_root = expand('<sfile>:p:h:h')

" vim: set ts=4 sw=4 et fdm=marker:
