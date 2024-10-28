#Requires AutoHotkey >=2.0

#HotIf !ModifierPressed()

CapsLock::Return
CapsLock & j::sendKeyWithModifiers("Left")
CapsLock & k::sendKeyWithModifiers("Down")   
CapsLock & l::sendKeyWithModifiers("Right")
CapsLock & i::sendKeyWithModifiers("Up")
CapsLock & h::sendKeyWithModifiers("Home")
CapsLock & o::sendKeyWithModifiers("End")
CapsLock & Backspace::sendKeyWithModifiers("Delete")

. & t::tryActivate("WindowsTerminal.exe") 
. & d::tryActivate("phpstorm64.exe")
. & g::tryActivate("goland64.exe")
. & s::tryActivate("slack.exe")
. & c::tryActivate("chrome.exe")
. & e::tryActivate("msedge.exe")
. & v::tryActivate("code.exe")
. & z::tryActivate("Zoom.exe")
. & f::tryActivate("s CabinetWClass ahk_exe explorer.exe")
. & b::Send("^b") ; use to enter tmux mod
. & a::Send("^+a") ; use to search tabs in browser

.::{
    ErrorLevel := !KeyWait(".", "T0.08")
    if (ErrorLevel) {
        ErrorLevel := !KeyWait(".")
    } else {
        SendInput("{.}")
    }
    return
}

$Escape::{
    ErrorLevel := !KeyWait("Escape", "T0.5")
    if (ErrorLevel) {
        ErrorLevel := !KeyWait("Escape")
        PostMessage(0x112, 0xF060, , , "A")
    } else {
        SendInput("{Escape}")
    }
    return
}

#HotIf

#HotIf WinActive("ahk_exe chrome.exe") and !ModifierPressed()
z & h::CheckDevTools("off")
z & l::CheckDevTools("on")
z::{
    ErrorLevel := !KeyWait("z", "T0.08")
    if (ErrorLevel) {
        ErrorLevel := !KeyWait("z")
    } else {
        SendInput("{z}")
    }
    return
}
#HotIf

; $<+`;::return
$`;::{
    ErrorLevel := !KeyWait("`;", "T0.12")
    if (ErrorLevel) {
        Send("{Ctrl down}")
        ErrorLevel := !KeyWait("`;")
        Send("{Ctrl up}")
    } else {
        Send("{vkBA}")
    }
    return
}

; $<+'::return
$'::{
    ErrorLevel := !KeyWait("`'", "T0.12")
    if (ErrorLevel) {
        Send("{Alt down}")
        ErrorLevel := !KeyWait("`'")
        Send("{Alt up}")
    } else {
        Send("{vkDE}")
    }
    return
}

sendKeyWithModifiers(key) {
    modifiers := ""
    if GetKeyState("Shift")
        modifiers .= "+"
    if GetKeyState("Ctrl")
        modifiers .= "^"
    if GetKeyState("Alt")
        modifiers .= "!"
    if GetKeyState("LWin") or GetKeyState("RWin")
        modifiers .= "#"
    Send(modifiers . "{" . key . "}")
    return
}

tryActivate(search) {
    if WinExist("ahk_exe " . search) 
        if WinActive("ahk_exe " . search) {
            groupName := StrReplace("winGropup" . search, ".", "")
            groupName := StrReplace(groupName, " ", "")
            GroupAdd(groupName, "ahk_exe " . search) ; Add only Internet Explorer windows to this group.
            GroupActivate(groupName)
        } else {
            WinActivate
        }
    else 
        Send("{LWin}")
    return
}

ModifierPressed() {
	Return GetKeyState("Ctrl")
	    || GetKeyState("Alt")
	    || GetKeyState("Shift")
}

CheckDevTools(state) {

    If WinActive("ahk_exe chrome.exe") {
        if (state == "on") {
            Send("+{F6}")  ; Sends Shift + F6
            Sleep(10)     ; Waits for 100 milliseconds
            Send("^l")     ; Sends Ctrl + L
            Sleep(10)     ; Waits for 100 milliseconds
            Send("+{F6}")  ; Sends Shift + F6
        } 
        if (state == "off") {
            Send("+{F6}")  ; Sends Shift + F6
            Sleep(10)     ; Waits for 100 milliseconds
            Send("^l")     ; Sends Ctrl + L
            Sleep(10)     ; Waits for 100 milliseconds
            Send("+{F6}")  ; Sends Shift + F6
            Sleep(10)     ; Waits for 100 milliseconds
            Send("+{F6}")  ; Sends Shift + F6
        }        
    }

    return
}