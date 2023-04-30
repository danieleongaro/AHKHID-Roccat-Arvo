#include AHKHID.ahk

;Create GUI to receive messages
Gui, +LastFound
hGui := WinExist()

;Intercept WM_INPUT messages
WM_INPUT := 0xFF
OnMessage(WM_INPUT, "InputMsg")

;Register device with RIDEV_INPUTSINK (so that data is received even in the background)
r := AHKHID_Register(12, 1, hGui, RIDEV_INPUTSINK)

InputMsg(wParam, lParam) {
Local devh, iKey, sLabel, conv

Critical

;Get handle of device
devh := AHKHID_GetInputInfo(lParam, II_DEVHANDLE)

;Check for error
If (devh <> -1) ;Check that it is my macroKeys
And (AHKHID_GetDevInfo(devh, DI_DEVTYPE, True) = RIM_TYPEHID)
And (AHKHID_GetDevInfo(devh, DI_HID_VENDORID, True) = 7805)
And (AHKHID_GetDevInfo(devh, DI_HID_PRODUCTID, True) = 12500)
And (AHKHID_GetDevInfo(devh, DI_HID_VERSIONNUMBER, True) = 257) {

;Get data
iKey := AHKHID_GetInputData(lParam, uData)
conv := Bin2Hex(&uData, iKey)
;Check for error
If (iKey <> -1) {
	;MsgBox, primaif valore iKey = %iKey% e uData=  %conv%

	if (conv = 010170){
		;MsgBox, premuta macro 1
		SendInput, {Volume_Down}
		Return
	}
	if (conv = 010270){
		;MsgBox, premuta macro 2
		SendInput, {Media_Play_Pause}
		Return
	}
	if (conv = 010370){
		;MsgBox, premuta macro 3
		SendInput, {Volume_Up}
		Return
	}
	if (conv = 010470){
		;MsgBox, premuta macro 4
		SendInput, {Media_Prev}
		Return
	}
	if (conv = 010570){
		;MsgBox, premuta macro 5
		SendInput, {Media_Next}
		Return
	}
}
}
}

Bin2Hex(addr,len) {
    Static fun, ptr 
    If (fun = "") {
        If A_IsUnicode
            If (A_PtrSize = 8)
                h=4533c94c8bd14585c07e63458bd86690440fb60248ffc2418bc9410fb6c0c0e8043c090fb6c00f97c14180e00f66f7d96683e1076603c8410fb6c06683c1304180f8096641890a418bc90f97c166f7d94983c2046683e1076603c86683c13049ffcb6641894afe75a76645890ac366448909c3
            Else h=558B6C241085ED7E5F568B74240C578B7C24148A078AC8C0E90447BA090000003AD11BD2F7DA66F7DA0FB6C96683E2076603D16683C230668916240FB2093AD01BC9F7D966F7D96683E1070FB6D06603CA6683C13066894E0283C6044D75B433C05F6689065E5DC38B54240833C966890A5DC3
        Else h=558B6C241085ED7E45568B74240C578B7C24148A078AC8C0E9044780F9090F97C2F6DA80E20702D1240F80C2303C090F97C1F6D980E10702C880C1308816884E0183C6024D75CC5FC606005E5DC38B542408C602005DC3
        VarSetCapacity(fun, StrLen(h) // 2)
        Loop % StrLen(h) // 2
            NumPut("0x" . SubStr(h, 2 * A_Index - 1, 2), fun, A_Index - 1, "Char")
        ptr := A_PtrSize ? "Ptr" : "UInt"
        DllCall("VirtualProtect", ptr, &fun, ptr, VarSetCapacity(fun), "UInt", 0x40, "UInt*", 0)
    }
    VarSetCapacity(hex, A_IsUnicode ? 4 * len + 2 : 2 * len + 1)
    DllCall(&fun, ptr, &hex, ptr, addr, "UInt", len, "CDecl")
    VarSetCapacity(hex, -1) ; update StrLen
    Return hex
}
