# Neovim Configuration

A minimal yet powerful Neovim configuration using lazy.nvim as the plugin manager, optimized for development workflows.

## Features

- **LSP Support**: Full Language Server Protocol integration for Lua, Python, C/C++, and LaTeX
- **Autocompletion**: Intelligent code completion with nvim-cmp
- **Fuzzy Finding**: Fast file and text search with Telescope
- **Git Integration**: Built-in Git commands via Fugitive
- **Syntax Highlighting**: Advanced parsing with Treesitter
- **Quick Navigation**: Harpoon for rapid file switching
- **Undo History**: Visual undo tree for time-travel editing
- **Modern UI**: Cyberdream colorscheme with icon support

## Requirements

- Neovim >= 0.9.0
- Git
- A Nerd Font (for icons)
- ripgrep (for Telescope grep functionality)
- Node.js (for some LSP servers)

## Installation

1. Backup your existing Neovim configuration:
```bash
mv ~/.config/nvim ~/.config/nvim.backup
```

2. Clone this configuration:
```bash
git clone https://github.com/Spoeperd/nvim.git ~/.config/nvim
```

3. Start Neovim:
```bash
nvim
```

Lazy.nvim will automatically install all plugins on first launch.

## Key Mappings

### Leader Key
- Leader: `<Space>`
- Local Leader: `\`

### General
| Key | Mode | Action |
|-----|------|--------|
| `<leader>pv` | Normal | Open file explorer |
| `J` | Visual | Move selected lines down |
| `K` | Visual | Move selected lines up |
| `<C-d>` | Normal | Scroll down and center |
| `<C-u>` | Normal | Scroll up and center |
| `n` / `N` | Normal | Next/previous search result (centered) |

### Clipboard
| Key | Mode | Action |
|-----|------|--------|
| `<leader>y` | Normal/Visual | Yank to system clipboard |
| `<leader>Y` | Normal | Yank line to system clipboard |
| `<leader>p` | Visual | Paste without overwriting register |
| `<leader>d` | Normal/Visual | Delete to black hole register |

### Utilities
| Key | Mode | Action |
|-----|------|--------|
| `<leader>s` | Normal | Search and replace word under cursor |
| `<leader>x` | Normal | Make current file executable |

### Telescope (Fuzzy Finder)
| Key | Action |
|-----|--------|
| `<leader>pf` | Find files |
| `<C-p>` | Find Git files |
| `<leader>ps` | Grep search with prompt |

### Harpoon (Quick Navigation)
| Key | Action |
|-----|--------|
| `<leader>a` | Add file to Harpoon |
| `<C-e>` | Toggle Harpoon menu |
| `<C-h>` | Navigate to file 1 |
| `<C-t>` | Navigate to file 2 |
| `<C-n>` | Navigate to file 3 |
| `<C-s>` | Navigate to file 4 |
| `<C-S-P>` | Previous Harpoon file |
| `<C-S-N>` | Next Harpoon file |

### LSP
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `gD` | Go to declaration |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>D` | Type definition |
| `<leader>ds` | Document symbols |
| `<leader>ws` | Workspace symbols |

### Completion (Insert Mode)
| Key | Action |
|-----|--------|
| `<C-p>` | Previous suggestion |
| `<C-n>` | Next suggestion |
| `<Tab>` | Confirm selection |
| `<C-Space>` | Trigger completion |

### Git (Fugitive)
| Key | Action |
|-----|--------|
| `<leader>gs` | Git status |

### Other
| Key | Action |
|-----|--------|
| `<leader>u` | Toggle undo tree |
| `<leader>?` | Show which-key help |

## Plugin List

- **lazy.nvim**: Plugin manager
- **cyberdream.nvim**: Colorscheme
- **nvim-lspconfig**: LSP configuration
- **mason.nvim**: LSP/DAP/linter installer
- **nvim-cmp**: Autocompletion engine
- **LuaSnip**: Snippet engine
- **telescope.nvim**: Fuzzy finder
- **nvim-treesitter**: Syntax highlighting
- **harpoon**: File navigation
- **vim-fugitive**: Git integration
- **undotree**: Undo history visualization
- **which-key.nvim**: Keybinding helper
- **mini.nvim**: Utility functions
- **nvim-web-devicons**: File icons

## Configuration Structure

```
~/.config/nvim/
├── init.lua                 # Entry point
├── lazy-lock.json          # Plugin version lock file
└── lua/
    ├── config/
    │   ├── init.lua        # Config loader
    │   ├── lazy.lua        # Lazy.nvim setup
    │   ├── set.lua         # Vim options
    │   └── remap.lua       # General keymaps
    └── plugins/
        ├── autocompletion.lua
        ├── colorscheme.lua
        ├── fugitive.lua
        ├── harpoon.lua
        ├── icons.lua
        ├── lsp.lua
        ├── telescope.lua
        ├── treesitter.lua
        ├── undotree.lua
        └── whichkey.lua
```

## LSP Servers

The following language servers are automatically installed:
- **lua_ls**: Lua
- **pyright**: Python
- **clangd**: C/C++
- **texlab**: LaTeX

## Customization

### Adding More LSP Servers

Edit `lua/plugins/lsp.lua` and add servers to the `ensure_installed` table:

```lua
ensure_installed = {
    "lua_ls",
    "pyright",
    "rust_analyzer",  -- Add new servers here
},
```

Then configure them following the existing pattern.

### Changing Colorscheme

Replace the plugin in `lua/plugins/colorscheme.lua` with your preferred theme.

### Adding Plugins

Create a new file in `lua/plugins/` or add to an existing one:

```lua
return {
    "username/plugin-name",
    config = function()
        -- Plugin configuration
    end,
}
```

## Tips

- Use `:Lazy` to manage plugins (install, update, clean)
- Use `:Mason` to manage LSP servers
- Use `:checkhealth` to diagnose issues
- Undo history is persisted in `~/.vim/undodir`

## Troubleshooting

**LSP not working**: Run `:Mason` and ensure servers are installed

**Icons not showing**: Install a Nerd Font and set it in your terminal

**Treesitter errors**: Run `:TSUpdate` to update parsers

**Plugin issues**: Try `:Lazy sync` to reinstall plugins

## License

This configuration is free to use and modify as you see fit.
