#SingleInstance, force
#Include, Tables.ahk
#Include, lib\Chrome\Chrome.ahk ;https://github.com/G33kDude/Chrome.ahk/releases
#Include, lib\CSV-master\csv.ahk
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.

Gui, Add, Text, x22 y99 w50 h20 +Left, NIM :
Gui, Add, Edit, x82 y99 w150 h20 vNIM +Left,
Gui, Add, Edit, x82 y149 w150 h20 vPASS +Password  +Left,
Gui, Add, Button, x92 y179 w110 h20 , LOGIN
Gui, Add, Text, x632 y139 w-894 h-190 +Center, AUTO LOGIN SIMARI
Gui, Add, Link, x15 y299 w250 h20 +Center +Theme, Made by <a href="https://anugerah.netlify.app/">Nuge</a>
Gui, Add, Text, x22 y149 w50 h20 , PASS :
Gui, Add, GroupBox, x12 y9 w610 h310 , Simari Auto Login V 0.1.2
Gui, Font, S8 CDefault Bold, Verdana
Gui, Add, Button, x102 y209 w90 h20 +, SAVE
Gui, Add, Button, x252 y259 w90 h20 , REFRESH
Gui, Add, Button, x352 y259 w90 h20 , REMOVE
Gui, Add, ListView, x252 y29 w360 h220 gMyListView altsubmit, Nim


CSV_Load("data1.csv","data")
Rows:= CSV_TotalRows("data")
Result:=StrSplit(Result,",")

; Result[1]=Row, Result[2]=Column
;MsgBox % CSV_ReadCell("data",Result[1],Result[2])

Loop, % Rows
{
    LV_Add("" ,CSV_ReadCell("data", A_Index, 2))
}

LV_ModifyCol() 


Gui, Show, x359 y184 h331 w634, Simari Auto Login V 0.1.2
return

MyListView:
if (A_GuiEvent = "DoubleClick")
{
    SelectedRow := LV_GetNext()
    LV_GetText(RowText, A_EventInfo)  ; Get the text from the row's first field.
    Nimnya := CSV_ReadCell("data", A_EventInfo, 2)
    GuiControl,,NIM, %Nimnya% 
    Passwordnya := CSV_ReadCell("data", A_EventInfo, 3)
    GuiControl,,PASS, %Passwordnya%
    GuiControl, +Redraw, MyListView
    CSV_Load("data1.csv","data")
}
return

;Saving new Data
ButtonSAVE:
Gui Submit, nohide


newProfile =                                                     ; the function can also be used to quickly parse a string into a 2-dimensional array
(
    %Rows%,%NIM%,%PASS%
    )

CSV_AddRow("data", newProfile)
CSV_Save("data1.csv","data")
MsgBox, %NIM% berhasil disimpan!
;Run data1.csv
return

ButtonREFRESH:
Gui Submit, nohide
GuiControl, +Redraw, MyListView
LV_Delete()
CSV_Load("data1.csv","data")
Rows:= CSV_TotalRows("data")
Result:=StrSplit(Result,",")
Loop, % Rows
{
    LV_Add("" ,CSV_ReadCell("data", A_Index, 2))
}
return

ButtonREMOVE:
RowNumber := ""
RowNumber .= Format("{:i}", LV_GetNext())
if(RowNumber <= 1){
    MsgBox, Pilih data yang ingin dihapus!
    RowNumber := ""
    return
}
RowNumber .= ""
MsgBox, 4, , Delete %RowNumber%?,  ; 5-second timeout.
IfMsgBox, Yes
    CSV_DeleteRow("data", RowNumber)
    CSV_Save("data1.csv","data")
    CSV_Load("data1.csv","data")
    LV_Delete(RowNumber)
    NIM := ""
    PASS := ""
IfMsgBox, No
    Return ; i.e. Assume "No" if it timed out.
; Otherwise, continue:
; ...
return

ButtonLOGIN:
Gui Submit, nohide



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
return
ExitApp