#Requires AutoHotkey >=2.0

f5::reload

; list of key codes: https://kbdlayout.info/kbdusx/virtualkeys

#hotif !modifierpressed()

capslock::return
capslock & j::sendkeywithmodifiers("left")
capslock & k::sendkeywithmodifiers("down")
capslock & l::sendkeywithmodifiers("right")
capslock & i::sendkeywithmodifiers("up")
capslock & h::sendkeywithmodifiers("home")
capslock & o::sendkeywithmodifiers("end")
capslock & backspace::sendkeywithmodifiers("delete")


ih := InputHook("I")
ih.KeyOpt("{All}", "+N") ; Enable notification for all keys
ih.OnKeyDown := onkeydown

SC034::{
    global pressed := A_TickCount
    ih.Start()
    KeyWait(A_ThisHotkey)
}

SC034 Up::{
    ih.Stop()
    if (ih.Input = "" and A_TickCount - pressed < 120)
        Send(".")
}

onkeydown(ih, vk, sc) {
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
  }
}

$escape::{
    errorlevel := !keywait("escape", "t0.5")
    if (errorlevel) {
        errorlevel := !keywait("escape")
        postmessage(0x112, 0xf060, , , "a")
    } else {
        sendinput("{escape}")
    }
    return
}

#hotif

#hotif winactive("ahk_exe chrome.exe") and !modifierpressed()
z & h::checkdevtools("off")
z & l::checkdevtools("on")
z::{
    errorlevel := !keywait("z", "t0.08")
    if (errorlevel) {
        errorlevel := !keywait("z")
    } else {
        sendinput("{z}")
    }
    return
}
#hotif

; $<+`;::return
$`;::{
    errorlevel := !keywait("`;", "t0.12")
    if (errorlevel) {
        send("{ctrl down}")
        errorlevel := !keywait("`;")
        send("{ctrl up}")
    } else {
        send("{vkba}")
    }
    return
}

; $<+'::return
$'::{
    errorlevel := !keywait("`'", "t0.12")
    if (errorlevel) {
        send("{alt down}")
        errorlevel := !keywait("`'")
        send("{alt up}")
    } else {
        send("{vkde}")
    }
    return
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
