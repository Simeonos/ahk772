ReadMemory(MADDRESS, pid := -1) {
  global ClientPID
  if pid = -1
    pid := ClientPID

  VarSetCapacity(MVALUE,4,0)
  ProcessHandle := DllCall("OpenProcess", "Int", 24, "Char", 0, "UInt", pid, "UInt")
  DllCall("ReadProcessMemory","UInt",ProcessHandle,"UInt",MADDRESS,"Float*",float,"UInt",8,"UInt *",0)
  DllCall("CloseHandle", "int", ProcessHandle)

  return, float
}

ReadMemory2byte(MADDRESS, pid := -1) {
  global ClientPID
  if pid = -1
    pid := ClientPID

  VarSetCapacity(MVALUE,4,0)
  ProcessHandle := DllCall("OpenProcess", "Int", 24, "Char", 0, "UInt", pid, "UInt")
  DllCall("ReadProcessMemory","UInt",ProcessHandle,"UInt",MADDRESS,"Str",MVALUE,"UInt",2,"UInt *",0)
  DllCall("CloseHandle", "int", ProcessHandle)
  Loop 4
  result += *(&MVALUE + A_Index-1) << 8*(A_Index-1)

  return, result
}


ReadMemory4byte(MADDRESS, pid := -1) {
  global ClientPID
  if pid = -1
    pid := ClientPID

  VarSetCapacity(MVALUE,4,0)
  ProcessHandle := DllCall("OpenProcess", "Int", 24, "Char", 0, "UInt", pid, "UInt")
  DllCall("ReadProcessMemory","UInt",ProcessHandle,"UInt",MADDRESS,"Str",MVALUE,"UInt",4,"UInt *",0)
  DllCall("CloseHandle", "int", ProcessHandle)
  Loop 4
  result += *(&MVALUE + A_Index-1) << 8*(A_Index-1)

  return, result
}


ReadMemory8byte(MADDRESS, pid := -1) {
  global ClientPID
  if pid = -1
    pid := ClientPID

  VarSetCapacity(MVALUE,4,0)
  ProcessHandle := DllCall("OpenProcess", "Int", 24, "Char", 0, "UInt", pid, "UInt")
  DllCall("ReadProcessMemory","UInt",ProcessHandle,"UInt",MADDRESS,"Str",MVALUE,"UInt",8,"UInt *",0)
  DllCall("CloseHandle", "int", ProcessHandle)
  Loop 4
  result += *(&MVALUE + A_Index-1) << 8*(A_Index-1)

  return, result
}


ReadMemoryString(MADDRESS, pid := -1) {
  global ClientPID
  if pid = -1
    pid := ClientPID

  ProcessHandle := DllCall("OpenProcess", "Int", 24, "Char", 0, "UInt", pid, "Uint")
  teststr =
  Loop 32
  {
     Output := "x"  ; Put exactly one character in as a placeholder. used to break loop on null
     tempVar := DllCall("ReadProcessMemory", "UInt", ProcessHandle, "UInt", MADDRESS, "str", Output, "Uint", 1, "Uint *", 0)
     if (ErrorLevel or !tempVar)
     {
      DllCall("CloseHandle", "int", ProcessHandle)
      return teststr
     }
    ; if Output =
    ;  break

     teststr = %teststr%%Output%
     MADDRESS++
  }
  DllCall("CloseHandle", "int", ProcessHandle)
  return, teststr
}
