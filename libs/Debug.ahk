Gui, Add, Edit, Readonly x10 y10 w400 h300 vDebug
Gui, Show, w420 h320, Debug Window

DebugAppend(Data) {
	GuiControlGet, Debug
	GuiControl,, Debug, %Data%`r`n%Debug%
}

DebugClear() {
	GuiControlGet, Debug
	GuiControl,, Debug, Cleared`r`n
}

DebugReplace(Data) {
	GuiControlGet, Debug
	GuiControl,, Debug, %Data%`r`n
}
