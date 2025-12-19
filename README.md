# Neovim Configuration

My personal IDE optimized for Claude Code workflows, code review, and custom shortcuts.

## Installation

```bash
sudo apt install ripgrep  # Required for grep search
make setup
nvim
```

### Windows Terminal (WSL)

After installation, configure the font in Windows Terminal:

1. Open Windows Terminal Settings (`Ctrl+,`)
2. Select your Ubuntu/WSL profile
3. Go to **Appearance**
4. Set **Font face** to `JetBrainsMono Nerd Font`
5. Save and restart terminal

## Keybindings

### General

| Shortcut | Action |
|----------|--------|
| `Ctrl+S` | Save file |
| `Esc` | Clear search highlight |
| `Alt+E` | Toggle file explorer |
| `Alt+F` | Find files |
| `Alt+G` | Grep in files |
| `Alt+B` | Find buffers |

### Moving Lines

| Shortcut | Action |
|----------|--------|
| `Alt+Up` | Move line/selection up |
| `Alt+Down` | Move line/selection down |

### Window Navigation

| Shortcut | Action |
|----------|--------|
| `Ctrl+Left` | Go to left window |
| `Ctrl+Right` | Go to right window |
| `Ctrl+Up` | Go to upper window |
| `Ctrl+Down` | Go to lower window |

### Window Resizing

| Shortcut | Action |
|----------|--------|
| `Ctrl+Alt+Up` | Increase height |
| `Ctrl+Alt+Down` | Decrease height |
| `Ctrl+Alt+Left` | Decrease width |
| `Ctrl+Alt+Right` | Increase width |

### Buffers (Tabs)

| Shortcut | Action |
|----------|--------|
| `Alt+]` | Next buffer |
| `Alt+[` | Previous buffer |
| `Alt+1` to `Alt+5` | Jump to buffer by number |
| `Alt+W` | Close buffer |

### Terminal

| Shortcut | Action |
|----------|--------|
| `Esc Esc` | Exit terminal mode (to normal mode) |
| `Enter` or `i` | Re-enter terminal mode |
| `Alt+C` | Toggle Claude terminal |

### Git Hunks

| Shortcut | Action |
|----------|--------|
| `]c` | Next hunk |
| `[c` | Previous hunk |
| `<leader>da` | Stage hunk |
| `<leader>dA` | Stage buffer |
| `<leader>du` | Unstage hunk |
| `<leader>dr` | Reset hunk |
| `<leader>dR` | Reset buffer |
| `<leader>dp` | Preview hunk |
| `<leader>db` | Blame line |

### LSP (TypeScript/ESLint)

| Shortcut | Action |
|----------|--------|
| `gd` | Go to definition |
| `K` | Hover documentation |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<leader>ca` | Code actions |
| `<leader>rename` | Rename symbol |

### Diff View (Code Review)

| Shortcut | Action |
|----------|--------|
| `Alt+D` | Toggle diff view (against origin/main) |
| `Alt+E` | Toggle file panel (in diff view) |

### Review Notes

| Shortcut | Action |
|----------|--------|
| `<leader>rn` | Add review note at cursor |
| `<leader>rc` | Send review notes to Claude |
| `<leader>ac` | Ask Claude (add note + send immediately) |
| `<leader>ro` | Open review notes file |

## Code Review Workflow

1. **Open diff view:** `Alt+D` to see changes against main branch
2. **Navigate files:** `Alt+E` to toggle the file panel
3. **Add notes:** Position cursor, press `<leader>rn`, type your note
4. **Send to Claude:** `<leader>rc` sends all notes to Claude terminal
5. **Ask Claude:** `<leader>ac` adds note and sends immediately
6. **Interact:** Claude responds, you can type follow-ups directly
7. **Toggle Claude:** `Alt+C` to show/hide Claude terminal
8. **Repeat:** Review more code, add more notes, iterate

Notes are stored per-project at `~/.claude/<project-name>/review-notes.md`

## Editor Settings

- **Theme:** Rose Pine Moon
- **Status line:** lualine (mode, git branch, file, position)
- **Buffer line:** Tab bar for open files
- **File explorer:** neo-tree sidebar
- **Fuzzy finder:** telescope (files, grep, buffers)
- **LSP:** TypeScript and ESLint (uses project-local tools from node_modules)
- **Diagnostics:** Signs in gutter (no virtual text)
- **Git signs:** +/~/- indicators in gutter
- **Indent guides:** Vertical lines at each indentation level
- **Indentation:** 4 spaces
- **Line numbers:** Absolute
- **Clipboard:** System clipboard
- **Search:** Case-insensitive (smart case when uppercase used)
- **Splits:** Open right and below

## Automatic Behaviors

- Session restored when reopening nvim in same directory
- Trailing whitespace trimmed on save
- Cursor returns to last position when reopening files
- Press `q` to close help, man pages, quickfix

## Leader Key

The leader key is `Space`.
