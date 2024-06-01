function GetOS()
    return package.config:sub(1,1) == "\\" and "win" or "unix"
end
-- create copy buffer command
vim.cmd([[
    command! CopyBufferPath :lua CopyBufferPath()
]])
function CopyBufferPath()
    local path = vim.fn.expand('%:p')
    vim.fn.setreg('+', path)
    vim.fn.setreg('"', path)
end
-- set shell to pwsh on windows
if GetOS() == "win" then
    local powershell_options = {
      shell = vim.fn.executable "pwsh" and "pwsh" or "powershell",
      shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
      shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
      shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
      shellquote = "",
      shellxquote = "",
    }

    for option, value in pairs(powershell_options) do
      vim.opt[option] = value
    end
    vim.cmd([[
        let &shell="c:/users/administrator/.dotnet/tools/pwsh.exe"
    ]])
end

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
