#SingleInstance

#include *i dependencies/Gdip_All.ahk
#include *i dependencies/gdip_imagesearchSim.ahk

#include libs/Config.ahk
#include libs/Setup.ahk
#include libs/ImageRecognition.ahk
#include libs/Debug.ahk
#include libs/TibiaApi.ahk
#include libs/AhkHelpers.ahk

#include logic/Health.ahk
#include logic/Looting.ahk
#include logic/Mana.ahk

Main() {
  Loop {
    Think()
    Sleep 1000
  }
}

Think() {
  ManageHealth()
  ManageMana()
  UpdateLocation()
  UpdateBattlelist()

  if (MonstersPresent()) {
    if (IsAttacking()) {

    } else {
      AttackFirstMonster()
    }
  } else {
    FindNewMonsters()
  }
}

AttackFirstMonster() {
  Global WasAttacking

  Global WasAttacking := True
  Global BattleSchermX1
  Global BattleSchermY1
  Sleep, 10
  FindBattleScreen()
  Click(BattleSchermX1 +5, BattleSchermY1+5,"Left")
}

FindNewMonsters() {
  Global CoordX
  Global CoordY
  Global CurrentNodeIndex
  Global WasAttacking
  Global Waypoints

  if (WasAttacking = True) {
    DebugAppend("Will try to loot ..")
    Loot()
    WasAttacking := False
  }

  DiffX := Waypoints[CurrentNodeIndex]["x"] - CoordX
  DiffY := Waypoints[CurrentNodeIndex]["y"] - CoordY

  if (DiffX < 3 && DiffX > -3 && DiffY < 3 && DiffY > -3) {
    DebugAppend("Walking to a new waypoint")
    CurrentNodeIndex := CurrentNodeIndex + 1

    if (CurrentNodeIndex > Waypoints.Length()) {
      CurrentNodeIndex := 1
    }

    FindNewMonsters()
  }

  if (GetCurrentMana() >= 200) {
    ClickCoordinateOnMap(Waypoints[CurrentNodeIndex]["x"], Waypoints[CurrentNodeIndex]["y"])
  }
}

IsAttacking() {
  return FindAttackBox()
}

MonstersPresent() {
  Global Monsters

  if (Monsters.Length() > 0) {
      return true
  }

  return false
}

^h::
  UpdateLocation()
  Global CoordX
  Global CoordY
  MsgBox % CoordX . ", " . CoordY
Return

^r:: ; WERKT Sneltoets voor herladen van script
  Run *RunAs %A_ScriptFullPath% %1%
	  ExitApp
Return

^w:: ; Sneltoets voor beginnen met botten
  Main()
Return

^1::
loop,
  {
    ManageHealth()
    Sleep, 1000
  }
Return

DebugAppend("Welcome to Tibia.")
