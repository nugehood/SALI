Gui, Example:New
Gui, -Caption
Gui, Color, ECFF9E
Gui, Font, s12
Gui, Add, Button,, Option1

Space::
MouseGetPos, xpos, ypos
Gui, Example:Show, x%xpos% y%ypos%
Return

ExampleButtonOption1:
Gui, Submit
MsgBox "%A_GuiControl%" has been clicked
Return

ExampleGuiEscape:
Gui, Hide
Return

Gui, Add, Text, x17 y94 w50 h20 , NIM :
Gui, Add, Edit, x77 y94 w150 h20 , 
Gui, Add, Edit, x77 y144 w150 h20 , 
Gui, Add, Button, x107 y184 w90 h20 , LOGIN
Gui, Add, Text, x627 y134 w0 h0 , AUTO LOGIN SIMARI
Gui, Add, Text, x12 y289 w70 h20 , Made by Nuge
Gui, Add, Text, x17 y144 w50 h20 , PASS :
Gui, Add, GroupBox, x7 y4 w250 h310 , Simari Auto Login V 0.1.0
Gui, Add, Text, x112 y219 w70 h50 +Center, only work if not already logged in!

; Generated using SmartGUI Creator 4.0
Gui, Show, x418 y146 h338 w273, New GUI Window
Return

GuiClose:
ExitApp