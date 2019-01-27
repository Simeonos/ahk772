﻿#SingleInstance

#include *i dependencies/Gdip_All.ahk
#include *i dependencies/gdip_imagesearchSim.ahk

#include libs/Config.ahk
#include libs/Setup.ahk
#include libs/ImageRecognition.ahk
#include libs/Debug.ahk
#include libs/TibiaApi.ahk
#include libs/AhkHelpers.ahk

#include logic/Health.ahk
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
  DebugAppend("Thinking .. " . Waypoints.Count())
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
  Global BattleSchermX1
  Global BattleSchermY1
  Sleep, 10
  FindBattleScreen()
  DebugAppend("Trying to click first monster .." . BattleSchermX1)
  Click(BattleSchermX1 +5, BattleSchermY1+5,"Left")
}

FindNewMonsters() {
  Global CurrentNodeIndex
  Global Waypoints
  ClickCoordinateOnMap(Waypoints[CurrentNodeIndex]["x"], Waypoints[CurrentNodeIndex]["y"])
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

^r:: ; WERKT Sneltoets voor herladen van script
  Run *RunAs %A_ScriptFullPath% %1%
	  ExitApp
Return

^w:: ; Sneltoets voor beginnen met botten
  Main()
Return

DebugAppend("Welcome to Tibia.")