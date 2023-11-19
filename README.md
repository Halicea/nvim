# Neovim config
## Update (Nov 2023)
After a pleasing 2023 with my previous lua config, a new change, everyone is using Lazy.nvim now, 
Packer is not maintained, so I need to switch again.

Lazy seems much simpler, reliable and more in control over the setup flow.

Once in a year, is totally ok.

I am looking forward this year to see a fast LSP support for .Net as well. 

Happy new year.

## Previous version(Nov 2022).
After a long time resisting to re-write my config in `Lua`, before the end of
this(2022) year, decided to do so.

Not yet fully done, but almost there. Happy new year.

## Structure

### `keybindigs.lua`

To me, it is important to have the bindings organized in a logical fashion,
but also for them to be condensed into a single document.

So there is a single file that defines all the keybindings that are used.
using this setup is also good for spotting duplicates.

### `plugins.lua`

provides a packer invocation where all plugins and their configurations
are being used.

I try not to add too much configuration so one file is sufficient.

Optionally before this function runs, there is `ensure_packer.lua`
that installs packer if its missing.

### `theme.lua`

sets the theme and some look and feel settings related to it, if it cannot find the theme then it should not crash
