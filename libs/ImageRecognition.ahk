{
  ZoekInTibiaRechtsNaarLinks(FoundX1, FoundY1, 0,0,0,0, "assets/health-icon.png") 	; Referentiepunt zoeken
    Global HealthXLinks := FoundX1+15
    Global HealthXRechts := HealthXLinks+85
    Global HealthY := FoundY1 - 3
    Global ManaXLinks := HealthXLinks
    Global ManaXRechts := HealthXRechts
    Global ManaY := HealthY + 13

    ; Canvas regio:
  ZoekInTibia(FoundX2, FoundY2, 0,0,0,0, "assets/GrijzeVlakLinksBoven.png")	; Referentiepunt GrijzeVlakX1 en GrijzeVlakY1
  ZoekInTibia(FoundX3, FoundY3, 0,0,0,0, "assets/GrensCanvasTabbladenLinkerDeel.png")
  GrijzeVlakX1 := FoundX2 + 7 		; Linkerrand van het grijze vlak waarin de canvas wordt getekend plus minimale rand van 7 pixels.
  GrijzeVlakY1 := FoundY2 + 7 		; Bovenrand van het grijze vlak waarin de canvas wordt getekend plus de constante rand van 7 pixels.
  GrijzeVlakX2 := FoundX1 - 21 		; Rechterrand grijze vlak waarin de canvas wordt getekend minus minimale rand van 6 pixels
  GrijzeVlakY2 := FoundY3 - 6  		; Onderrand van het grijze vlak waarin de canvas wordt getekend minus constante rand van 6 pixels.
  Global CharX := 0.5*(GrijzeVlakX1+GrijzeVlakX2)
  Global CharY := 0.5*(GrijzeVlakY1+GrijzeVlakY2)
  Global Square := (GrijzeVlakY2 - GrijzeVlakY1) / 11
  Global CanvasY1 := GrijzeVlakY1 	; De bovenrand van het scherm waarin de speelvakjes getekend worden (de canvas)
  Global CanvasY2 := GrijzeVlakY2 	; De onderrand van het scherm waarin de speelvakjes getekend worden (de canvas)
  Global CanvasX1 := Round(CharX - 7.5*Square - 1)
  Global CanvasX2 := Round(CharX + 7.5*Square)

    ; Mapregio
    Global MapLinksbovenX := HealthXLinks - 20
    Global MapLinksbovenY := HealthY - 122
    Global MapRechtsonderX := MapLinksbovenX + 107
    Global MapRechtsonderY := MapLinksbovenY + 107
}

FindAttackBox() {
  Global BattleSchermX1
	Global BattleSchermY1
	Global BattleSchermX2
	Global BattleSchermY2
	ZoekInTibia(FoundX,FoundY,0,0,0,0,"assets/is-attacking.png")

	if (FoundX > 0) {
    Return True
  }

  ZoekInTibia(FoundX,FoundY,0,0,0,0,"assets/is-attacking-hover.png")

	if (FoundX > 0) {
    Return True
  }

	Return False
}

FindBattleScreen() {
  Global BattleSchermX1
  Global BattleSchermY1
  Global BattleSchermX2
  Global BattleSchermY2
  ZoekInTibiaRechtsNaarLinks(FoundX,FoundY,0,0,0,0,"assets/battlelist-begin.png")
  BattleSchermX1 := FoundX +4
  BattleSchermY1 := FoundY + 15
  ZoekInTibia(FoundX,FoundY,BattleSchermX1,BattleSchermY1,0,0,"assets/battlelist-end.png")
  BattleSchermX2 := FoundX ; +14 ; evt. +14 weglaten
  BattleSchermY2 := FoundY ; +14
}

getHwndForPid(pid) {
    pidStr := "ahk_pid " . pid
    WinGet, hWnd, ID, %pidStr%
	; MsgBox hWnd
    return hWnd
}

ZoekBitmapSim(ByRef pid1, ByRef FoundX1="",ByRef FoundY1="",LiBovenX := 0, LiBovenY := 0, ReOnderX := 0, ReOnderY := 0, filename := "testplaatje.png") { ; werkt!
  SplashTextOn,,, bla ; splashtext maakt om de een of andere reden een directx window screenshootable
  ; MsgBox test
  SplashTextOff
  bmpHaystack := Gdip_BitmapFromHWND(getHwndForPid(pid1))
  bmpNeedle := Gdip_CreateBitmapFromFile(filename)
  FoundX1 := "-1"
  FoundY1 := "-1"
  Gdip_ImageSearch(bmpHaystack, bmpNeedle, FoundX1, FoundY1,, LiBovenX, LiBovenY, ReOnderX, ReOnderY,,,,1)
  bmpHaystack :=
  bmpNeedle :=
  ; oFile:=a_scriptdir "\haystack.png"
  ; Gdip_SaveBitmapToFile(bmpHaystack, oFile)
  ; MsgBox % list_image
  Return list_image
}

ZoekBitmapSimRechtsNaarLinks(ByRef pid1, ByRef FoundX1="",ByRef FoundY1="",LiBovenX := 0, LiBovenY := 0, ReOnderX := 0, ReOnderY := 0, filename := "testplaatje.png") { ; Zou moeten werken, want andersom werkt ook
  SplashTextOn,,, bla ; splashtext maakt om de een of andere reden een directx window screenshootable
  SplashTextOff
  ; MsgBox test
  bmpHaystack := Gdip_BitmapFromHWND(getHwndForPid(pid1))
  bmpNeedle := Gdip_CreateBitmapFromFile(filename)
  FoundX1 := "-1"
  FoundY1 := "-1"
  Gdip_ImageSearch(bmpHaystack, bmpNeedle, FoundX1, FoundY1,, LiBovenX, LiBovenY, ReOnderX, ReOnderY,,,4,1)
  bmpHaystack := 
  bmpNeedle :=
  ;oFile:=a_scriptdir "\haystack.png"
  ;Gdip_SaveBitmapToFile(bmpHaystack, oFile)
  ; MsgBox % list_image
  Return list_image
}

  
ZoekInTibia(ByRef FoundX1, ByRef FoundY1, X1, Y1, X2, Y2, filename) {
  Global ClientPID
  ZoekBitmapSim(ClientPID,FoundX1,FoundY1,X1,Y1,X2,Y2,filename)
}

ZoekInTibiaRechtsNaarLinks(ByRef FoundX1, ByRef FoundY1, X1, Y1, X2, Y2, filename) { ; te lui om extra parameter toe te voegen
  Global ClientPID
  ZoekBitmapSimRechtsNaarLinks(ClientPID,FoundX1,FoundY1,X1,Y1,X2,Y2,filename)
}
