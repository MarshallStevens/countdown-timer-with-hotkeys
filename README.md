# Countdown Timer with Hotkeys

A lightweight, always-on-top countdown timer for Windows that you control with global hotkeys from any window. It changes color as time runs low and plays an alert sound when it hits zero.

Windows' built-in Clock app has a timer, but there are no hotkeys for it. You have to click into the app every time. I built this so I can start, pause, and reset a countdown without leaving whatever I'm working in (or playing).

<img width="800" height="450" alt="timer" src="https://github.com/user-attachments/assets/afbf42d5-e2a7-4cf0-a05a-93bd4bac05fe" />


## Features

- **Global hotkeys** that work from any app, including fullscreen games
- **Always on top** with a borderless window that stays out of the taskbar
- **Adjustable length**: 5 minutes by default, easy to change
- **Color warnings** as time runs low, with flashing in the final 10 seconds
- **Alert sound** when the countdown finishes
- **Drag anywhere** with a left-click to reposition
- **Single file**, no install beyond AutoHotkey

## Hotkeys

| Action           | Key                    |
|------------------|------------------------|
| Start / Resume   | `7` or `Numpad 7`      |
| Reset            | `8` or `Numpad 8`      |
| Pause            | `9` or `Numpad 9`      |

- The timer window appears the first time you press Start or Reset.
- Pressing **Start** after the timer finishes restarts the full countdown.

## Color Stages

| Time remaining | Color                       |
|----------------|-----------------------------|
| Over 30s       | 🔵 Royal Blue               |
| 11–30s         | 🟡 Gold                     |
| 1–10s          | 🟡🔴 Flashing gold / red    |
| 0s             | 🔴 Solid red + alert sound  |

## Requirements

- Windows 10/11
- [AutoHotkey v2.0](https://www.autohotkey.com/)

## Usage

1. Install AutoHotkey v2.
2. Download `timer.ahk`.
3. Double-click it to run. A green **H** icon appears in your system tray.
4. Press `7` to start the countdown (5 minutes by default; see [Countdown length](#countdown-length) to change it).

To exit, right-click the tray icon and choose **Exit**.

**Run on startup (optional):** press `Win + R`, type `shell:startup`, and put a shortcut to `timer.ahk` in that folder.

## Customization

### Countdown length

The timer counts down from **5 minutes** by default. To change it, edit `TotalTime` at the top of the script. The value is in **seconds**:

```autohotkey
Global TotalTime := 300 ; 5 minutes (in seconds)
```

To get the number you need, multiply the minutes by 60 and add any extra seconds:

| Countdown     | Value  |
|---------------|--------|
| 30 seconds    | `30`   |
| 1 minute      | `60`   |
| 1 min 30 sec  | `90`   |
| 2 min 48 sec  | `168`  |
| 10 minutes    | `600`  |
| 15 minutes    | `900`  |
| 1 hour        | `3600` |

After editing, save the file and double-click it again to reload.

### Changing hotkeys

Each hotkey is defined in the `HOTKEYS` section. To change one, replace the key name before the `::`.

For example, to make **F7** start the timer instead of `7`:

```autohotkey
; Before
~7::
~Numpad7:: {

; After
~F7::
~Numpad7:: {
```

- Each action has two keys stacked on top of each other. You can change either one, delete one, or add more lines to bind extra keys.
- Use any [AutoHotkey key name](https://www.autohotkey.com/docs/v2/KeyList.htm), such as `F7`, `Insert`, or `Pause`.
- Add modifiers for key combos: `^` Ctrl, `!` Alt, `+` Shift, `#` Win (e.g. `~^!t::` = Ctrl+Alt+T).
- Keep the `~` prefix so the key still works normally in other apps. Remove it to block the key from other apps while the script is running.

After editing, save the file and double-click it again to reload.

### Colors and warning thresholds

- **Colors:** edit the hex values for `ColorBlue`, `ColorYellow`, and `ColorRed`.
- **Thresholds:** change the `30` and `10` values in `UpdateColors()`.
- **Flash speed:** change `500` (milliseconds) in `SetTimer(FlashLogic, 500)`.

### Alert sound

The alert uses the Windows "Exclamation" system sound (`*48`). To change it, edit `PlayAlert()` and swap `*48` for `*16` (Hand), `*32` (Question), `*64` (Asterisk), or a file path like `"C:\sounds\alarm.wav"`.

## Known Behavior

Hotkeys use AutoHotkey's `~` prefix, so the key press still goes through to the active window. That means typing `7`, `8`, or `9` anywhere (in a chat box, for example) also triggers the timer. This is intentional, so the keys keep working normally in games, but keep it in mind.

## License

[MIT](LICENSE)
