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

  DebugClear()

  Global Monsters
  for index, element in Monsters
  {
      DebugAppend("Found: " . element["name"] . " (" . element["health"] . ")")
  }
}

^r:: ; WERKT Sneltoets voor herladen van script
  Run *RunAs %A_ScriptFullPath% %1%
	  ExitApp
Return

^w:: ; Sneltoets voor beginnen met botten
  Main()
Return

DebugAppend("Welcome to Tibia.")
