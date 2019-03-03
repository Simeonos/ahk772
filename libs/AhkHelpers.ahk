Click(X, Y, Button) {
  Global ClientPID
  KlikX := % "x" . X
  KlikY := % "y" . Y
  SetControlDelay -1
  ControlClick, %KlikX% %KlikY%, ahk_pid %ClientPID%,,%Button%,, NA
}

ClickCoordinateOnMap(ByRef X, ByRef Y) {
  Global MapLinksBovenX
  Global MapLinksBovenY

  Global CoordX
  Global CoordY

  DiffX := CoordX - X
  DiffY := CoordY - Y

  TargetX := MapLinksBovenX + 54 - DiffX
  TargetY := MapLinksBovenY + 54 - DiffY

  Click(TargetX, TargetY, "Left")
}

TibiaActief() {
  Global ClientPID
  WinGet, active_ahk_pid, PID, A
  if active_ahk_pid = %ClientPID%
    Return True
  else
    Return False
}

Toets(InTeDrukkenToets) {
  Global ClientPID
  if TibiaActief() {
	  Send {%InTeDrukkenToets%}
	}
  else {
	  SplashTextOn,,, bla ; splashtext maakt om de een of andere reden een directx window ControlReceivable
	  SplashTextOff
	  ControlSend,,{%InTeDrukkenToets%}, ahk_pid %ClientPID%
	}
}

CloseTibia() {
Global ClientPID
WinKill, ahk_pid %ClientPID%
loop, 10
  {
    ControlSend, , e, ahk_pid %ClientPID%
    sleep 1000
    WinKill, ahk_pid %ClientPID%
  }
}
