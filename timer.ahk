#Requires AutoHotkey v2.0
#SingleInstance Force

; --- SETTINGS ---
Global TotalTime := 300 ; 5 minutes 0 seconds
Global Remaining := 0
Global IsBeeping := false

; Color Constants
Global ColorBlue   := "4169E1" ; Royal Blue
Global ColorYellow := "FFD700" ; Gold/Yellow
Global ColorRed    := "FF0000" ; Red

FormatTime(s) => Format("{1:02}:{2:02}", Floor(s / 60), Mod(s, 60))

; --- TIMER GUI SETUP ---
MyGui := Gui("+AlwaysOnTop -Caption +ToolWindow")
MyGui.BackColor := ColorBlue
MyGui.SetFont("s24 cWhite w700", "Segoe UI")
TimerText := MyGui.Add("Text", "Center w150 y15", FormatTime(TotalTime))

; Left-click and drag anywhere to move it
OnMessage(0x0201, (*) => PostMessage(0xA1, 2,,, "A"))

; --- HOTKEYS ---

~7::
~Numpad7:: {
    StopBeeping()
    SetTimer(FlashLogic, 0)
    if (Remaining = 0)
        Global Remaining := TotalTime
    
    UpdateColors() ; Set initial color state
    MyGui.Show("NoActivate") 
    SetTimer(UpdateTimer, 1000)
}

~9::
~Numpad9:: {
    SetTimer(UpdateTimer, 0)
    SetTimer(FlashLogic, 0)
}

~8::
~Numpad8:: {
    SetTimer(UpdateTimer, 0)
    SetTimer(FlashLogic, 0)
    StopBeeping()
    Global Remaining := TotalTime
    MyGui.BackColor := ColorBlue
    TimerText.Value := FormatTime(TotalTime)
    MyGui.Show("NoActivate")
}

; --- FUNCTIONS ---

UpdateTimer() {
    Global Remaining
    if (Remaining > 0) {
        Remaining--
        UpdateColors()
        TimerText.Value := FormatTime(Remaining)
    } else {
        SetTimer(UpdateTimer, 0)
        SetTimer(FlashLogic, 0)
        MyGui.BackColor := ColorRed ; Solid red when finished
        StartBeeping()
    }
}

UpdateColors() {
    Global Remaining
    if (Remaining > 30) {
        SetTimer(FlashLogic, 0)
        MyGui.BackColor := ColorBlue
    } else if (Remaining <= 30 && Remaining > 10) {
        SetTimer(FlashLogic, 0)
        MyGui.BackColor := ColorYellow
    } else if (Remaining <= 10) {
        if (Remaining > 0)
            SetTimer(FlashLogic, 500) ; Start flashing
    }
}

FlashLogic() {
    MyGui.BackColor := (MyGui.BackColor = ColorRed) ? ColorYellow : ColorRed
}

StartBeeping() {
    Global IsBeeping := true
    ; Set to 200ms for a "continuous" rapid beeping effect
    SetTimer(PlayAlert, 200) 
}

StopBeeping() {
    Global IsBeeping := false
    SetTimer(PlayAlert, 0)
}

PlayAlert() {
    if (IsBeeping)
        SoundPlay("*48")
}