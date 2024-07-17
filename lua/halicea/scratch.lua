local Split = require("nui.split")
local event = require("nui.utils.autocmd").event

Scratch = nil
ScratchActive = false

vim.cmd([[ command! ShowScratch :lua ShowScratch() ]])
function ShowScratch()
	if Scratch == nil then
		Scratch = Split({
			relative = "editor",
			position = "bottom",
			border = {
				style = "single",
			},
			size = "20%",
		})
		Scratch:mount()
	end
	Scratch:show()
	ScratchActive = true
	Scratch:on(event.WinClosed, function()
		ScratchActive = false
	end)
end
vim.cmd([[ command! HideScratch :lua HideScratch() ]])
function HideScratch()
	Scratch:hide()
	ScratchActive = false
end

vim.cmd([[ command! ToggleScratch :lua ToggleScratch() ]])
function ToggleScratch()
	if not ScratchActive then
		ShowScratch()
	else
		HideScratch()
	end
end
