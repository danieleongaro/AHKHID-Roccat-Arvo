#include AHKHID.ahk ; https://github.com/jleb/AHKHID/issues/5
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


;Create GUI to receive messages
Gui, +LastFound
hGui := WinExist()

;Intercept WM_INPUT messages
WM_INPUT := 0xFF
OnMessage(WM_INPUT, "InputMsg")


r := AHKHID_Register(12, 1, hGui, RIDEV_INPUTSINK)

Return


InputMsg(wParam, lParam) {
    Local devh, iKey, sLabel
    
    Critical
    
    ;Get handle of device
    devh := AHKHID_GetInputInfo(lParam, II_DEVHANDLE)
    
    ;Check that it is my keyboard HID device
    If (AHKHID_GetDevInfo(devh, DI_DEVTYPE, True) = RIM_TYPEHID)
        And (AHKHID_GetDevInfo(devh, DI_HID_VENDORID, True) = 7805)
        And (AHKHID_GetDevInfo(devh, DI_HID_PRODUCTID, True) = 12500) 
	And (AHKHID_GetDevInfo(devh, DI_HID_VERSIONNUMBER, True) = 257) {
        ;Get data
        AHKHID_GetInputData(lParam, uData)
	iKey := NumGet(uData, 0, "UInt")
	;MsgBox, iKey: %iKey%
	;macro nr1
	If (iKey == 7340289){
	Send {Media_Prev}
	}

	;macro nr2
	If (iKey == 7340545){
	Send {Media_Play_Pause}
	}

	;macro nr3
	If (iKey == 7340801){
	Send {Media_Next}
	}

	;macro nr4
	If (iKey == 7341057){
	;Send {Media_Play_Pause} ;potrei mettere email
	}

	;macro nr5
	If (iKey == 7341313){
	;Send ^!{xz} ;ctrl alt z e x
	;SetTitleMatchMode, 2
	;ControlFocus,, Discord
	;Sleep, 1
	;Send ^+m
	;ControlSend,, {^+m}, Discord
	;ufficiale ctrl shift m == ^+m
	;mia custom ctrl alt x z == ^!xz
	;Return
	}
	
    }
}
