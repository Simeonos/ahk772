ManageMana() {
  mana := GetManaPercentage()

  if (mana > 0.9) {
    Toets("F1")
    DebugAppend("Reducing Mana.")
  }
}
