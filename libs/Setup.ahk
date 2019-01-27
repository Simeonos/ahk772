#include *i dependencies/Gdip_All.ahk
#include *i dependencies/gdip_imagesearchSim.ahk

{
  WinGet, ClientPID, PID, ahk_exe %ClientPath% 	; Window zoeken

  {
    If !pToken := Gdip_Startup() {
      MsgBox, 48, gdiplus error!, Gdiplus failed to start. Please ensure you have gdiplus on your system
      ExitApp
    }

    Gdip_PixelSearch(pBitmap, ARGB, ByRef x, ByRef y) {
      static _PixelSearch
      if !_PixelSearch {
        MCode_PixelSearch := "8B44241099535583E2035603C233F6C1F80239742418577E388B7C24148B6C24248B5424188D1C85000000008D64240033C085D27E108BCF3929743183C00183C1043BC27CF283C60103FB3B74241C7CDF8B4424288B4C242C5F5EC700FFFFFFFF5DC701FFFFFFFF83C8FF5BC38B4C24288B54242C5F890189325E5D33C05BC3"

        VarSetCapacity(_PixelSearch, StrLen(MCode_PixelSearch)//2)
        Loop % StrLen(MCode_PixelSearch)//2      ;%
        NumPut("0x" SubStr(MCode_PixelSearch, (2*A_Index)-1, 2), _PixelSearch, A_Index-1, "char")
      }

      Gdip_GetImageDimensions(pBitmap, Width, Height)

      if !(Width && Height)
        return -1

      if (E1 := Gdip_LockBits(pBitmap, 0, 0, Width, Height, Stride1, Scan01, BitmapData1))
        return -2

      x := y := 0
      E := DllCall(&_PixelSearch, "uint", Scan01, "int", Width, "int", Height, "int", Stride1, "uint", ARGB, "int*", x, "int*", y)
      Gdip_UnlockBits(pBitmap, BitmapData1)
      Gdip_DisposeImage(pBitmap) ; nog testen evt verw
      Gdip_Shutdown(pToken) ; nog testen evt verw
      return (E = "") ? -3 : E
    }
  }
}
