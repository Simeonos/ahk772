#include libs/Memory.ahk

; Public methods

GetCoordX() {
	coordX := ReadMemory4byte(0x005776e8)
	return coordX
}

GetCoordY() {
	coordY := ReadMemory4byte(0x005776e4)
	return coordY
}

GetCoordZ() {
	return ReadMemory4byte(0x005776e0)
}

GetCurrentHealth() {
	currentHealth := ReadMemory4byte(0x0056c848)
	return currentHealth
}

GetCurrentMana() {
  currentMana := ReadMemory4byte(0x0056c82c)
  return currentMana
}

GetHealthPercentage() {
   currentHealth := GetCurrentHealth()
   maxHealth := GetMaxHealth()
   return currentHealth / maxHealth
}

GetManaPercentage() {
   currentMana := GetCurrentMana()
   maxMana := GetMaxMana()
   return currentMana / maxMana
}

GetMaxHealth() {
	maxHealth := ReadMemory4byte(0x0056c844)
	return maxHealth
}

GetMaxMana() {
  maxMana := ReadMemory4byte(0x0056c828)
  return maxMana
}

UpdateBattlelist() {
  Global CoordZ
  Global Monsters := []

  while count < 50
  {
    name := ReadMemoryString(0x0056c8b0 + 4 + (156 * count))
    ; x = 36
    ; y = 40
    ; z = 42
    level := ReadMemory2byte(0x0056c8b0 + 44 + (156 * count))
    health := ReadMemory4byte(0x0056c8b0 + 132 + (156 * count))
    status := ReadMemory2byte(0x0056c8b0 + 140 + (156 * count))
    if (level = CoordZ && status = 1 && CharacterName <> name)
    {
      Monsters.Push({name: name, health: health})
    }
    count++
  }


	return value
}

UpdateLocation() {
  Global CoordX := GetCoordX()
  Global CoordY := GetCoordY()
  Global CoordZ := GetCoordZ()
}
