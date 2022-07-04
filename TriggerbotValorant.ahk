#NoEnv 
#persistent
#MaxThreadsPerHotkey 2
#KeyHistory 0
ListLines Off
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1
SendMode Input
CoordMode, Pixel, Screen
SoundBeep, 300, 200
SoundBeep, 400, 200

key_stay_on	    := 	"Up"
key_hold_mode	:= 	"Right"
key_fastclick 	:= 	"Left"
key_off		    := 	"Down"
key_gui_hide	:=	"Home"
key_exit	    := 	"End"
key_hold	    :=	"XButton1"

pixel_box	:=	5
pixel_sens	:=	50
pixel_color	:=	0xFEFE40
tap_time	:=	150


;Credits: Robin0248?
Gui,2:Font,Cdefault,Fixedsys
Gui,2:Color,Black
Gui,2:Color, EEAA99
Gui,2:Add,Progress, x10 y20 w100 h23 Disabled BackgroundBlue vC3
Gui,2:Add,Text, xp yp wp hp cWhite BackgroundTrans Center 0x200 vB3 gStart,On
Gui,2:Add,Progress, x10 y20 w100 h23 Disabled BackgroundBlue vC2
Gui,2:Add,Text, xp yp wp hp cWhite BackgroundTrans Center 0x200 vB2 gStart,Hold mode
Gui,2:Add,Progress, xp yp wp hp Disabled BackgroundRED vC1
Gui,2:Add,Text, xp yp wp hp cWhite BackgroundTrans Center 0x200 vB1 gStart,Off
Gui,2: Show, x10 y1 w200 h60
Gui 2:+LastFound +ToolWindow +AlwaysOnTop -Caption
WinSet, TransColor, EEAA99
2Guiescape:
2Guiclose:
leftbound:= A_ScreenWidth/2-pixel_box
rightbound:= A_ScreenWidth/2+pixel_box
topbound:= A_ScreenHeight/2-pixel_box
bottombound:= A_ScreenHeight/2+pixel_box 
hotkey, %key_stay_on%, stayon
hotkey, %key_hold_mode%, holdmode
hotkey, %key_off%, offloop
hotkey, %key_gui_hide%, guihide
hotkey, %key_exit%, terminate
Hotkey, % key_fastclick, fastclick
return
start:
gui,2:submit,nohide
terminate:
SoundBeep, 300, 200
SoundBeep, 200, 200
Sleep 400
exitapp
stayon:
SoundBeep, 300, 200
settimer, loop2, off
settimer, loop1, 100
GuiControl,2: hide,B1
GuiControl,2: hide,C1
GuiControl,2: hide,B2
GuiControl,2: hide,C2
GuiControl,2: show,B3
GuiControl,2: show,C3
return
holdmode:
SoundBeep, 300, 200
settimer, loop1, off
settimer, loop2, 100
GuiControl,2: hide,B1
GuiControl,2: hide,C1
GuiControl,2: show,B2
GuiControl,2: show,C2
GuiControl,2: hide,B3
GuiControl,2: hide,C3
return
offloop:
SoundBeep, 300, 200
settimer, loop1, off
settimer, loop2, off
GuiControl,2: show,B1
GuiControl,2: show,C1
GuiControl,2: hide,B2
GuiControl,2: hide,C2
GuiControl,2: hide,B3
GuiControl,2: hide,C3
return
guihide:
GuiControl,2: hide,B1
GuiControl,2: hide,C1
GuiControl,2: hide,B2
GuiControl,2: hide,C2
GuiControl,2: hide,B3
GuiControl,2: hide,C3
return

loop1:
PixelSearch()
return

loop2:
While GetKeyState(key_hold, "P"){
PixelSearch()
}
return

fastclick:
SoundBeep, 300, 200
toggle := !toggle
return
#if toggle
*~$LButton::
sleep 100
While GetKeyState("LButton", "P"){
Click
sleep 10
}
return
#if

PixelSearch() {
global
PixelSearch, FoundX, FoundY, leftbound, topbound, rightbound, bottombound, pixel_color, pixel_sens, Fast RGB
If !(ErrorLevel)
{
If !GetKeyState("LButton")
{
click
sleep %tap_time%
}
}
return
}