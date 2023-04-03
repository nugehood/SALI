#SingleInstance, force
#Include, lib\Chrome\Chrome.ahk ;https://github.com/G33kDude/Chrome.ahk/releases

Gui, Add, Text, x22 y99 w50 h20 +Left, NIM :
Gui, Add, Edit, x82 y99 w150 h20 vNIM +Left,
Gui, Add, Edit, x82 y149 w150 h20 vPASS +Password   +Left,
Gui, Add, Button, x112 y189 w90 h20 , LOGIN
Gui, Add, Text, x632 y139 w-894 h-190 +Center, AUTO LOGIN SIMARI
Gui, Add, Text, x10 y299 w250 h20 +Center +Theme, Made by Nuge
Gui, Add, Text, x22 y149 w50 h20 , PASS :
Gui, Add, GroupBox, x12 y9 w250 h310 , Simari Auto Login V 0.1.1
Gui, Font, S8 CDefault Bold, Verdana
Gui, Add, Button, x112 y225 w90 h20 +, DONATE
; Generated using SmartGUI Creator 4.0
Gui, Show, x449 y88 h340 w275, Simari Auto Login V 0.1.0
Return
ButtonDONATE:
Run, Donate.html
Return

ButtonLOGIN:
Gui Submit

; Create an instance of the Chrome class using
; the folder ChromeProfile to store the user profile
FileCreateDir, ChromeProfile
ChromeInst := new Chrome("ChromeProfile")

PageInst := ChromeInst.GetPage()
PageInst.Call("Page.navigate", {"url": "https://simari.ulm.ac.id/"})
PageInst.WaitForLoad()

try {
; Changing the values of NIM and Password
PageInst.Evaluate("document.getElementById('name').value = '" . NIM . "'")
PageInst.Evaluate("document.getElementById('email').value = '" . PASS . "'")

PageInst.Evaluate("document.getElementById('form-submit').click();")
}
catch   ; Handles the first error/exception raised by the block above.
    {
        MsgBox, Ada akun yang telah terhubung di browser!
        Msgbox, Mengalihkan akun...
        PageInst.Evaluate("document.getElementById('btn-batal').click();")
        PageInst.Evaluate("document.querySelectorAll('#user-profil > div > div > div.col-md-8 > div > div > div.col-md-7.col-sm-12 > div > a:nth-child(3)')[0].click();")
        PageInst.WaitForLoad()
        PageInst.Evaluate("document.getElementById('name').value = '" . NIM . "'")
        PageInst.Evaluate("document.getElementById('email').value = '" . PASS . "'")
        PageInst.Evaluate("document.getElementById('form-submit').click();")
     

    }
GuiClose: ; this label is executed either when the Gui is closed OR the MsgBox dismissed, due to fall-through.
ExitApp