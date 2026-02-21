# Claude Sounds Toggle

A one-click macOS desktop app to pause and resume sound hooks in [Claude Code](https://claude.ai/claude-code).

![icon](icon.png)

## What it does

Claude Code supports hooks that play sounds on events like session start, notifications, and session end. This app lets you toggle those sounds on/off instantly from your Desktop or Dock — no terminal needed.

Each click shows a self-dismissing alert:
- `🔇 Claude Sounds paused` — sounds are silenced
- `🔊 Claude Sounds resumed` — sounds are back on

## How it works

The app creates or removes a flag file at `~/.claude/sounds-paused`. The Claude Code hooks check for this file before playing any audio.

## Setup

### 1. Configure Claude Code hooks

Add the following to `~/.claude/settings.json`, updating paths to match your sounds directory:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "startup",
        "hooks": [
          {
            "type": "command",
            "command": "[ -f ~/.claude/sounds-paused ] || afplay /path/to/sounds/session-start.mp3 &"
          }
        ]
      }
    ],
    "SessionEnd": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "[ -f ~/.claude/sounds-paused ] || afplay /path/to/sounds/session-end.mp3 &"
          }
        ]
      }
    ],
    "Notification": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "[ -f ~/.claude/sounds-paused ] || afplay /path/to/sounds/notification.mp3 &"
          }
        ]
      }
    ]
  }
}
```

### 2. Build the app

Open Terminal and run:

```bash
osacompile -o ~/Desktop/ClaudeSounds.app ClaudeSounds.applescript
```

This creates `ClaudeSounds.app` on your Desktop. You can drag it into your Dock for quick access.

### 3. Set a custom icon (optional)

Run the following in Terminal, pointing to your preferred PNG:

```bash
python3 -c "
import subprocess, os
app_path = os.path.expanduser('~/Desktop/ClaudeSounds.app')
img_path = '/path/to/icon.png'
subprocess.run(['osascript', '-l', 'JavaScript', '-e', f'''
ObjC.import(\"AppKit\");
var img = \$.NSImage.alloc.initWithContentsOfFile(\"{img_path}\");
\$.NSWorkspace.sharedWorkspace.setIconForFileOptions(img, \"{app_path}\", 0);
'''])
"
```

## Requirements

- macOS
- Claude Code with hook support
- Sound files in a directory of your choice (`.mp3` or `.aiff`)
