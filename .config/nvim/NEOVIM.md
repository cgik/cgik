# Neovim Quick Reference

Leader is the space bar.

## Finding files (fzf-lua)

| Key       | Action                                     |
| --------- | ------------------------------------------ |
| `Space f` | Find a file by name                        |
| `Space g` | Search text across the project (live grep) |
| `Space b` | Switch between open buffers                |
| `Ctrl-^`  | Flip to the previous file                  |

Inside the picker: type to filter, `Ctrl-j` / `Ctrl-k` (or arrows) to move, `Enter` to open, `Esc` to cancel.

## Code navigation (LSP)

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `grr` | List references |
| `gri` | Go to implementation |
| `gO` | Symbols in this file |
| `K` | Hover documentation |
| `Ctrl-o` / `Ctrl-i` | Jump back / forward |

## Editing (LSP)

| Key | Action |
|---|---|
| `grn` | Rename symbol |
| `gra` | Code action |
| `Ctrl-s` (insert mode) | Signature help |
| `Ctrl-n` / `Ctrl-p` | Next / previous completion item |
| `Ctrl-y` | Accept completion |
| `Ctrl-e` | Dismiss completion |

## Diagnostics

| Key | Action |
|---|---|
| `]d` / `[d` | Next / previous diagnostic |
| `Ctrl-w d` | Show the full diagnostic in a float |

## Moving within a file

| Key | Action |
|---|---|
| `/text` then `n` / `N` | Search, then next / previous match |
| `*` | Search for the word under the cursor |
| `{` / `}` | Previous / next blank-line-separated block |
| `%` | Jump to the matching bracket |
| `mA`, then `'A` | Set a global mark, then jump back to it from any file |

## Maintenance

| Command | Action |
|---|---|
| `:checkhealth vim.lsp` | Show attached servers and problems |
| `:lua vim.pack.update()` | Review and apply plugin updates |
| `:help lsp-defaults` | The built-in LSP keymaps for your version |
