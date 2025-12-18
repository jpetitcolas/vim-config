# Neovim Configuration

My personal IDE optimized for Claude Code workflows, code review, and custom shortcuts.

## Installation

```bash
make setup
nvim
```

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

- **Indentation:** 4 spaces
- **Line numbers:** Absolute
- **Clipboard:** System clipboard (`unnamedplus`)
- **Search:** Case-insensitive (smart case when uppercase used)
- **Splits:** Open right and below

## Automatic Behaviors

- Trailing whitespace trimmed on save
- Cursor returns to last position when reopening files
- Press `q` to close help, man pages, quickfix

## Leader Key

The leader key is `Space`. Used for plugin shortcuts (added in later phases).
