# bocker-terminal

A floating terminal plugin for Neovim with two modes: persistent and run.

## Features

- **Persistent terminal** -- survives across toggles, keeps its state
- **Run terminal** -- executes a command and is killed when you leave the window
- Floating window with configurable size and position

## Setup

```lua
require('bocker-terminal').setup()
```

All options have sensible defaults and can be omitted.

## Configuration

```lua
require('bocker-terminal').setup({
    width = 1,        -- float (0-1) for percentage of editor width, integer for columns
    height = 1,       -- float (0-1) for percentage of editor height, integer for lines
    anchor = 'm',     -- 'm' (middle), 't' (top), 'b' (bottom)
    border = 'single', -- border style passed to nvim_open_win
    keymaps = {
        persistent = "<F10>", -- toggle persistent terminal
        run = "<F11>",        -- toggle run terminal
        set_cmd = "<C-F11>",  -- set command for run terminal
    },
})
```

## Usage

| Key       | Action |
|-----------|--------|
| `<F10>`   | Toggle persistent terminal. Buffer is hidden when you leave, not killed. |
| `<F11>`   | Toggle run terminal. Runs the command set via `<C-F11>`. Window is killed when you leave. |
| `<C-F11>` | Prompt for a command to run in the next run terminal toggle. |
