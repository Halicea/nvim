vim.cmd([[
function s:get_visual_selection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return lines
endfunction

" send line by line to tmux pane using send-keys
function! VimuxSendLines(lines)
    for line in a:lines
        call VimuxSendText(line)
        call VimuxSendKeys('Enter')
    endfor
endfunction
command! REPLSendLines call VimuxSendLines(s:get_visual_selection())

function! VimuxSendCtrlKey(key)
    call VimuxSendKeys("C-" . a:key)

endfunction

" center text in buffer
function! s:center(lines) abort
  let longest_line   = max(map(copy(a:lines), 'strwidth(v:val)'))
  let centered_lines = map(copy(a:lines),
        \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
  return centered_lines
endfunction
]])
