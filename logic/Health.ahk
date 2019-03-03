ManageHealth() {
  Health := GetHealthPercentage()
    if (Health < 0.9 && GetCurrentMana() >= 25) {
      DebugAppend("Health from manage: " . Health)
      Toets("F1")
    }

    if Health < 0.64
      {
  	    DebugAppend("Broke again: " . Health)
  	  ; WinClose, ahk_pid %ClientPID%
  	  ; sleep, 500
      ;   Toets("E")
  	  ; Send e
  	}
    
  Global LowerLimitOfHealth  
  Global KeyWhenHealthBelowLowerLimit
  Health := GetCurrentHealth()
  if Health < LogOutWhenHealthBelow
  {
    Toets(%KeyWhenHealthBelowLowerLimit%)
    Sleep 1000
    CloseTibia()
  }
}
