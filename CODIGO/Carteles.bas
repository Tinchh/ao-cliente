Attribute VB_Name = "Carteles"
Option Explicit

Const XPosCartel = 100
Const YPosCartel = 100
Const MAXLONG = 30

Public Cartel As Boolean
Public Leyenda As String
Public LeyendaFormateada() As String
Public textura As Integer

Sub InitCartel(Ley As String, Grh As Integer)
If Not Cartel Then
    Leyenda = Ley
    textura = Grh
    Cartel = True
    ReDim LeyendaFormateada(0 To (Len(Ley) \ (MAXLONG \ 2)))
                
    Dim i As Integer, k As Integer, anti As Integer
    anti = 1
    k = 0
    Iterator = 0
    Call DarFormato(Leyenda, Iterator, k, anti)
    Iterator = 0
    Do While LeyendaFormateada(Iterator) <> "" And i < UBound(LeyendaFormateada)
        
       Iterator = Iterator + 1
    Loop
    ReDim Preserve LeyendaFormateada(0 To i)
Else
    Exit Sub
End If
End Sub

Private Function DarFormato(s As String, i As Integer, k As Integer, anti As Integer)
If anti + i <= Len(s) + 1 Then
    If ((i >= MAXLONG) And mid$(s, anti + i, 1) = " ") Or (anti + i = Len(s)) Then
        LeyendaFormateada(k) = mid$(s, anti, i + 1)
        k = k + 1
        anti = anti + i + 1
        Iterator = 0
    Else
        Iterator = Iterator + 1
    End If
    Call DarFormato(s, Iterator, k, anti)
End If
End Function

Sub DibujarCartel()
Dim X As Integer, Y As Integer
    If Not Cartel Then Exit Sub
    
    X = XPosCartel + 20
    Y = YPosCartel + 20
    
    Call DDrawTransGrhIndextoSurface(textura, XPosCartel, YPosCartel, 0, Normal_RGBList(), 0, False)
    Dim Counter As Integer, desp As Integer
    
    For Counter = 0 To UBound(LeyendaFormateada)
        'Fonts_Render_String LeyendaFormateada(Counter), X, Y + desp, -1, Settings.Engine_Font
        DrawText X, Y + desp, LeyendaFormateada(Counter), -1
        desp = desp + (frmMain.Font.Size) + 5
    Next
End Sub



