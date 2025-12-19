# Neovim Configuration

My personal IDE optimized for Claude Code workflows, code review, and custom shortcuts.

## Installation

```bash
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

### Terminal

| Shortcut | Action |
|----------|--------|
| `Esc Esc` | Exit terminal mode |

## Editor Settings

- **Theme:** Rose Pine Moon
- **Status line:** lualine (mode, git branch, file, position)
- **Indentation:** 4 spaces
- **Line numbers:** Absolute
- **Clipboard:** System clipboard
- **Search:** Case-insensitive (smart case when uppercase used)
- **Splits:** Open right and below

## Automatic Behaviors

- Trailing whitespace trimmed on save
- Cursor returns to last position when reopening files
- Press `q` to close help, man pages, quickfix

## Leader Key

The leader key is `Space`.
