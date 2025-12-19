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
| `Esc Esc` | Exit terminal mode |

## Editor Settings

- **Theme:** Rose Pine Moon
- **Status line:** lualine (mode, git branch, file, position)
- **Buffer line:** Tab bar for open files
- **File explorer:** neo-tree sidebar
- **Fuzzy finder:** telescope (files, grep, buffers)
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
