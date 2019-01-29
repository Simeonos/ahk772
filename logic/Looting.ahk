Loot() {
  global CharX
	global CharY
	global Square

	Click(CharX-1*Square,CharY-1*Square,"Right")
  Sleep 100
  Click(CharX-1*Square,CharY,"Right")
  Sleep 100
  Click(CharX-1*Square,CharY+1*Square,"Right")
  Sleep 100
  Click(CharX,CharY-1*Square,"Right")
  Sleep 100
  Click(CharX,CharY,"Right")
  Sleep 100
  Click(CharX,CharY+1*Square,"Right")
  Sleep 100
  Click(CharX+1*Square,CharY-1*Square,"Right")
  Sleep 100
  Click(CharX+1*Square,CharY,"Right")
  Sleep 100
  Click(CharX+1*Square,CharY+1*Square,"Right")
  Sleep 500
  EatHamOrMeat()
  Sleep 50()
  Loop 6
  	{
  		LootMoney()
  	}
}

EatHamOrMeat() {
  ZoekInTibiaRechtsNaarLinks(FoundX,FoundY,0,0,0,0,"assets/ham.png")
    if (FoundX > 0) {
  		Click(FoundX,FoundY,"Right")
  	} else {
  		ZoekInTibiaRechtsNaarLinks(FoundX,FoundY,0,0,0,0,"assets/meat.png")
  		if (FoundX > 0) {
  			Click(FoundX,FoundY,"Right")
      }
  	}
}

LootMoney() {
  LootSearchXLinks := 1743
  LootSearchXRechts := 1920
  LootSearchYBoven := 490
  LootSearchYOnder := 1040
  Global CharX
  Global CharY
  ClientPath := "C:\Program Files (x86)\Tibia\Tibia.exe"
  WinGet, VarContainingPID, PID, ahk_exe %ClientPath%
  ImageSearch, FoundX, FoundY, LootSearchXLinks,LootSearchYBoven,LootSearchXRechts,LootSearchYOnder, assets/money-color.bmp 		  ; 208, 111, 16

  if (FoundX > 0) {
    DebugAppend("Trying to loot ..")
     MouseClickDrag, Left, FoundX, FoundY, CharX, CharY
     Sleep 220
     ControlSend,,{Enter}, ahk_pid %VarContainingPID%
     Sleep 200
  }
}
