#Requires AutoHotkey >=2.0

f5::reload

; list of key codes: https://kbdlayout.info/kbdusx/virtualkeys

#hotif !modifierpressed()

ihCapsLock := InputHook("I")
ihCapsLock.KeyOpt("{All}", "+N") ; Enable notification for all keys
ihCapsLock.OnKeyDown := onkeydownCapsLock
SC03A::{ ; listen for caps lock key
    global pressedCL := A_TickCount
    ihCapsLock.Start()
    KeyWait(A_ThisHotkey)
}
SC03A Up::{
    ihCapsLock.Stop()
    if (ihCapsLock.Input = "" and A_TickCount - pressedCL < 120)
        Send("{SC03A}")
}
onkeydownCapsLock(ihCapsLock, vk, sc) {
    Switch sc {
        Case "36": sendkeywithmodifiers("left")
        Case "37": sendkeywithmodifiers("down")
        Case "38": sendkeywithmodifiers("right")
        Case "23": sendkeywithmodifiers("up")
        Case "35": sendkeywithmodifiers("home")
        Case "24": sendkeywithmodifiers("end")
        Case "14": sendkeywithmodifiers("delete")
    }
}

ihDot := InputHook("I")
ihDot.KeyOpt("{All}", "+N") ; Enable notification for all keys
ihDot.OnKeyDown := onkeydownDot
SC034::{ ; listen for period key "."
    global pressedDot := A_TickCount
    ihDot.Start()
    KeyWait(A_ThisHotkey)
}
SC034 Up::{
    ihDot.Stop()
    if (ihDot.Input = "" and A_TickCount - pressedDot < 120)
        Send("{SC034}")
}
onkeydownDot(ihDot, vk, sc) {
    Switch sc {
      Case "20": tryActivate("WindowsTerminal.exe")  ; 'T' key
      Case "32": tryActivate("phpstorm64.exe")       ; 'D' key
      Case "34": tryActivate("goland64.exe")         ; 'G' key
      Case "31": tryActivate("slack.exe")            ; 'S' key
      Case "46": tryActivate("chrome.exe")           ; 'C' key
      Case "18": tryActivate("msedge.exe")           ; 'E' key
      Case "47": tryActivate("code.exe")             ; 'V' key
      Case "44": tryActivate("Zoom.exe")             ; 'Z' key
      Case "33": tryActivate("s CabinetWClass ahk_exe explorer.exe")  ; 'F' key
      Case "48": Send("^b")                          ; 'B' key
      Case "30": Send("^+a")                         ; 'A' key
      Case "31": Send("^+n")                         ; 'n' key

  }
}


ihX := InputHook("I")
ihX.KeyOpt("{All}", "+N") ; Enable notification for all keys
ihX.OnKeyDown := onkeydownX
SC02D::{ ; listen for period key "."
    global pressedX := A_TickCount
    global InChrome := false
    global InWindowsTerminal := false
    ihX.Start()
    if (winactive("ahk_exe chrome.exe")) {
      InChrome := true
    }
    if (winactive("ahk_exe windowsTerminal.exe")) {
      InWindowsTerminal := true
    }
    KeyWait(A_ThisHotkey)
}
SC02D Up::{
    ihX.Stop()
    if (ihX.Input = "" and A_TickCount - pressedX < 200) {
        Send("{SC02D}")
    }
    else if (!InChrome and !InWindowsTerminal) {
    Send("{SC02D}")
    }
}
onkeydownX(ihX, vk, sc) {
  if (InChrome) {
    Switch sc {
      Case "35": checkdevtools("off") ; 'h' key
      Case "38": checkdevtools("on")  ; 'l' key
    }
  }
  else if (InWindowsTerminal) {
    ; msgbox(sc)
    Switch sc {
      Case "49": Send("^+t")    ; 'N' key for  'ctrl + shift + t' for new tab in WindowsTerminal
      Case "14": Send("^+w")    ; 'Backspace' key for 'ctrl + shift + w' for close tab in WindowsTerminal
      Case "43": Send("!+d")      ; 'backslash' key for 'alt + shift + d' for split pane in WindowsTerminal
      
      ; movements between panes
      Case "38": Send("!{Right}")   ; 'l' key for 'alt + right' for moving to right pane in WindowsTerminal
      Case "35": Send("!{Left}")    ; 'h' key for 'alt + left' for moving to left pane in WindowsTerminal
      Case "37": Send("!{Up}")      ; 'k' key for 'alt + up' for moving to up pane in WindowsTerminal
      Case "36": Send("!{Down}")    ; 'j' key for 'alt + down' for moving to down pane in WindowsTerminal

      ; movements between tabs
      Case "24": Send("^{Tab}")     ; 't' key for 'ctrl + tab' for moving to next tab in WindowsTerminal
      Case "23": Send("^+{Tab}")    ; 'T' key for 'ctrl + shift + tab' for moving to previous tab in Windows
    }
  }
}

$escape::{
    errorlevel := !keywait("escape", "t0.5")
    if (errorlevel) {
        soundbeep 440, 100
        errorlevel := !keywait("escape")
        postmessage(0x112, 0xf060, , , "a")
    } else {
        sendinput("{escape}")
    }
    return
}

#hotif

; use long pressed ";" as a ctrl modifier key
ihCtrl := InputHook("T0.12") ; 120 ms
SC027:: {
    pressed := A_TickCount
    ihCtrl.Start()
    ihCtrl.Wait()
    switch ihCtrl.EndReason {
      case "Stopped": Send("{SC027}")
      case "Timeout": 
        Send("{Ctrl down}")
    }
}
SC027 Up::{
  if (ihCtrl.EndReason = "Timeout")
    Send("{Ctrl up}")
  ihCtrl.Stop()
}

; use long pressed "'" as a alt modifier key 
ihAlt := InputHook("T0.12") ; 120 ms
SC028:: {
    pressed := A_TickCount
    ihAlt.Start()
    ihAlt.Wait()
    switch ihAlt.EndReason {
      case "Stopped": Send("{SC028}")
      case "Timeout": 
        Send("{Alt down}")
    }
}
SC028 Up::{
  if (ihAlt.EndReason = "Timeout")
    Send("{Alt up}")
  ihAlt.Stop()
}

sendkeywithmodifiers(key) {
    modifiers := ""
    if getkeystate("shift")
        modifiers .= "+"
    if getkeystate("ctrl")
        modifiers .= "^"
    if getkeystate("alt")
        modifiers .= "!"
    if getkeystate("lwin") or getkeystate("rwin")
        modifiers .= "#"
    send(modifiers . "{" . key . "}")
    return
}

tryactivate(search) {
    if winexist("ahk_exe " . search) 
        if winactive("ahk_exe " . search) {
            groupname := strreplace("wingropup" . search, ".", "")
            groupname := strreplace(groupname, " ", "")
            groupadd(groupname, "ahk_exe " . search) ; add only internet explorer windows to this group.
            groupactivate(groupname)
        } else {
            winactivate
        }
    else 
        send("{lwin}")
    return
}

modifierpressed() {
	return getkeystate("ctrl")
	    || getkeystate("alt")
	    || getkeystate("shift")
}

checkdevtools(state) {

    if winactive("ahk_exe chrome.exe") {
        if (state == "on") {
            send("+{f6}")  ; sends shift + f6
            sleep(10)     ; waits for 100 milliseconds
            send("^l")     ; sends ctrl + l
            sleep(10)     ; waits for 100 milliseconds
            send("+{f6}")  ; sends shift + f6
        } 
        if (state == "off") {
            send("+{f6}")  ; sends shift + f6
            sleep(10)     ; waits for 100 milliseconds
            send("^l")     ; sends ctrl + l
            sleep(10)     ; waits for 100 milliseconds
            send("+{f6}")  ; sends shift + f6
            sleep(10)     ; waits for 100 milliseconds
            send("+{f6}")  ; sends shift + f6
        }        
    }

    return
}
