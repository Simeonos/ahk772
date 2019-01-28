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
  		ScanForMoneyAndMove()
  		Sleep 50
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
      } else {
        DebugAppend("Could not find food this time ..")
      }
  	}
}
