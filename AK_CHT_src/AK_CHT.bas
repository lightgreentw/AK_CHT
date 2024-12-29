_Title "Akalabeth T-Chinese Edition v0.5.1"
$ExeIcon:'.\ak_cht_256.ico'
_Icon

Const screenWidth = 640
Const screenHeight = 480
Const textCols = 80
Const textRows = 30
Const charWidth = screenWidth / textCols
Const charHeight = screenHeight / textRows

Type textLayer
    currentRow As Integer
    currentCol As Integer
    blockStartRow As Integer
    blockEndRow As Integer
    blockStartCol As Integer
    blockEndCol As Integer
    colorFore As Integer
    colorBack As Integer
End Type

Dim Shared CHTFileName As String
Dim Shared ENGFileName As String
Dim Shared isFullscreen As Integer
Dim Shared isStretch As Integer
Dim Shared isSmooth As Integer
Dim Shared isMap As Integer

Dim Shared currentLayer(3) As textLayer

Call LoadINIFile

If isStretch = -1 And isSmooth = -1 Then
    _AllowFullScreen _Stretch , _Smooth
ElseIf isStretch = -1 And isSmooth = 0 Then
    _AllowFullScreen _Stretch , _Off
ElseIf isStretch = 0 And isSmooth = -1 Then
    _AllowFullScreen _SquarePixels , _Smooth
Else
    _AllowFullScreen _SquarePixels , _Off
End If

If isFullscreen = -1 Then
    _FullScreen _SquarePixels
End If

Call TitleScreen
restart% = -1

0 On Error GoTo 4
1 If restart% = 0 Then End
Clear 'Clear all variable
'Create n virtual layers for display chinese
'0=Fullscreen Layer 1=Message Layer 2=Status Layer 3=Interactive Layer
For i = 0 To 3
    currentLayer(i).currentRow = 1
    currentLayer(i).currentCol = 1
    currentLayer(i).blockStartRow = 1
    currentLayer(i).blockEndRow = textRows
    currentLayer(i).blockStartCol = 1
    currentLayer(i).blockEndCol = textCols
    currentLayer(i).colorFore = 15
    currentLayer(i).colorBack = 0
Next

Call LoadINIFile

Screen 12: View Print: SetScrollBlock 0, 1, 30, 20, 60: SetColor 0, 15, 0: Cls: q$ = "": Dim pw(5): Dim c(5): Dim m$(10), ml%(10, 1), mz%(10, 1): Dim w$(5): Dim c$(5)

4 Rem PR# 0: IN# 0
5 Rem HIMEM: 49151
'7  CLEAR : GOSUB 60000
7 GoSub 60000
8 Randomize ln
9 le = 0
10 Screen 12: View Print: SetColor 0, 15, 0: SetScrollBlock 0, 1, 30, 20, 60: Cls: LocateC 0, 1, 1: PrintC 0, LangRes$("10_1"), -1
'Print " WELCOME TO AKALABETH, WORLD OF DOOM!"
20 Dim dn%(10, 10), te%(20, 20), xx%(10), yy%(10), pe%(10, 3), ld%(10, 5), cd%(10, 3), ft%(10, 5), la%(10, 3)
30 For x = 0 To 20: te%(x, 0) = 1: te%(0, x) = 1: te%(x, 20) = 1: te%(20, x) = 1: Next
35 SetScrollBlock 1, 25, 30, 1, 59: SetColor 1, 15, 0: LocateC 1, 25, 1: PrintC 1, LangRes$("35_1"), 0
40 For x = 1 To 19: For y = 1 To 19: te%(x, y) = Int(Rnd(1) ^ 5 * 4.5)
        41 If te%(x, y) = 3 And Rnd(1) > .5 Then te%(x, y) = 0
42 Next: PrintC 1, ".", 0: Next: Sleep 2: LocateC 1, 30, 1: PrintC 1, LangRes$("42_1"), -1
50 te%(Int(Rnd(1) * 19 + 1), Int(Rnd(1) * 19 + 1)) = 5: tx = Int(Rnd(1) * 19 + 1): ty = Int(Rnd(1) * 19 + 1): te%(tx, ty) = 3
51 xx%(0) = 139: yy%(0) = 79
52 For x = 2 To 20 Step 2: xx%(x / 2) = Int(Atn(1 / x) / Atn(1) * 140 + .5): yy%(x / 2) = Int(xx%(x / 2) * 4 / 7)
53 pe%(x / 2, 0) = 139 - xx%(x / 2): pe%(x / 2, 1) = 139 + xx%(x / 2): pe%(x / 2, 2) = 79 - yy%(x / 2): pe%(x / 2, 3) = 79 + yy%(x / 2): Next
54 pe%(0, 0) = 0: pe%(0, 1) = 279: pe%(0, 2) = 0: pe%(0, 3) = 159
55 For x = 1 To 10: cd%(x, 0) = 139 - xx%(x) / 3: cd%(x, 1) = 139 + xx%(x) / 3: cd%(x, 2) = 79 - yy%(x) * .7: cd%(x, 3) = 79 + yy%(x): Next: PrintC 0, ".", 0
56 For x = 0 To 9: ld%(x, 0) = (pe%(x, 0) * 2 + pe%(x + 1, 0)) / 3: ld%(x, 1) = (pe%(x, 0) + 2 * pe%(x + 1, 0)) / 3: w = ld%(x, 0) - pe%(x, 0)
    57 ld%(x, 2) = pe%(x, 2) + w * 4 / 7: ld%(x, 3) = pe%(x, 2) + 2 * w * 4 / 7: ld%(x, 4) = (pe%(x, 3) * 2 + pe%(x + 1, 3)) / 3: ld%(x, 5) = (pe%(x, 3) + 2 * pe%(x + 1, 3)) / 3
    58 ld%(x, 2) = ld%(x, 4) - (ld%(x, 4) - ld%(x, 2)) * .8: ld%(x, 3) = ld%(x, 5) - (ld%(x, 5) - ld%(x, 3)) * .8: If ld%(x, 3) = ld%(x, 4) Then ld%(x, 3) = ld%(x, 3) - 1
59 Next
60 For x = 0 To 9: ft%(x, 0) = 139 - xx%(x) / 3: ft%(x, 1) = 139 + xx%(x) / 3: ft%(x, 2) = 139 - xx%(x + 1) / 3: ft%(x, 3) = 139 + xx%(x + 1) / 3
61 ft%(x, 4) = 79 + (yy%(x) * 2 + yy%(x + 1)) / 3: ft%(x, 5) = 79 + (yy%(x) + 2 * yy%(x + 1)) / 3: Next
62 For x = 0 To 9: la%(x, 0) = (ft%(x, 0) * 2 + ft%(x, 1)) / 3: la%(x, 1) = (ft%(x, 0) + 2 * ft%(x, 1)) / 3: la%(x, 3) = ft%(x, 4): la%(x, 2) = 159 - la%(x, 3): Next
68 LocateC 0, 1, 1
69 LocateC 0, 1, 1
70 GoSub 100: GoTo 1000
90 For x = 0 To 9: For y = 0 To 5: PrintC 0, Str$(ld%(x, y)), 0: PrintC 0, " ", 0: Next: PrintC 0, "", -1: Next: Do: q$ = InKey$: Loop While q$ = ""
100 Screen 12: View Print 1 To 24: Cls 2: LocateC 0, 1, 1: View Print 25 To 30: SetColor 1, 15, 0: SetScrollBlock 1, 25, 30, 1, 59: Window Screen(0, 0)-(279, 199): For y = -1 To 1: For x = -1 To 1
        105 Line (138, 75)-(142, 75): Line (140, 73)-(140, 77)
        110 zz = te%(tx + x, ty + y): x1 = 65 + (x + 1) * 50: y1 = (y + 1) * 50
        120 If zz = 2 Then Line (x1 + 20, y1 + 20)-(x1 + 30, y1 + 20): Line -(x1 + 30, y1 + 30): Line -(x1 + 20, y1 + 30): Line -(x1 + 20, y1 + 20)
        130 If zz = 3 Then
            Line (x1 + 10, y1 + 10)-(x1 + 20, y1 + 10): Line -(x1 + 20, y1 + 40): Line -(x1 + 10, y1 + 40)
            Line -(x1 + 10, y1 + 30): Line -(x1 + 40, y1 + 30): Line -(x1 + 40, y1 + 40): Line -(x1 + 30, y1 + 40): Line -(x1 + 30, y1 + 10): Line -(x1 + 40, y1 + 10)
            Line -(x1 + 40, y1 + 20): Line -(x1 + 10, y1 + 20): Line -(x1 + 10, y1 + 10)
        End If
        140 If zz = 4 Then Line (x1 + 20, y1 + 20)-(x1 + 30, y1 + 30): Line (x1 + 20, y1 + 30)-(x1 + 30, y1 + 20)
        150 If zz = 5 Then
            Line (x1, y1)-(x1 + 50, y1): Line -(x1 + 50, y1 + 50): Line -(x1, y1 + 50): Line -(x1, y1)
            Line (x1 + 10, y1 + 10)-(x1 + 10, y1 + 40), 4: Line -(x1 + 40, y1 + 40), 4
            Line -(x1 + 40, y1 + 10), 4: Line -(x1 + 10, y1 + 10), 4: Line -(x1 + 40, y1 + 40), 12: Line (x1 + 10, y1 + 40)-(x1 + 40, y1 + 10), 12
        End If
        160 If zz = 1 Then
            Line (x1 + 10, y1 + 50)-(x1 + 10, y1 + 40): Line -(x1 + 20, y1 + 30): Line -(x1 + 40, y1 + 30)
            Line -(x1 + 40, y1 + 50): Line (x1, y1 + 10)-(x1 + 10, y1 + 10): Line (x1 + 50, y1 + 10)-(x1 + 40, y1 + 10)
            Line (x1, y1 + 40)-(x1 + 10, y1 + 40): Line (x1 + 40, y1 + 40)-(x1 + 50, y1 + 40)
        End If
        170 If zz = 1 Then Line (x1 + 10, y1)-(x1 + 10, y1 + 20): Line -(x1 + 20, y1 + 20): Line -(x1 + 20, y1 + 30): Line -(x1 + 30, y1 + 30): Line -(x1 + 30, y1 + 10): Line -(x1 + 40, y1 + 10): Line -(x1 + 40, y1)

190 Next: Next:
If isMap = -1 Then
    'Outdoor Map
    For ite = 0 To 20
        For jte = 0 To 20
            If te%(ite, jte) > 0 Then
                teco = 7
                If te%(ite, jte) = 5 Then teco = 14
                If te%(ite, jte) = 4 Then teco = 12
                If te%(ite, jte) = 3 Then teco = 2
                If te%(ite, jte) = 2 Then teco = 8
                Line (1 + 2 * ite, 1 + 2 * jte)-(2 + 2 * ite, 2 + 2 * jte), teco, BF
            End If

            If ite = tx And jte = ty Then
                Line (1 + 2 * ite, 1 + 2 * jte)-(2 + 2 * ite, 2 + 2 * jte), 11, BF
            End If
        Next
    Next
End If
Window: Return

200 Screen 12: View Print 1 To 24: Cls 2: View Print 25 To 30: SetColor 1, 15, 0: SetScrollBlock 1, 25, 30, 1, 59: Window Screen(0, 0)-(279, 199): di = 0: tb = 2

If isMap = -1 Then
    'Dungeons Map
    For idn = 0 To 10
        For jdn = 0 To 10
            If dn%(idn, jdn) > 0 Then
                dnco = 7
                If dn%(idn, jdn) = 5 Then dnco = 14
                If dn%(idn, jdn) = 4 Then dnco = 8
                If dn%(idn, jdn) = 7 Then dnco = 9
                If dn%(idn, jdn) = 8 Then dnco = 2
                If dn%(idn, jdn) = 6 Then dnco = 5
                If dn%(idn, jdn) >= 10 Then dnco = 12
                Line (223 + 5 * idn, 50 + 5 * jdn)-(225 + 5 * idn, 52 + 5 * jdn), dnco, BF
            End If

            If idn = px And jdn = py Then
                Line (223 + 5 * idn, 50 + 5 * jdn)-(225 + 5 * idn, 52 + 5 * jdn), 11, BF
            End If

        Next
    Next
End If
202 ce = dn%(px + dx * di, py + dy * di): le = dn%(px + dx * di + dy, py + dy * di - dx): ri = dn%(px + dx * di - dy, py + dy * di + dx)
204 l1 = pe%(di, 0): r1 = pe%(di, 1): t1 = pe%(di, 2): b1 = pe%(di, 3): l2 = pe%(di + 1, 0): r2 = pe%(di + 1, 1): t2 = pe%(di + 1, 2): b2 = pe%(di + 1, 3)
205 ce = Int(ce): le = Int(le): ri = Int(ri)
206 mc = Int(ce / 10): ce = ce - mc * 10: le = Int((le / 10 - Int(le / 10)) * 10 + .1): ri = Int((ri / 10 - Int(ri / 10)) * 10 + .1)
208 If di = 0 Then 216
210 If ce = 1 Or ce = 3 Or ce = 4 Then Line (l1, t1)-(r1, t1): Line -(r1, b1): Line -(l1, b1): Line -(l1, t1)
212 If ce = 1 Or ce = 3 Then en = 1: GoTo 260
214 If ce = 4 Then Line (cd%(di, 0), cd%(di, 3))-(cd%(di, 0), cd%(di, 2)): Line -(cd%(di, 1), cd%(di, 2)): Line -(cd%(di, 1), cd%(di, 3)): en = 1: GoTo 260
216 If le = 1 Or le = 3 Or le = 4 Then Line (l1, t1)-(l2, t2): Line (l1, b1)-(l2, b2)
218 If ri = 1 Or ri = 3 Or ri = 4 Then Line (r1, t1)-(r2, t2): Line (r1, b1)-(r2, b2)
220 If le = 4 And di > 0 Then Line (ld%(di, 0), ld%(di, 4))-(ld%(di, 0), ld%(di, 2)): Line -(ld%(di, 1), ld%(di, 3)): Line -(ld%(di, 1), ld%(di, 5))
222 If le = 4 And di = 0 Then Line (0, ld%(di, 2) - 3)-(ld%(di, 1), ld%(di, 3)): Line -(ld%(di, 1), ld%(di, 5))
224 If ri = 4 And di > 0 Then Line (279 - ld%(di, 0), ld%(di, 4))-(279 - ld%(di, 0), ld%(di, 2)): Line -(279 - ld%(di, 1), ld%(di, 3)): Line -(279 - ld%(di, 1), ld%(di, 5))
226 If ri = 4 And di = 0 Then Line (279, ld%(di, 2) - 3)-(279 - ld%(di, 1), ld%(di, 3)): Line -(279 - ld%(di, 1), ld%(di, 5))
228 If le = 3 Or le = 1 Or le = 4 Then 234
230 If di <> 0 Then Line (l1, t1)-(l1, b1)
232 Line (l1, t2)-(l2, t2): Line -(l2, b2): Line -(l1, b2)
234 If ri = 3 Or ri = 1 Or ri = 4 Then 240
236 If di <> 0 Then Line (r1, t1)-(r1, b1)
238 Line (r1, t2)-(r2, t2): Line -(r2, b2): Line -(r1, b2)
240 If ce = 7 Or ce = 9 Then Line (ft%(di, 0), ft%(di, 4))-(ft%(di, 2), ft%(di, 5)): Line -(ft%(di, 3), ft%(di, 5)): Line -(ft%(di, 1), ft%(di, 4)): Line -(ft%(di, 0), ft%(di, 4))
242 If ce = 8 Then Line (ft%(di, 0), 158 - ft%(di, 4))-(ft%(di, 2), 158 - ft%(di, 5)): Line -(ft%(di, 3), 158 - ft%(di, 5)): Line -(ft%(di, 1), 158 - ft%(di, 4)): Line -(ft%(di, 0), 158 - ft%(di, 4))
244 If ce = 7 Or ce = 8 Then ba = la%(di, 3): TP = la%(di, 2): LX = la%(di, 0): RX = la%(di, 1): Line (LX, ba)-(LX, TP): Line (RX, TP)-(RX, ba)
246 If ce = 7 Or ce = 8 Then y1 = (ba * 4 + TP) / 5: Y2 = (ba * 3 + TP * 2) / 5: Y3 = (ba * 2 + TP * 3) / 5: Y4 = (ba + TP * 4) / 5: Line (LX, y1)-(RX, y1): Line (LX, Y2)-(RX, Y2): Line (LX, Y3)-(RX, Y3): Line (LX, Y4)-(RX, Y4)
248 If di > 0 And ce = 5 Then Line (139 - 10 / di, pe%(di, 3))-(139 - 10 / di, pe%(di, 3) - 10 / di): Line -(139 + 10 / di, pe%(di, 3) - 10 / di): Line -(139 + 10 / di, pe%(di, 3)): Line -(139 - 10 / di, pe%(di, 3))
249 If ce = 5 And di > 0 Then View Print: SetScrollBlock 3, 1, 30, 1, 80: LocateC 3, 1, tb: SetColor 3, 15, 0: PrintC 3, LangRes$("249_1"), 0: tb = tb + 8
250 If di > 0 And ce = 5 Then Line (139 - 10 / di, pe%(di, 3) - 10 / di)-(139 - 5 / di, pe%(di, 3) - 15 / di): Line -(139 + 15 / di, pe%(di, 3) - 15 / di): Line -(139 + 15 / di, pe%(di, 3) - 5 / di): Line -(139 + 10 / di, pe%(di, 3))
252 If di > 0 And ce = 5 Then Line (139 + 10 / di, pe%(di, 3) - 10 / di)-(139 + 15 / di, pe%(di, 3) - 15 / di)
If in > 0 Then
    'Compass
    If dx = 1 And dy = 0 Then
        ScaleText 252, 164, LangRes$("252_1"), 15, 0, 1
    ElseIf dx = 0 And dy = 1 Then
        ScaleText 252, 164, LangRes$("252_2"), 15, 0, 1
    ElseIf dx = 0 And dy = -1 Then
        ScaleText 252, 164, LangRes$("252_3"), 15, 0, 1
    ElseIf dx = -1 And dy = 0 Then
        ScaleText 252, 164, LangRes$("252_4"), 15, 0, 1
    End If
End If

260 If mc < 1 Then 490
265 b = 79 + yy%(di): C = 139
266 If mc = 8 Then View Print: SetScrollBlock 3, 1, 30, 1, 80: LocateC 3, 1, tb: SetColor 3, 15, 0: PrintC 3, LangRes$("266_1"), 0: tb = tb + 8: PrintC 3, "", -1: GoTo 269: Rem call
267 View Print: SetScrollBlock 3, 1, 30, 1, 80: LocateC 3, 1, tb: SetColor 3, 15, 0: PrintC 3, m$(mc), 0: tb = tb + Len(m$(mc)) + 2: PrintC 3, "", -1: Rem call
269 If di = 0 Then 490
270 On mc GOTO 300, 310, 320, 330, 340, 350, 360, 370, 380, 390
'"SKELETON","THIEF","GIANT RAT","ORC","VIPER","CARRION CRAWLER","GREMLIN","MIMIC","DAEMON","BALROG"
280 GoTo 490
300 Line (C - 23 / di, b)-(C - 15 / di, b): Line -(C - 15 / di, b - 15 / di): Line -(C - 8 / di, b - 30 / di): Line -(C + 8 / di, b - 30 / di): Line -(C + 15 / di, b - 15 / di): Line -(C + 15 / di, b): Line -(C + 23 / di, b)
301 Line (C, b - 26 / di)-(C, b - 65 / di): Line (C - 2 / di + .499, b - 38 / di)-(C + 2 / di + .499, b - 38 / di)
Line (C - 3 / di + .499, b - 45 / di)-(C + 3 / di + .499, b - 45 / di): Line (C - 5 / di + .499, b - 53 / di)-(C + 5 / di + .499, b - 53 / di)
302 Line (C - 23 / di, b - 56 / di)-(C - 30 / di, b - 53 / di): Line -(C - 23 / di, b - 45 / di): Line -(C - 23 / di, b - 53 / di): Line -(C - 8 / di, b - 38 / di)
303 Line (C - 15 / di, b - 45 / di)-(C - 8 / di, b - 60 / di): Line -(C + 8 / di, b - 60 / di): Line -(C + 15 / di, b - 45 / di)
Line -(C + 15 / di, b - 42 / di): Line -(C + 15 / di, b - 57 / di): Line (C + 12 / di, b - 45 / di)-(C + 20 / di, b - 45 / di)
304 Line (C, b - 75 / di)-(C - 5 / di + .499, b - 80 / di): Line -(C - 8 / di, b - 75 / di): Line -(C - 5 / di + .499, b - 65 / di)
Line -(C + 5 / di + .499, b - 65 / di): Line -(C + 5 / di + .499, b - 68 / di): Line -(C - 5 / di + .499, b - 68 / di): Line -(C - 5 / di + .499, b - 65 / di)
305 Line -(C + 5 / di + .499, b - 65 / di): Line -(C + 8 / di, b - 75 / di): Line -(C + 5 / di + .499, b - 80 / di): Line -(C - 5 / di + .499, b - 80 / di): PSet (C - 5 / di + .499, b - 72 / di): PSet (C + 5 / di + .499, b - 72 / di)
309 GoTo 490
310 Line (C, b - 56 / di)-(C, b - 8 / di): Line -(C + 10 / di, b): Line -(C + 30 / di, b): Line -(C + 30 / di, b - 45 / di): Line -(C + 10 / di, b - 64 / di): Line -(C, b - 56 / di)
311 Line -(C - 10 / di, b - 64 / di): Line -(C - 30 / di, b - 45 / di): Line -(C - 30 / di, b): Line -(C - 10 / di, b): Line -(C, b - 8 / di)
312 Line (C - 10 / di, b - 64 / di)-(C - 10 / di, b - 75 / di): Line -(C, b - 83 / di)
Line -(C + 10 / di, b - 75 / di): Line -(C, b - 79 / di): Line -(C - 10 / di, b - 75 / di): Line -(C, b - 60 / di)
Line -(C + 10 / di, b - 75 / di): Line -(C + 10 / di, b - 64 / di)
319 GoTo 490
320 Line (C + 5 / di, b - 30 / di)-(C, b - 25 / di): Line -(C - 5 / di, b - 30 / di): Line -(C - 15 / di, b - 5 / di): Line -(C - 10 / di, b): Line -(C + 10 / di, b): Line -(C + 15 / di, b - 5 / di)
321 Line -(C + 20 / di, b - 5 / di): Line -(C + 10 / di, b): Line -(C + 15 / di, b - 5 / di)
Line -(C + 5 / di, b - 30 / di): Line -(C + 10 / di, b - 40 / di): Line -(C + 3 / di + .499, b - 35 / di)
Line -(C - 3 / di + .499, b - 35 / di): Line -(C - 10 / di, b - 40 / di): Line -(C - 5 / di, b - 30 / di)
322 Line (C - 5 / di, b - 33 / di)-(C - 3 / di + .499, b - 30 / di): Line (C + 5 / di, b - 33 / di)-(C + 3 / di + .499, b - 30 / di): Line (C - 5 / di, b - 20 / di)-(C - 5 / di, b - 15 / di)
323 Line (C + 5 / di, b - 20 / di)-(C + 5 / di, b - 15 / di): Line (C - 7 / di, b - 20 / di)-(C - 7 / di, b - 15 / di): Line (C + 7 / di, b - 20 / di)-(C + 7 / di, b - 15 / di)
329 GoTo 490
330 Line (C, b)-(C - 15 / di, b): Line -(C - 8 / di, b - 8 / di): Line -(C - 8 / di, b - 15 / di): Line -(C - 15 / di, b - 23 / di): Line -(C - 15 / di, b - 15 / di): Line -(C - 23 / di, b - 23 / di)
331 Line -(C - 23 / di, b - 45 / di): Line -(C - 15 / di, b - 53 / di): Line -(C - 8 / di, b - 53 / di): Line -(C - 15 / di, b - 68 / di): Line -(C - 8 / di, b - 75 / di): Line -(C, b - 75 / di)
332 Line (C, b)-(C + 15 / di, b): Line -(C + 8 / di, b - 8 / di): Line -(C + 8 / di, b - 15 / di): Line -(C + 15 / di, b - 23 / di): Line -(C + 15 / di, b - 15 / di): Line -(C + 23 / di, b - 23 / di)
333 Line -(C + 23 / di, b - 45 / di): Line -(C + 15 / di, b - 53 / di): Line -(C + 8 / di, b - 53 / di): Line -(C + 15 / di, b - 68 / di): Line -(C + 8 / di, b - 75 / di): Line -(C, b - 75 / di)
334 Line (C - 15 / di, b - 68 / di)-(C + 15 / di, b - 68 / di): Line (C - 8 / di, b - 53 / di)-(C + 8 / di, b - 53 / di): Line (C - 23 / di, b - 15 / di)-(C + 8 / di, b - 45 / di)
335 Line (C - 8 / di, b - 68 / di)-(C, b - 60 / di): Line -(C + 8 / di, b - 68 / di): Line -(C + 8 / di, b - 60 / di): Line -(C - 8 / di, b - 60 / di): Line -(C - 8 / di, b - 68 / di)
336 Line (C, b - 38 / di)-(C - 8 / di, b - 38 / di): Line -(C + 8 / di, b - 53 / di): Line -(C + 8 / di, b - 45 / di): Line -(C + 15 / di, b - 45 / di): Line -(C, b - 30 / di): Line -(C, b - 38 / di)
339 GoTo 490
340 Line (C - 10 / di, b - 15 / di)-(C - 10 / di, b - 30 / di): Line -(C - 15 / di, b - 20 / di): Line -(C - 15 / di, b - 15 / di): Line -(C - 15 / di, b): Line -(C + 15 / di, b): Line -(C + 15 / di, b - 15 / di): Line -(C - 15 / di, b - 15 / di)
341 Line (C - 15 / di, b - 10 / di)-(C + 15 / di, b - 10 / di): Line (C - 15 / di, b - 5 / di)-(C + 15 / di, b - 5 / di)
342 Line (C, b - 15 / di)-(C - 5 / di, b - 20 / di): Line -(C - 5 / di, b - 35 / di): Line -(C + 5 / di, b - 35 / di): Line -(C + 5 / di, b - 20 / di): Line -(C + 10 / di, b - 15 / di)
343 Line (C - 5 / di, b - 20 / di)-(C + 5 / di, b - 20 / di): Line (C - 5 / di, b - 25 / di)-(C + 5 / di, b - 25 / di): Line (C - 5 / di, b - 30 / di)-(C + 5 / di, b - 30 / di)
344 Line (C - 10 / di, b - 35 / di)-(C - 10 / di, b - 40 / di): Line -(C - 5 / di, b - 45 / di): Line -(C + 5 / di, b - 45 / di): Line -(C + 10 / di, b - 40 / di): Line -(C + 10 / di, b - 35 / di)
345 Line (C - 10 / di, b - 40 / di)-(C, b - 45 / di): Line -(C + 10 / di, b - 40 / di)
346 Line (C - 5 / di, b - 40 / di)-(C + 5 / di, b - 40 / di): Line -(C + 15 / di, b - 30 / di): Line -(C, b - 40 / di): Line -(C - 15 / di, b - 30 / di): Line -(C - 5 / di + .499, b - 40 / di)
349 GoTo 490
350 Line (C - 20 / di, 79 - yy%(di))-(C - 20 / di, b - 88 / di): Line -(C - 10 / di, b - 83 / di): Line -(C + 10 / di, b - 83 / di): Line -(C + 20 / di, b - 88 / di): Line -(C + 20 / di, 79 - yy%(di)): Line -(C - 20 / di, 79 - yy%(di))
351 Line (C - 20 / di, b - 88 / di)-(C - 30 / di, b - 83 / di): Line -(C - 30 / di, b - 78 / di): Line (C + 20 / di, b - 88 / di)-(C + 30 / di, b - 83 / di): Line -(C + 40 / di, b - 83 / di)
352 Line (C - 15 / di, b - 86 / di)-(C - 20 / di, b - 83 / di): Line -(C - 20 / di, b - 78 / di): Line -(C - 30 / di, b - 73 / di): Line -(C - 30 / di, b - 68 / di): Line -(C - 20 / di, b - 63 / di)
353 Line (C - 10 / di, b - 83 / di)-(C - 10 / di, b - 58 / di): Line -(C, b - 50 / di): Line (C + 10 / di, b - 83 / di)-(C + 10 / di, b - 78 / di): Line -(C + 20 / di, b - 73 / di): Line -(C + 20 / di, b - 40 / di)
354 Line (C + 15 / di, b - 85 / di)-(C + 20 / di, b - 78 / di): Line -(C + 30 / di, b - 76 / di): Line -(C + 30 / di, b - 60 / di)
355 Line (C, b - 83 / di)-(C, b - 73 / di): Line -(C + 10 / di, b - 68 / di): Line -(C + 10 / di, b - 63 / di): Line -(C, b - 58 / di)
359 GoTo 490
360 Line (C + 5 / di + .499, b - 10 / di)-(C - 5 / di + .499, b - 10 / di): Line -(C, b - 15 / di): Line -(C + 10 / di, b - 20 / di): Line -(C + 5 / di + .499, b - 15 / di): Line -(C + 5 / di + .499, b - 10 / di)
361 Line -(C + 7 / di + .499, b - 6 / di): Line -(C + 5 / di + .499, b - 3 / di): Line -(C - 5 / di + .499, b - 3 / di): Line -(C - 7 / di + .499, b - 6 / di): Line -(C - 5 / di + .499, b - 10 / di)
362 Line (C + 2 / di + .499, b - 3 / di)-(C + 5 / di + .499, b): Line -(C + 8 / di, b)
Line (C - 2 / di + .499, b - 3 / di)-(C - 5 / di + .499, b): Line -(C - 8 / di, b): PSet (C + 3 / di + .499, b - 8 / di)
PSet (C - 3 / di + .499, b - 8 / di): Line (C + 3 / di + .499, b - 5 / di)-(C - 3 / di + .499, b - 5 / di)
363 GoTo 490
370 Line (139 - 10 / di, pe%(di, 3))-(139 - 10 / di, pe%(di, 3) - 10 / di): Line -(139 + 10 / di, pe%(di, 3) - 10 / di): Line -(139 + 10 / di, pe%(di, 3)): Line -(139 - 10 / di, pe%(di, 3))
371 Line (139 - 10 / di, pe%(di, 3) - 10 / di)-(139 - 5 / di, pe%(di, 3) - 15 / di): Line -(139 + 15 / di, pe%(di, 3) - 15 / di): Line -(139 + 15 / di, pe%(di, 3) - 5 / di): Line -(139 + 10 / di, pe%(di, 3))
372 Line (139 + 10 / di, pe%(di, 3) - 10 / di)-(139 + 15 / di, pe%(di, 3) - 15 / di)
373 GoTo 490
380 Line (C - 14 / di, b - 46 / di)-(C - 12 / di, b - 37 / di): Line -(C - 20 / di, b - 32 / di): Line -(C - 30 / di, b - 32 / di)
Line -(C - 22 / di, b - 24 / di): Line -(C - 40 / di, b - 17 / di): Line -(C - 40 / di, b - 7 / di): Line -(C - 38 / di, b - 5 / di)
Line -(C - 40 / di, b - 3 / di): Line -(C - 40 / di, b)
381 Line -(C - 36 / di, b): Line -(C - 34 / di, b - 2 / di): Line -(C - 32 / di, b): Line -(C - 28 / di, b)
Line -(C - 28 / di, b - 3 / di): Line -(C - 30 / di, b - 5 / di): Line -(C - 28 / di, b - 7 / di)
Line -(C - 28 / di, b - 15 / di): Line -(C, b - 27 / di)
382 Line (C + 14 / di, b - 46 / di)-(C + 12 / di, b - 37 / di): Line -(C + 20 / di, b - 32 / di)
Line -(C + 30 / di, b - 32 / di): Line -(C + 22 / di, b - 24 / di): Line -(C + 40 / di, b - 17 / di)
Line -(C + 40 / di, b - 7 / di): Line -(C + 38 / di, b - 5 / di): Line -(C + 40 / di, b - 3 / di): Line -(C + 40 / di, b)
383 Line -(C + 36 / di, b): Line -(C + 34 / di, b - 2 / di): Line -(C + 32 / di, b): Line -(C + 28 / di, b)
Line -(C + 28 / di, b - 3 / di): Line -(C + 30 / di, b - 5 / di): Line -(C + 28 / di, b - 7 / di)
Line -(C + 28 / di, b - 15 / di): Line -(C, b - 27 / di)
384 Line (C + 6 / di, b - 48 / di)-(C + 38 / di, b - 41 / di): Line -(C + 40 / di, b - 42 / di): Line -(C + 18 / di, b - 56 / di)
Line -(C + 12 / di, b - 56 / di): Line -(C + 10 / di, b - 57 / di): Line -(C + 8 / di, b - 56 / di): Line -(C - 8 / di, b - 56 / di)
Line -(C - 10 / di, b - 58 / di): Line -(C + 14 / di, b - 58 / di): Line -(C + 16 / di, b - 59 / di)
385 Line -(C + 8 / di, b - 63 / di): Line -(C + 6 / di, b - 63 / di): Line -(C + 2 / di + .499, b - 70 / di)
Line -(C + 2 / di + .499, b - 63 / di): Line -(C - 2 / di + .499, b - 63 / di): Line -(C - 2 / di + .499, b - 70 / di)
Line -(C - 6 / di, b - 63 / di): Line -(C - 8 / di, b - 63 / di): Line -(C - 16 / di, b - 59 / di): Line -(C - 14 / di, b - 58 / di)
386 Line -(C - 10 / di, b - 57 / di): Line -(C - 12 / di, b - 56 / di): Line -(C - 18 / di, b - 56 / di): Line -(C - 36 / di, b - 47 / di)
Line -(C - 36 / di, b - 39 / di): Line -(C - 28 / di, b - 41 / di): Line -(C - 28 / di, b - 46 / di): Line -(C - 20 / di, b - 50 / di)
Line -(C - 18 / di, b - 50 / di): Line -(C - 14 / di, b - 46 / di)
387 GoTo 3087
390 Line (C + 6 / di, b - 60 / di)-(C + 30 / di, b - 90 / di): Line -(C + 60 / di, b - 30 / di): Line -(C + 60 / di, b - 10 / di): Line -(C + 30 / di, b - 40 / di): Line -(C + 15 / di, b - 40 / di)
391 Line (C - 6 / di, b - 60 / di)-(C - 30 / di, b - 90 / di): Line -(C - 60 / di, b - 30 / di): Line -(C - 60 / di, b - 10 / di): Line -(C - 30 / di, b - 40 / di): Line -(C - 15 / di, b - 40 / di)
392 Line (C, b - 25 / di)-(C + 6 / di, b - 25 / di): Line -(C + 10 / di, b - 20 / di): Line -(C + 12 / di, b - 10 / di): Line -(C + 10 / di, b - 6 / di)
Line -(C + 10 / di, b): Line -(C + 14 / di, b): Line -(C + 15 / di, b - 5 / di): Line -(C + 16 / di, b): Line -(C + 20 / di, b)
393 Line -(C + 20 / di, b - 6 / di): Line -(C + 18 / di, b - 10 / di): Line -(C + 18 / di, b - 20 / di): Line -(C + 15 / di, b - 30 / di): Line -(C + 15 / di, b - 45 / di): Line -(C + 40 / di, b - 60 / di): Line -(C + 40 / di, b - 70 / di)
394 Line -(C + 10 / di, b - 55 / di): Line -(C + 6 / di, b - 60 / di): Line -(C + 10 / di, b - 74 / di): Line -(C + 6 / di, b - 80 / di)
Line -(C + 4 / di + .499, b - 80 / di): Line -(C + 3 / di + .499, b - 82 / di): Line -(C + 2 / di + .499, b - 80 / di): Line -(C, b - 80 / di)
395 Line (C, b - 25 / di)-(C - 6 / di, b - 25 / di): Line -(C - 10 / di, b - 20 / di): Line -(C - 12 / di, b - 10 / di): Line -(C - 10 / di, b - 6 / di)
Line -(C - 10 / di, b): Line -(C - 14 / di, b): Line -(C - 15 / di, b - 5 / di): Line -(C - 16 / di, b): Line -(C - 20 / di, b)
396 Line -(C - 20 / di, b - 6 / di): Line -(C - 18 / di, b - 10 / di): Line -(C - 18 / di, b - 20 / di): Line -(C - 15 / di, b - 30 / di): Line -(C - 15 / di, b - 45 / di): Line -(C - 40 / di, b - 60 / di): Line -(C - 40 / di, b - 70 / di)
397 Line -(C - 10 / di, b - 55 / di): Line -(C - 6 / di, b - 60 / di): Line -(C - 10 / di, b - 74 / di): Line -(C - 6 / di, b - 80 / di)
Line -(C - 4 / di + .499, b - 80 / di): Line -(C - 3 / di + .499, b - 82 / di): Line -(C - 2 / di + .499, b - 80 / di): Line -(C, b - 80 / di)
398 Line (C - 6 / di, b - 25 / di)-(C, b - 6 / di): Line -(C + 10 / di, b): Line -(C + 4 / di + .499, b - 8 / di): Line -(C + 6 / di, b - 25 / di)
Line (C - 40 / di, b - 64 / di)-(C - 40 / di, b - 90 / di): Line -(C - 52 / di, b - 80 / di): Line -(C - 52 / di, b - 40 / di)
399 Line (C + 40 / di, b - 86 / di)-(C + 38 / di, b - 92 / di): Line -(C + 42 / di, b - 92 / di): Line -(C + 40 / di, b - 86 / di): Line -(C + 40 / di, b - 50 / di)
400 Line (C + 4 / di + .499, b - 70 / di)-(C + 6 / di, b - 74 / di): Line (C - 4 / di + .499, b - 70 / di)-(C - 6 / di, b - 74 / di): Line (C, b - 64 / di)-(C, b - 60 / di): GoTo 490
490 If en = 1 Then en = 0: Window: Return
491 di = di + 1: GoTo 202
500 Randomize -Abs(ln) - tx * 10 - ty * 1000 + in * 31.4
501 For x = 1 To 9: For y = 1 To 9: dn%(x, y) = 0: Next: Next
510 For x = 0 To 10: dn%(x, 0) = 1: dn%(x, 10) = 1: dn%(0, x) = 1: dn%(10, x) = 1: Next
520 For x = 2 To 8 Step 2: For y = 1 To 9: dn%(x, y) = 1: Next: Next
530 For x = 2 To 8 Step 2: For y = 1 To 9 Step 2
        540 If Rnd(1) > .95 Then dn%(x, y) = 2
        541 If Rnd(1) > .95 Then dn%(y, x) = 2
        542 If Rnd(1) > .6 Then dn%(y, x) = 3
        543 If Rnd(1) > .6 Then dn%(x, y) = 3
        544 If Rnd(1) > .6 Then dn%(x, y) = 4
        545 If Rnd(1) > .6 Then dn%(y, x) = 4
        546 If Rnd(1) > .97 Then dn%(y, x) = 9
        547 If Rnd(1) > .97 Then dn%(x, y) = 9
        548 If Rnd(1) > .94 Then dn%(x, y) = 5
        549 If Rnd(1) > .94 Then dn%(y, x) = 5
568 Next: Next
569 dn%(2, 1) = 0: If in / 2 = Int(in / 2) Then dn%(7, 3) = 7: dn%(3, 7) = 8
570 If in / 2 <> Int(in / 2) Then dn%(7, 3) = 8: dn%(3, 7) = 7
580 If in = 1 Then dn%(1, 1) = 8: dn%(7, 3) = 0
585 GoSub 2000
590 Return
1000 Do: Loop Until InKey$ = "": View Print 25 To 30: SetColor 1, 15, 0: SetScrollBlock 1, 25, 30, 1, 59: LocateC 1, 30, 1: PrintC 1, LangRes$("1000_1"), 0: LocateC 1, CsrLin, 10
SetScrollBlock 2, 25, 30, 60, 80: LocateC 2, 25, 1

1001 x$ = UCase$(InKey$): If x$ = "" Then 1001
1002 If Asc(x$) = 0 Then xq = Asc(Mid$(x$, 2)) Else xq = 0
1010 Rem poke -16368, 0
1030 If xq = 72 Then On Sgn(in) + 1 GOTO 1100, 1150
1040 If xq = 77 Then On Sgn(in) + 1 GOTO 1200, 1250
1050 If xq = 75 Then On Sgn(in) + 1 GOTO 1300, 1350
1060 If xq = 80 Then On Sgn(in) + 1 GOTO 1400, 1450
1070 If x$ = "X" Or x$ = Chr$(13) Or x$ = "E" Or x$ = "K" Or x$ = "D" Then On Sgn(in) + 1 GOTO 1500, 1550
1080 If x$ = "A" Or x$ = "U" Or x$ = "C" Then On Sgn(in) + 1 GOTO 1600, 1650
1081 If x$ = " " Then PrintC 1, LangRes$("1081_1"), -1: GoTo 1090
1085 If x$ = "I" Or x$ = "Z" Or x$ = "S" Then 1700
1086 If x$ = "P" Then If pa = 1 Then pa = 0: PrintC 1, LangRes$("1086_1"), -1: GoTo 1000
1087 If x$ = "P" Then If pa = 0 Then pa = 1: PrintC 1, LangRes$("1087_1"), -1: GoTo 1000
1089 PrintC 1, LangRes$("1089_1"), -1: GoTo 1000
1090 pw(0) = pw(0) - 1 + Sgn(in) * .9: If pw(0) < 0 Then c(0) = 0: PrintC 1, "", -1: PrintC 1, LangRes$("1090_1"), -1: GoTo 1093
1091 SetColor 2, 15, 0: For jj = 0 To 2: LocateC 2, 25 + jj, 1: PrintC 2, Space$(19), 0: Next: LocateC 2, 25, 1: PrintC 2, LangRes$("1091_1"), 0: PrintC 2, LTrim$(Str$(pw(0))), 0: LocateC 2, 26, 1: PrintC 2, LangRes$("1091_2"), 0: PrintC 2, LTrim$(Str$(c(0))), 0: LocateC 2, 27, 1: PrintC 2, LangRes$("1091_3"), 0: PrintC 2, LTrim$(Str$(c(5))), 0: Rem call -868
SetColor 2, 0, 15: LocateC 2, 29, 1: PrintC 2, LangRes$("1091_5"), -1: LocateC 2, 30, 1: PrintC 2, LangRes$("1091_6"), 0
If in > 0 Then
    LocateC 2, 28, 1: PrintC 2, LangRes$("1091_4"), 0: PrintC 2, LTrim$(Str$(in)), -1
End If

1092 pw(0) = Int(pw(0) * 10) / 10
1093 If c(0) <= 0 Then Sleep 3: GoTo 6000
1095 If in > 0 Then GoSub 4000: If c(0) <= 0 Then 1093
1096 SetColor 2, 15, 0: For jj = 0 To 3: LocateC 2, 25 + jj, 1: PrintC 2, Space$(19), 0: Next: LocateC 2, 25, 1: PrintC 2, LangRes$("1096_1"), 0: PrintC 2, LTrim$(Str$(pw(0))), 0: LocateC 2, 26, 1: PrintC 2, LangRes$("1096_2"), 0: PrintC 2, LTrim$(Str$(c(0))), 0: LocateC 2, 27, 1: PrintC 2, LangRes$("1096_3"), 0: PrintC 2, LTrim$(Str$(c(5))), 0
SetColor 2, 0, 15: LocateC 2, 29, 1: PrintC 2, LangRes$("1096_5"), -1: LocateC 2, 30, 1: PrintC 2, LangRes$("1096_6"), 0
If in > 0 Then
    LocateC 2, 28, 1: PrintC 2, LangRes$("1091_4"), 0: PrintC 2, LTrim$(Str$(in)), -1
End If

1097 If in = 0 Then GoSub 100: GoTo 1000
1098 If in > 0 Then GoSub 200: GoTo 1000
1100 PrintC 1, LangRes$("1100_1"), -1: If te%(tx, ty - 1) = 1 Then PrintC 1, LangRes$("1100_2"), -1: GoTo 1090
1110 ty = ty - 1: GoTo 1090
1150 If dn%(px + dx, py + dy) <> 1 And dn%(px + dx, py + dy) < 10 Then px = px + dx: py = py + dy
1155 PrintC 1, LangRes$("1155_1"), -1
1160 If dn%(px, py) = 2 Then PrintC 1, LangRes$("1160_1"), -1: c(0) = c(0) - Int(Rnd(1) * in + 3): MR = 1: in = in + 1: PrintC 1, LangRes$("1160_2"), 0: PrintC 1, Str$(in), -1: Sleep 2: GoSub 500: GoTo 1090
1165 z = 0
1170 If dn%(px, py) = 5 Then dn%(px, py) = 0: PrintC 1, LangRes$("1170_1"), 0: z = Int(Rnd(1) * 5 * in + in): PrintC 1, Str$(z), 0: PrintC 1, LangRes$("1170_2"), -1: c(5) = c(5) + z
1175 If z > 0 Then z = Int(Rnd(1) * 6): PrintC 1, LangRes$("1175_1"), 0: PrintC 1, w$(z), -1: pw(z) = pw(z) + 1: Sleep 1: GoTo 1090
1190 GoTo 1090
1200 PrintC 1, LangRes$("1200_1"), -1: If te%(tx + 1, ty) = 1 Then PrintC 1, LangRes$("1200_2"), -1: GoTo 1090
1210 tx = tx + 1: GoTo 1090
1250 PrintC 1, LangRes$("1250_1"), -1
1255 If dx <> 0 Then dy = dx: dx = 0: GoTo 1090
1260 dx = -dy: dy = 0: GoTo 1090
1300 PrintC 1, LangRes$("1300_1"), -1: If te%(tx - 1, ty) = 1 Then PrintC 1, LangRes$("1300_2"), -1: GoTo 1090
1310 tx = tx - 1: GoTo 1090
1350 PrintC 1, LangRes$("1350_1"), -1
1355 If dx <> 0 Then dy = -dx: dx = 0: GoTo 1090
1360 dx = dy: dy = 0: GoTo 1090
1400 PrintC 1, LangRes$("1400_1"), -1: If te%(tx, ty + 1) = 1 Then PrintC 1, LangRes$("1400_2"), -1: GoTo 1090
1410 ty = ty + 1: GoTo 1090
1450 PrintC 1, LangRes$("1450_1"), -1: dx = -dx: dy = -dy: GoTo 1090
1500 If te%(tx, ty) = 3 Then GoSub 60080: GoSub 60200: Cls: GoTo 1090
1510 If te%(tx, ty) = 4 And in = 0 Then PrintC 1, LangRes$("1510_1"), -1: PrintC 1, LangRes$("1510_2"), -1: Sleep 1: in = 1: GoSub 500: dx = 1: dy = 0: px = 1: py = 1: Cls: GoTo 1090
1515 If te%(tx, ty) = 5 Then 7000
1520 PrintC 1, LangRes$("1520_1"), -1: GoTo 1000
1550 If dn%(px, py) <> 7 And dn%(px, py) <> 9 Then 1580
1555 PrintC 1, LangRes$("1555_1"), 0: PrintC 1, Str$(in + 1), -1
1560 in = in + 1: GoSub 500: MR = 1: GoTo 1090
1580 If dn%(px, py) <> 8 Then PrintC 1, LangRes$("1580_1"), -1: GoTo 1090
1581 If in = 1 Then PrintC 1, LangRes$("1581_1"), -1: in = 0: GoTo 1586
1584 PrintC 1, LangRes$("1584_1"), 0: PrintC 1, Str$(in - 1), -1
1585 in = in - 1: GoSub 500: MR = 1
1586 If in = 0 Then PrintC 1, LangRes$("1586_1"), 0: PrintC 1, Str$(lk), 0: PrintC 1, LangRes$("1586_2"), -1: Sleep 2: c(0) = c(0) + lk: lk = 0
1587 Cls: GoTo 1090
1600 GoTo 1090
1650 mn = 0: da = 0: PrintC 1, LangRes$("1650_1"), -1: PrintC 1, LangRes$("1650_2"), -1: Do: q$ = UCase$(InKey$): Loop While q$ = ""
1651 If q$ = "R" Then da = 10: PrintC 1, LangRes$("1651_1"), 0: If pw(1) < 1 Then PrintC 1, LangRes$("1651_2"), -1: GoTo 1650
1652 If q$ = "A" Then da = 5: PrintC 1, LangRes$("1652_1"), 0: If pw(2) < 1 Then PrintC 1, LangRes$("1652_2"), -1: GoTo 1650
1653 If q$ = "S" Then da = 1: PrintC 1, LangRes$("1653_1"), 0: If pw(3) < 1 Then PrintC 1, LangRes$("1653_2"), -1: GoTo 1650
1654 If q$ = "B" Then da = 4: PrintC 1, LangRes$("1654_1"), 0: If pw(4) < 1 Then PrintC 1, LangRes$("1654_2"), -1: GoTo 1650
1655 If q$ = "M" Then PrintC 1, LangRes$("1655_1"), 0: GoTo 1680
1656 If q$ = "B" And pt$ = "m" Then PrintC 1, LangRes$("1656_1"), -1: GoTo 1650
1657 If q$ = "R" And pt$ = "m" Then PrintC 1, LangRes$("1657_1"), -1: GoTo 1650
1659 If da = 0 Then PrintC 1, LangRes$("1659_1"), -1
1660 If da = 5 Or da = 4 Then 1670
1661 mn = dn%(px + dx, py + dy) / 10: mn = Int(mn)
1662 If mn < 1 Or c(2) - Rnd(1) * 25 < mn + in Then PrintC 1, LangRes$("1662_1"), -1: GoTo 1668
1663 PrintC 1, LangRes$("1663_1"), -1: da = (Rnd(1) * da + c(1) / 5): mz%(mn, 1) = Int(mz%(mn, 1) - da)
1664 PrintC 1, m$(mn), 0: PrintC 1, LangRes$("1664_1"), 0: PrintC 1, Str$(mz%(mn, 1)), -1
1665 If mz%(mn, 1) < 1 Then PrintC 1, LangRes$("1665_1"), 0: PrintC 1, m$(mn), -1: PrintC 1, LangRes$("1665_2"), 0: da = Int(mn + in): PrintC 1, Str$(da), 0: PrintC 1, LangRes$("1665_3"), -1
1666 If mz%(mn, 1) < 1 Then c(5) = Int(c(5) + da): dn%(ml%(mn, 0), ml%(mn, 1)) = dn%(ml%(mn, 0), ml%(mn, 1)) - 10 * mn: mz%(mn, 0) = 0
1667 lk = lk + Int(mn * in / 2): If mn = ta Then ta = -ta
1668 If pa = 1 Then PrintC 1, LangRes$("1668_1"), 0: Input q$
1669 Sleep 1: GoTo 1090
1670 If da = 5 Then PrintC 1, LangRes$("1670_1"), 0: Do: q$ = UCase$(InKey$): Loop While q$ = "": If q$ <> "T" Then PrintC 1, LangRes$("1670_2"), -1: GoTo 1661
1671 If da = 5 Then PrintC 1, LangRes$("1671_1"), -1: pw(2) = pw(2) - 1
1672 For y = 1 To 5: If px + dx * y < 1 Or px + dx * y > 9 Or py + dy * y > 9 Or py + dy * y < 0 Then 1662
    1673 mn = dn%(px + dx * y, py + dy * y): mn = Int(mn / 10): If mn > 0 Then 1662
1674 Next: GoTo 1662
1680 If pw(5) < 1 Then PrintC 1, LangRes$("1680_1"), -1: GoTo 1650
1681 If pt$ = "f" Then q = Int(Rnd(1) * 4 + 1): GoTo 1685
1682 PrintC 1, LangRes$("1682_1"), 0: PrintC 1, LangRes$("1682_2"), 0: PrintC 1, LangRes$("1682_3"), 0: PrintC 1, LangRes$("1682_4"), 0: PrintC 1, LangRes$("1682_5"), -1: Do: q$ = InKey$: Loop While q$ = "": q = Val(q$): PrintC 1, Str$(q), -1: If q < 1 Or q > 4 Then 1682
1683 If Rnd(1) > .75 Then PrintC 1, LangRes$("1682_1"), -1: pw(5) = pw(5) - 1
1685 On q GOTO 1686, 1690, 1691, 1692
1686 PrintC 1, LangRes$("1686_1"), -1: dn%(px, py) = 8: Sleep 1: GoTo 1090
1690 PrintC 1, LangRes$("1690_1"), -1: dn%(px, py) = 7: Sleep 1: GoTo 1090
1691 PrintC 1, LangRes$("1691_1"), -1: da = 10 + in: GoTo 1672
1692 On Int(Rnd(1) * 3 + 1) GOTO 1693, 1695, 1697
1693 PrintC 1, LangRes$("1693_1"), -1: PrintC 1, LangRes$("1693_2"), -1
1694 For z2 = 1 To 4: c(z2) = 3: Next z2: Sleep 3: GoTo 1090
1695 PrintC 1, LangRes$("1695_1"), -1: PrintC 1, LangRes$("1695_2"), -1: For y = 0 To 4: c(y) = Int(c(y) * 2.5): Next: Sleep 3: GoTo 1090
1697 PrintC 1, LangRes$("1697_1"), -1: c(0) = c(0) / 2: Sleep 2: GoTo 1090
1700 GoSub 60080: LocateC 0, 1, 1: PrintC 0, LangRes$("1700_1"), 0: Input q$: Screen 12: Cls: GoTo 1090
2000 nm = 0: For x = 1 To 10
    2005 mz%(x, 0) = 0: mz%(x, 1) = x + 3 + in
    2010 If x - 2 > in Or Rnd(1) > .4 Then 2090
    2020 ml%(x, 0) = Int(Rnd(1) * 9 + 1): ml%(x, 1) = Int(Rnd(1) * 9 + 1)
    2030 If dn%(ml%(x, 0), ml%(x, 1)) <> 0 Then 2020
    2040 If ml%(x, 0) = px And ml%(x, 1) = py Then 2020
    2050 dn%(ml%(x, 0), ml%(x, 1)) = x * 10
    2051 mz%(x, 0) = 1
    2052 nm = nm + 1
    2055 mz%(x, 1) = x * 2 + in * 2 * lp
2090 Next: Return
3087 Line (C - 28 / di, b - 41 / di)-(C + 30 / di, b - 55 / di), 7: Line (C + 28 / di, b - 58 / di)-(C + 22 / di, b - 56 / di), 7: Line -(C + 22 / di, b - 53 / di), 7
Line -(C + 28 / di, b - 52 / di), 7: Line -(C + 34 / di, b - 54 / di), 7: Line (C + 20 / di, b - 50 / di)-(C + 26 / di, b - 47 / di), 2
3088 Line (C + 10 / di, b - 58 / di)-(C + 10 / di, b - 61 / di), 7: Line -(C + 4 / di, b - 58 / di), 7: Line (C - 10 / di, b - 58 / di)-(C - 10 / di, b - 61 / di), 7
Line -(C - 4 / di, b - 58 / di), 7: Line (C + 40 / di, b - 9 / di)-(C + 50 / di, b - 12 / di), 2: Line -(C + 40 / di, b - 7 / di), 2
3089 Line (C - 8 / di, b - 25 / di)-(C + 6 / di, b - 7 / di), 2: Line -(C + 28 / di, b - 7 / di), 2: Line -(C + 28 / di, b - 9 / di), 2: Line -(C + 20 / di, b - 9 / di), 2: Line -(C + 6 / di, b - 25 / di), 2: GoTo 490
4000 For mm = 1 To 10: If mz%(mm, 0) = 0 Then 4999
    4010 ra = Sqr((px - ml%(mm, 0)) ^ 2 + (py - ml%(mm, 1)) ^ 2)
    4011 If mz%(mm, 1) < in * lp Then 4030
    4020 If ra < 1.3 Then 4500
    4025 If mm = 8 And ra < 3 Then 4999
    4030 x1 = Sgn(px - ml%(mm, 0)): y1 = Sgn(py - ml%(mm, 1))
    4031 If mz%(mm, 1) < in * lp Then x1 = -x1: y1 = -y1
    4035 If y1 = 0 Then 4045
    4040 d = dn%(ml%(mm, 0), (ml%(mm, 1) + y1 + .499)): If d = 1 Or d > 9 Or d = 2 Then 4045
    4042 x1 = 0: GoTo 4050
    4045 y1 = 0: If x1 = 0 Then 4050
    4046 d = dn%((ml%(mm, 0) + x1 + .499), ml%(mm, 1)): If d = 1 Or d > 9 Or d = 2 Then x1 = 0: GoTo 4081
    4050 dn%(ml%(mm, 0), ml%(mm, 1)) = dn%(ml%(mm, 0), ml%(mm, 1)) - 10 * mm
    4055 If ml%(mm, 0) + x1 = px And ml%(mm, 1) + y1 = py Then 4999
    4060 ml%(mm, 0) = ml%(mm, 0) + x1: ml%(mm, 1) = ml%(mm, 1) + y1
    4080 dn%(ml%(mm, 0), ml%(mm, 1)) = (dn%(ml%(mm, 0), ml%(mm, 1)) + 10 * mm + .499)
    4081 If x1 <> 0 Or y1 <> 0 Then 4999
    4082 If mz%(mm, 1) < in * lp And ra < 1.3 Then 4500
    4083 If mz%(mm, 1) < in * lp Then mz%(mm, 1) = mz%(mm, 1) + mm + in
    4499 GoTo 4999
    4500 If mm = 2 Or mm = 7 Then 4600
    4509 LocateC 1, 30, 1: SetColor 1, 15, 0: PrintC 1, LangRes$("4509_1"), 0: PrintC 1, LangRes$("4509_2") + m$(mm), 0: PrintC 1, LangRes$("4509_3"), -1
    4510 If Rnd(1) * 20 - Sgn(pw(3)) - c(3) + mm + in < 0 Then PrintC 1, LangRes$("4510_1"), -1: GoTo 4525
    4520 PrintC 1, LangRes$("4520_1"), -1: c(0) = c(0) - Int(Rnd(1) * mm + in)
    4525 If pa = 1 Then PrintC 1, LangRes$("4525_1"), 0: Input q$
    4530 GoTo 4999
    4600 If Rnd(1) < .5 Then 4509
    4610 If mm = 7 Then pw(0) = Int(pw(0) / 2): LocateC 1, 30, 1: SetColor 1, 15, 0: PrintC 1, LangRes$("4610_1"), -1: GoTo 4525
    4620 zz = Int(Rnd(1) * 6): If pw(zz) < 1 Then 4620
    4630 LocateC 1, 30, 1: SetColor 1, 15, 0: PrintC 1, LangRes$("4630_1"), 0: PrintC 1, w$(zz), -1: pw(zz) = pw(zz) - 1: GoTo 4525
4999 Next: Return
6000 View Print: SetScrollBlock 0, 1, 30, 20, 60: Cls: LocateC 0, 1, 1: SetColor 0, 15, 0: PrintC 0, "", -1: PrintC 0, "", -1: CenterPrintC 0, LangRes$("6000_1"), -1
6005 If Len(pn$) > 22 Then pn$ = ""
6010 If pn$ = "" Then pn$ = LangRes$("6010_1")
6020 pn$ = pn$ + LangRes$("6020_1")
6030 CenterPrintC 0, TabC$(0, 20 - Int(Len(pn$) / 2)), 0: CenterPrintC 0, pn$, -1
6035 CenterPrintC 0, LangRes$("6035_1"), -1
6040 CenterPrintC 0, LangRes$("6040_1"), 0
6050 Do: q$ = UCase$(InKey$): Loop Until q$ = "Y" Or q$ = "N": If q$ = "Y" Then restart% = -1: If q$ = "N" Then restart% = 0
6060 GoTo 1
7000 Screen 12: View Print: SetScrollBlock 0, 1, 30, 20, 60: LocateC 0, 1, 1: SetColor 0, 15, 0: Cls
7001 Rem
7010 If pn$ <> "" Then 7500
7020 PrintC 0, "", -1: PrintC 0, "", -1: PrintC 0, LangRes$("7020_1"), -1: PrintC 0, LangRes$("7020_2"), 0: SetColor 0, 15, 0: PrintC 0, LangRes$("7020_3"), 0: SetColor 0, 15, 0: PrintC 0, LangRes$("7020_4"), -1: PrintC 0, LangRes$("7020_5"), -1: PrintC 0, LangRes$("7020_6"), -1
7030 PrintC 0, "", -1: PrintC 0, LangRes$("7030_1"), 0: Input pn$: pn$ = UCase$(pn$): PrintC 0, "", -1
7040 PrintC 0, LangRes$("7040_1"), 0: Do: q$ = UCase$(InKey$): Loop While q$ = ""
If q$ <> "Y" Then PrintC 0, "", -1: PrintC 0, LangRes$("7040_2"), -1: pn$ = "": PrintC 0, "", -1: PrintC 0, LangRes$("7040_3"), 0: Do: q$ = InKey$: Loop Until q$ = " ": Cls: GoTo 1090
7045 PrintC 0, "", -1
7050 PrintC 0, "", -1: PrintC 0, LangRes$("7050_1"), -1: PrintC 0, LangRes$("7050_2"), -1: PrintC 0, "", -1: PrintC 0, LangRes$("7050_3"), -1: PrintC 0, LangRes$("7050_4"), -1: PrintC 0, LangRes$("7050_5"), 0: ta = Int(c(4) / 3): SetColor 0, 0, 15: PrintC 0, m$(ta), -1
7060 SetColor 0, 15, 0: PrintC 0, "", -1: PrintC 0, LangRes$("7060_1"), -1: PrintC 0, LangRes$("7060_2"), -1: PrintC 0, LangRes$("7060_3"), -1: PrintC 0, LangRes$("7060_4"), -1
7070 PrintC 0, "", -1: PrintC 0, LangRes$("7070_1"), 0: Do: q$ = InKey$: Loop While q$ = "": For x = 0 To 5: c(x) = c(x) + 1: Next: Cls: GoTo 1090
7500 If ta > 0 Then PrintC 0, "", -1: PrintC 0, "", -1: PrintC 0, pn$, 0: PrintC 0, LangRes$("7500_1"), -1: PrintC 0, LangRes$("7500_2"), 0: PrintC 0, m$(ta), -1: PrintC 0, LangRes$("7500_3"), -1: PrintC 0, "", -1: PrintC 0, LangRes$("7500_4"), 0: Do: q$ = InKey$: Loop While q$ = "": Cls: GoTo 1090
7510 PrintC 0, "", -1: PrintC 0, "", -1: PrintC 0, "", -1: PrintC 0, LangRes$("7510_1"), 0: PrintC 0, pn$, -1: PrintC 0, "", -1: PrintC 0, LangRes$("7510_2"), -1: If Abs(ta) = 10 Then 7900
7520 PrintC 0, LangRes$("7520_1"), -1: PrintC 0, LangRes$("7520_2"), -1: ta = Abs(ta) + 1: PrintC 0, "", -1: PrintC 0, LangRes$("7520_3"), 0: PrintC 0, m$(ta), -1
7530 GoTo 7060
7900 Screen 12: View Print: SetScrollBlock 0, 1, 30, 20, 60: Cls: LocateC 0, 1, 1: PrintC 0, "", -1: PrintC 0, "", -1: PrintC 0, "", -1: pn$ = LangRes$("7900_1") + pn$: PrintC 0, " " + pn$ + ",", -1
7910 PrintC 0, LangRes$("7910_1"), -1: PrintC 0, LangRes$("7910_2"), -1: PrintC 0, LangRes$("7910_3"), -1: PrintC 0, LangRes$("7910_4"), -1
7920 If lp = 10 Then 7950
7930 PrintC 0, "", -1: PrintC 0, LangRes$("7930_1"), -1: PrintC 0, LangRes$("7930_2"), 0: PrintC 0, Str$(lp + 1), -1
7940 GoTo 7070
7950 PrintC 0, "", -1: PrintC 0, LangRes$("7950_1"), -1: PrintC 0, LangRes$("7950_2"), -1: PrintC 0, LangRes$("7950_3"), -1
7990 GoTo 7070
60000 Screen 12: View Print: SetScrollBlock 0, 1, 30, 20, 60: Cls: LocateC 0, 5, 1: PrintC 0, LangRes$("60000_1"), -1: PrintC 0, LangRes$("60000_2"), 0: Input ""; q$: ln = Val(q$)
60005 LocateC 0, 8, 1: PrintC 0, LangRes$("60005_1"), 0: Input ""; q$: lp = Int(Val(q$))
60006 If lp < 1 Or lp > 10 Then 60005
60010 Randomize ln
60020 c$(0) = LangRes$("60020_1"): c$(1) = LangRes$("60020_2"): c$(2) = LangRes$("60020_3"): c$(3) = LangRes$("60020_4"): c$(4) = LangRes$("60020_5"): c$(5) = LangRes$("60020_6")
'Data "生  命.........","力  量.........","敏  捷.........","耐  力.........","智  慧.........","金  幣........."
60025 Rem
60030 'For x = 0 To 5: Read c$(x): Next
60040 Rem
60041 Rem
60042 m$(1) = LangRes$("60042_1"): m$(2) = LangRes$("60042_2"): m$(3) = LangRes$("60042_3"): m$(4) = LangRes$("60042_4"): m$(5) = LangRes$("60042_5"): m$(6) = LangRes$("60042_6"): m$(7) = LangRes$("60042_7"): m$(8) = LangRes$("60042_8"): m$(9) = LangRes$("60042_9"): m$(10) = LangRes$("60042_10")
'Data "骷髏怪","盜賊","大老鼠","獸人","毒蛇","腐肉爬行者","小魔怪","祕密客","惡魔","燄魔"
'"SKELETON","THIEF","GIANT RAT","ORC","VIPER","CARRION CRAWLER","GREMLIN","MIMIC","DAEMON","BALROG"
60043 'For x = 1 To 10: Read m$(x): Next
60050 For x = 0 To 5: c(x) = Int(Sqr(Rnd(1)) * 21 + 4): Next x
60060 Cls: SetScrollBlock 0, 1, 30, 20, 60: LocateC 0, 8, 1: For x = 0 To 5: LocateC 0, x + 8, 1: SetColor 0, 15, 0: PrintC 0, c$(x), 0: SetColor 0, 15, 0: PrintC 0, Str$(c(x)), 0: PrintC 0, "", -1: Next: PrintC 0, LangRes$("60060_1"), -1: PrintC 0, LangRes$("60060_2"), -1: PrintC 0, TabC$(0, 20), 0: Do: q$ = UCase$(InKey$): Loop While q$ = "": If q$ <> "Y" Then 60050
60061 LocateC 0, 16, 1: PrintC 0, "", -1: PrintC 0, LangRes$("60061_1"), -1: PrintC 0, LangRes$("60061_2"), 0: SetColor 0, 0, 15: PrintC 0, LangRes$("60061_3"), -1: SetColor 0, 15, 0: PrintC 0, LangRes$("60061_4"), 0: SetColor 0, 0, 15: PrintC 0, LangRes$("60061_5"), 0: SetColor 0, 15, 0: PrintC 0, TabC$(0, 20), -1: Do: pt$ = InKey$: Loop While pt$ = ""
60062 If pt$ = "m" Or pt$ = "f" Then 60070
60063 GoTo 60061
60070 w$(0) = LangRes$("60070_1"): w$(1) = LangRes$("60070_2"): w$(2) = LangRes$("60070_3"): w$(3) = LangRes$("60070_4"): w$(4) = LangRes$("60070_5"): w$(5) = LangRes$("60070_6")
'Data "<F>食物","<R>長劍","<A>斧頭","<S>盾牌","<B>長弓與箭矢","<M>魔法護身符": For x = 0 To 5: Read w$(x): Next
60075 GoSub 60080: GoSub 60200: Return
60080 Screen 12: View Print: SetScrollBlock 0, 1, 30, 20, 60: Cls: SetColor 0, 15, 0: LocateC 0, 1, 1: PrintC 0, "", -1: PrintC 0, "", -1: PrintC 0, LangRes$("60080_1"), -1: PrintC 0, "", -1: For x = 0 To 5: SetColor 0, 15, 0: PrintC 0, c$(x), 0: SetColor 0, 15, 0: PrintC 0, Str$(c(x)), 0: PrintC 0, TabC$(0, 24), 0: PrintC 0, "0-", 0: SetColor 0, 15, 0: PrintC 0, w$(x), -1: Next: LocateC 0, 1, 1
60081 LocateC 0, 11, 18: SetColor 0, 15, 0: PrintC 0, LangRes$("60081_1"), -1
60082 Rem IF pw(0) > 0 THEN REM  CALL 62450
60085 For z = 0 To 5: LocateC 0, 5 + z, 25 - Len(Str$(pw(z))): SetColor 0, 15, 0: PrintC 0, Str$(pw(z)), 0: Next
60090 LocateC 0, 17, 5: PrintC 0, LangRes$("60090_1"), 0: PrintC 0, TabC$(0, 15), 0: PrintC 0, LangRes$("60090_2"), 0: PrintC 0, TabC$(0, 25), 0: PrintC 0, LangRes$("60090_3"), -1
60100 For x = 0 To 5: LocateC 0, 19 + x, 25: PrintC 0, w$(x), 0: Next
60110 LocateC 0, 19, 5: PrintC 0, "1 FOR 10", 0: PrintC 0, TabC$(0, 15), 0: PrintC 0, "N/A", -1: LocateC 0, 20, 5: PrintC 0, "8", 0: PrintC 0, TabC$(0, 15), 0: PrintC 0, "1-10", -1: LocateC 0, 21, 5: PrintC 0, "5", 0: PrintC 0, TabC$(0, 15), 0: PrintC 0, "1-5", -1
60120 LocateC 0, 22, 5: PrintC 0, "6", 0: PrintC 0, TabC$(0, 15), 0: PrintC 0, "1", -1: LocateC 0, 23, 5: PrintC 0, "3", 0: PrintC 0, TabC$(0, 15), 0: PrintC 0, "1-4", 0: LocateC 0, 24, 5: PrintC 0, "15", 0: PrintC 0, TabC$(0, 15), 0: PrintC 0, "?????", 0: LocateC 0, 1, 1
60130 Return
60200 LocateC 0, 1, 1: PrintC 0, LangRes$("60200_1"), -1
60210 LocateC 0, 13, 1: For jj = 0 To 1: PrintC 0, "                                      ", -1: Next
LocateC 0, 12, 1: PrintC 0, LangRes$("60210_1"), 0: PrintC 0, "        ", 0: LocateC 0, 12, 37: Do: q$ = UCase$(InKey$): Loop While q$ = ""
If q$ = "Q" Then PrintC 0, "", -1: PrintC 0, "", -1: PrintC 0, LangRes$("60210_2"), -1: Sleep 1: Screen 12: Cls: Return
60215 z = -1
60220 If q$ = "F" Then PrintC 0, LangRes$("60220_1"), -1: z = 0: p = 1
60221 If q$ = "R" Then PrintC 0, LangRes$("60221_1"), -1: z = 1: p = 8
60222 If q$ = "A" Then PrintC 0, LangRes$("60222_1"), -1: z = 2: p = 5
60223 If q$ = "S" Then PrintC 0, LangRes$("60223_1"), -1: z = 3: p = 6
60224 If q$ = "B" Then PrintC 0, LangRes$("60224_1"), -1: z = 4: p = 3
60225 If q$ = "M" Then PrintC 0, LangRes$("60225_1"), -1: z = 5: p = 15
60226 If z = -1 Then PrintC 0, UCase$(q$), -1: PrintC 0, LangRes$("60226_1"), -1: Sleep 2: GoTo 60210
60227 If q$ = "R" And pt$ = "m" Then PrintC 0, LangRes$("60227_1"), -1: PrintC 0, LangRes$("60227_2"), -1: Sleep 2: GoTo 60210
60228 If q$ = "B" And pt$ = "m" Then PrintC 0, LangRes$("60228_1"), -1: PrintC 0, LangRes$("60228_2"), -1: Sleep 2: GoTo 60210
60230 If c(5) - p < 0 Then PrintC 0, LangRes$("60230_1"), -1: Sleep 2: GoTo 60210
60235 If z = 0 Then pw(z) = pw(z) + 9
60236 pw(z) = pw(z) + 1: c(5) = c(5) - p
60237 LocateC 0, 10, 16: PrintC 0, Str$(c(5)), 0: PrintC 0, "  ", -1
60240 LocateC 0, 5 + z, 25 - Len(Str$(pw(z))): PrintC 0, Str$(pw(z)), 0: LocateC 0, 14, 1: PrintC 0, "", -1
60250 GoTo 60210


Sub DrawChineseChar (chHiByte As Integer, chLoByte As Integer, x As Integer, y As Integer, chColor As Integer, chScale As Integer)
    Dim fileNum As Integer
    Dim fontData As String * 32
    Dim lineData As Long
    Dim offset As Long

    'Get offset of Chinese Code in FontFile
    '以中文字碼轉換偏移量
    offset = (Val("&H" + Hex$(chHiByte) + Hex$(chLoByte)) - Val("&HA140") + 1) * 32

    If offset < 0 Then Exit Sub

    'Open Chinese FontFile
    '開啟中文字檔
    fileNum = FreeFile
    Open ".\" + CHTFileName For Binary As #fileNum
    If LOF(fileNum) > 0 Then
        Get #fileNum, offset, fontData
    Else
        Close #fileNum
        Exit Sub
    End If
    Close #fileNum

    'Draw Chinese
    '畫出中文字
    For i = 0 To 15
        lineData = Asc(Mid$(fontData, i * 2 + 1, 1)) * 256 + Asc(Mid$(fontData, i * 2 + 2, 1))
        lineData = Val("&H" + Hex$(Asc(Mid$(fontData, i * 2 + 1, 1)))) * 256 + Val("&H" + Hex$(Asc(Mid$(fontData, i * 2 + 2, 1))))
        For j = 0 To 15
            If lineData And (2 ^ (15 - j)) Then
                'PSet (x + j, y + i), chColor
                'chScale is Font Size
                Line (x + j * chScale, y + i * chScale)-(x + j * chScale + chScale - 1, y + i * chScale + chScale - 1), chColor, BF
            End If
        Next j
    Next i
End Sub

Sub DrawEnglishChar (chByte As Integer, x As Integer, y As Integer, chColor As Integer, chScale As Integer)
    Dim fileNum As Integer
    Dim fontData As String * 16
    Dim lineData As Integer
    Dim offset As Long

    'Get offset of English Code in FontFile
    '取英文字碼的偏移量
    offset = (chByte - Val("&H20") + 1) * 16

    'Open English FontFile
    fileNum = FreeFile
    Open ".\" + ENGFileName For Binary As #fileNum
    Get #fileNum, offset, fontData
    Close #fileNum

    'Draw English
    For i = 0 To 15
        lineData = Asc(Mid$(fontData, i + 1, 1))
        For j = 0 To 7
            If lineData And (128 \ (2 ^ j)) Then
                'PSet (x + j, y + i), chColor
                'chScale is Font Size
                Line (x + j * chScale, y + i * chScale)-(x + j * chScale + chScale - 1, y + i * chScale + chScale - 1), chColor, BF
            End If
        Next j
    Next i
End Sub

Sub PrintC (nowLayer As Integer, text As String, hWarp As Integer)
    'Simulate a PRINT function
    '符合顯示中文的方式取代QB的PRINT函數
    Dim i As Integer
    Dim chGet As String
    Dim row As Integer, col As Integer
    Dim px As Integer, py As Integer

    row = currentLayer(nowLayer).currentRow
    col = currentLayer(nowLayer).currentCol

    'Convert text position to Pixel
    px = (col - 1) * charWidth
    py = (row - 1) * charHeight


    For i = 1 To Len(text)
        chGet = Mid$(text, i, 1)

        If Asc(chGet) = 10 Then
            row = row + 1
            col = currentLayer(nowLayer).blockStartCol
        Else

            ' Draw English
            If Asc(chGet) >= 32 And Asc(chGet) <= 126 Then
                Line (px, py)-(px + charWidth, py + charHeight), currentLayer(nowLayer).colorBack, BF
                DrawEnglishChar Asc(chGet), px, py, currentLayer(nowLayer).colorFore, 1
                px = px + charWidth
                col = col + 1
            Else
                ' Draw Chinese
                If i < Len(text) Then
                    Line (px, py)-(px + (charWidth * 2), py + charHeight), currentLayer(nowLayer).colorBack, BF
                    DrawChineseChar Asc(Mid$(text, i, 1)), Asc(Mid$(text, i + 1, 1)), px, py, currentLayer(nowLayer).colorFore, 1
                    col = col + 2
                    px = px + (charWidth * 2)
                    i = i + 1
                End If
            End If

            ' Check out of range for column
            '判斷文字超過每區塊每行臨界值就跳行
            If col > textCols Then
                col = currentLayer(nowLayer).blockStartCol
                row = row + 1
                py = py + charHeight
            End If
            ' Check out of range for row
            '判斷文字超過每區塊列的臨界值就滾動螢幕
            If row > textRows Then
                ScrollBlock (nowLayer)
                row = textRows
            End If
        End If
    Next i

    ' Have a new line
    If hWarp <> 0 Then
        row = row + 1
        col = currentLayer(nowLayer).blockStartCol
        If row > textRows Then
            ScrollBlock (nowLayer)
            row = textRows
        End If
    End If

    ' Return location data
    currentLayer(nowLayer).currentRow = row
    currentLayer(nowLayer).currentCol = col
    Locate row, col
End Sub

Sub SetScrollBlock (setLayer As Integer, startRow As Integer, endRow As Integer, startCol As Integer, endCol As Integer)
    'Set Layer BlockScreen
    '指定滾動區塊
    currentLayer(setLayer).blockStartRow = startRow
    currentLayer(setLayer).blockEndRow = endRow
    currentLayer(setLayer).blockStartCol = startCol
    currentLayer(setLayer).blockEndCol = endCol

    'Line (x1, y1)-(x2, y2), colorBack, BF
End Sub

Sub ScrollBlock (nowLayer As Integer)
    'Simulate text mode window scroll
    '模擬文字模式的螢幕滾動，因為中文是用畫的所以不會像文字一樣滾動
    Dim x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer
    Dim scrollHeight As Integer
    Dim ScrollData As Integer

    ' Convert to pixel
    x1 = (currentLayer(nowLayer).blockStartCol - 1) * charWidth
    y1 = (currentLayer(nowLayer).blockStartRow - 1) * charHeight
    x2 = currentLayer(nowLayer).blockEndCol * charWidth - 1
    y2 = currentLayer(nowLayer).blockEndRow * charHeight - 1

    ' Single line
    scrollHeight = charHeight

    If x1 < 0 Or y1 < 0 Or x2 >= screenWidth Or y2 >= screenHeight Then Exit Sub

    ReDim ScrollData(((x2 - x1 + 1) * (y2 - y1 + 1)) \ 2)
    Get (x1, y1 + scrollHeight)-(x2, y2), ScrollData()

    Line (x1, y2 - scrollHeight + 1)-(x2, y2), currentLayer(nowLayer).colorBack, BF

    Put (x1, y1), ScrollData(), PSet
End Sub

Sub LocateC (nowLayer As Integer, row As Integer, col As Integer)
    'Simulate a LOCATE function
    '符合顯示中文的方式取代QB中LOCATE的函數
    If col = 1 Then col = 0

    col = currentLayer(nowLayer).blockStartCol + col

    If col > currentLayer(nowLayer).blockEndCol Then col = currentLayer(nowLayer).blockStartCol

    currentLayer(nowLayer).currentRow = row
    currentLayer(nowLayer).currentCol = col

    Locate currentLayer(nowLayer).currentRow, currentLayer(nowLayer).currentCol
End Sub

Sub SetColor (setLayer As Integer, fore As Integer, back As Integer)
    If fore = back Then
        currentLayer(setLayer).colorFore = 15
        currentLayer(setLayer).colorBack = 0
    Else
        currentLayer(setLayer).colorFore = fore
        currentLayer(setLayer).colorBack = back
    End If
End Sub

Function TabC$ (nowLayer As Integer, needPos As Integer)
    'Simulate a TAB function
    '取代TAB函數，因為PRINTC是模擬的所以原TAB無法發揮功能
    Dim nextTab As Integer

    If currentLayer(nowLayer).currentCol > currentLayer(nowLayer).blockStartCol + needPos Then
        nextTab = currentLayer(nowLayer).blockStartCol + needPos
    Else
        nextTab = currentLayer(nowLayer).blockStartCol + needPos - currentLayer(nowLayer).currentCol
    End If

    TabC$ = Space$(nextTab)
End Function

Sub CenterPrintC (nowLayer As Integer, text As String, hWarp As Integer)
    'Simulate a Print function, and position in center
    '中文字置中
    Dim newCol As Integer
    Dim trimText As String

    trimText = LTrim$(text)

    newCol = (textCols - (currentLayer(nowLayer).blockEndCol - currentLayer(nowLayer).blockStartCol) - Len(trimText)) \ 2 + 1
    LocateC nowLayer, currentLayer(nowLayer).currentRow, newCol
    PrintC nowLayer, trimText, hWarp
End Sub

Sub ScaleText (x As Integer, y As Integer, text As String, fColor As Integer, bColor As Integer, chScale As Integer)
    'Scale text proportionally
    '依比例縮放文字
    Dim i As Integer
    Dim chGet As String
    Dim px As Integer, py As Integer

    px = x
    py = y

    For i = 1 To Len(text)
        chGet = Mid$(text, i, 1)

        ' Draw english
        If Asc(chGet) >= 32 And Asc(chGet) <= 126 Then
            If bColor >= 0 Then
                Line (px, py)-(px + (charWidth * chScale), py + (charHeight * chScale)), bColor, BF
            End If
            DrawEnglishChar Asc(chGet), px, py, fColor, chScale
            px = px + (charWidth * chScale)
        Else
            ' Darw chinese
            If i < Len(text) Then
                If bColor >= 0 Then
                    Line (px, py)-(px + ((charWidth * 2) * chScale), py + (charHeight * chScale)), bColor, BF
                End If
                DrawChineseChar Asc(Mid$(text, i, 1)), Asc(Mid$(text, i + 1, 1)), px, py, fColor, chScale
                px = px + ((charWidth * 2) * chScale)
                i = i + 1
            End If
        End If
    Next i
End Sub

Sub TitleScreen ()
    Dim eye1 As Integer
    Dim eye2 As Integer
    Dim eye3 As Integer
    Dim eyeColor1 As Integer
    Dim eyeColor2 As Integer
    Dim eyeColor3 As Integer
    Dim startTime As Double

    Screen 12
    Cls
    Line (340, 251)-(342, 251), 11
    Line (340, 251)-(324, 257), 11
    Line (324, 257)-(322, 263), 11
    Line (322, 263)-(332, 267), 11
    Line (332, 267)-(350, 267), 11
    Line (342, 251)-(342, 253), 11
    Line (342, 253)-(346, 257), 11
    Line (346, 257)-(348, 265), 11
    Line (348, 265)-(350, 267), 11
    Line (332, 267)-(332, 279), 7
    Line (338, 267)-(338, 281), 7
    Line (342, 267)-(342, 279), 7

    Line (322, 263)-(322, 277), 3
    Line (322, 277)-(330, 285), 12
    Line (330, 285)-(336, 285), 12
    Line (336, 285)-(338, 281), 12
    Line (338, 281)-(342, 281), 12
    Line (342, 281)-(346, 275), 12
    Line (346, 275)-(350, 275), 12
    Line (350, 267)-(350, 275), 3

    Line (322, 277)-(318, 277), 12
    Line (318, 277)-(314, 283), 12
    Line (314, 283)-(318, 293), 12
    Line (318, 293)-(338, 303), 12
    Line (338, 303)-(352, 293), 12
    Line (352, 293)-(354, 285), 12
    Line (350, 275)-(354, 285), 12

    Line (315, 311)-(312, 330), 8
    Line (312, 330)-(305, 345), 8
    Line (351, 320)-(352, 325), 8
    Line (352, 325)-(356, 332), 8
    Line (329, 346)-(328, 358), 8

    Line (314, 283)-(302, 305), 12
    Line (302, 305)-(302, 319), 12
    Line (302, 319)-(292, 351), 12
    Line (292, 351)-(292, 359), 12
    Line (292, 359)-(296, 367), 12
    Line (296, 367)-(302, 367), 12
    Line (302, 367)-(302, 365), 12
    Line (302, 365)-(300, 361), 12
    Line (300, 361)-(308, 357), 12
    Line (308, 357)-(316, 363), 12
    Line (316, 363)-(326, 363), 12
    Line (326, 363)-(328, 361), 12
    Line (328, 361)-(330, 363), 12
    Line (330, 363)-(336, 363), 12
    Line (336, 363)-(340, 359), 12
    Line (340, 359)-(346, 359), 12
    Line (346, 359)-(348, 361), 12
    Line (348, 359)-(348, 361), 12
    Line (348, 361)-(352, 361), 12
    Line (352, 361)-(356, 359), 12
    Line (356, 359)-(360, 363), 12
    Line (360, 363)-(366, 365), 12
    Line (366, 365)-(370, 365), 12
    Line (370, 365)-(372, 363), 12
    Line (372, 363)-(372, 355), 12
    Line (372, 355)-(364, 343), 12
    Line (364, 343)-(366, 339), 12
    Line (366, 339)-(366, 331), 12
    Line (366, 331)-(362, 323), 12
    Line (362, 323)-(358, 285), 12
    Line (358, 285)-(354, 285), 12


    Line (308, 359)-(308, 379), 3
    Line (308, 379)-(310, 391), 3
    Line (310, 391)-(316, 397), 3
    Line (316, 397)-(328, 397), 3
    Line (328, 397)-(332, 393), 3
    Line (332, 393)-(332, 364), 3
    Line (313, 395)-(312, 397), 7
    Line (312, 397)-(312, 403), 7
    Line (312, 403)-(314, 405), 7
    Line (314, 405)-(314, 420), 7
    Line (314, 415)-(310, 411), 7
    Line (310, 411)-(308, 411), 7
    Line (308, 411)-(302, 415), 7
    Line (302, 415)-(302, 421), 7
    Line (302, 421)-(308, 429), 7
    Line (308, 429)-(318, 433), 7
    Line (318, 433)-(326, 427), 7
    Line (326, 427)-(326, 419), 7
    Line (326, 419)-(328, 415), 7
    Line (328, 415)-(328, 397), 7

    Line (334, 364)-(334, 393), 3
    Line (334, 393)-(336, 397), 3
    Line (336, 397)-(354, 397), 3
    Line (354, 397)-(356, 393), 3
    Line (356, 393)-(356, 360), 3
    Line (336, 397)-(336, 417), 7
    Line (336, 417)-(338, 421), 7
    Line (338, 421)-(336, 425), 7
    Line (336, 425)-(336, 425), 7
    Line (336, 425)-(338, 433), 7
    Line (338, 433)-(348, 433), 7
    Line (348, 433)-(360, 423), 7
    Line (360, 423)-(360, 417), 7
    Line (360, 417)-(358, 415), 7
    Line (358, 415)-(350, 415), 7
    Line (350, 415)-(352, 405), 7
    Line (352, 405)-(352, 398), 7

    Line (313, 283)-(300, 299), 3
    Line (300, 299)-(294, 293), 3
    Line (294, 293)-(286, 293), 3
    Line (286, 293)-(282, 301), 3
    Line (282, 301)-(282, 305), 3
    Line (282, 305)-(288, 315), 3
    Line (288, 315)-(294, 319), 3
    Line (294, 319)-(301, 319), 3
    Line (286, 293)-(286, 279), 3
    Line (286, 279)-(276, 279), 3
    Line (276, 279)-(270, 283), 3
    Line (270, 283)-(270, 287), 3
    Line (270, 287)-(272, 293), 3
    Line (272, 293)-(281, 301), 3

    Line (272, 259)-(272, 255), 14
    Line (272, 255)-(282, 247), 14
    Line (282, 247)-(298, 251), 14
    Line (294, 251)-(290, 253), 14
    Line (290, 253)-(298, 255), 14
    Line (294, 255)-(288, 259), 14
    Line (272, 259)-(288, 259), 14
    Line (288, 260)-(290, 263), 6
    Line (290, 263)-(288, 269), 6
    Line (288, 269)-(276, 269), 6
    Line (276, 269)-(272, 267), 6
    Line (272, 267)-(272, 265), 6
    Line (272, 265)-(274, 261), 6
    Line (274, 261)-(272, 259), 6
    Line (276, 269)-(276, 278), 6
    Line (288, 269)-(286, 278), 6
    Line (274, 296)-(272, 305), 6
    Line (272, 305)-(272, 317), 6
    Line (272, 317)-(276, 317), 6
    Line (276, 317)-(279, 311), 6
    Line (279, 311)-(281, 302), 6

    Line (358, 285)-(364, 287), 3
    Line (364, 287)-(363, 291), 3
    Line (363, 291)-(365, 304), 3
    Line (365, 304)-(378, 337), 3
    Line (378, 337)-(374, 339), 3
    Line (374, 339)-(368, 341), 3
    Line (378, 337)-(384, 337), 3
    Line (384, 337)-(384, 343), 3
    Line (384, 343)-(382, 347), 3
    Line (382, 347)-(378, 351), 3
    Line (378, 351)-(370, 351), 3
    Line (382, 349)-(418, 409), 15
    Line (380, 351)-(416, 411), 15
    Line (416, 409)-(418, 411), 15

    '----------------------------
    Line (150, 410)-(180, 380), 7
    Line (180, 380)-(185, 370), 7
    Line (185, 370)-(190, 370), 7
    Line (190, 370)-(195, 360), 7
    Line (195, 360)-(205, 350), 7
    Line (205, 350)-(205, 335), 7
    Line (205, 335)-(210, 330), 7
    Line (210, 330)-(205, 325), 7
    Line (205, 325)-(205, 310), 7
    Line (205, 310)-(215, 290), 7
    Line (215, 290)-(220, 270), 7
    Line (220, 270)-(230, 250), 7
    Line (230, 250)-(240, 230), 7
    Line (240, 230)-(260, 210), 7
    Line (260, 210)-(270, 250), 7
    Line (270, 250)-(275, 225), 7
    Line (270, 205)-(280, 230), 7
    Line (280, 230)-(290, 190), 7
    Line (290, 190)-(330, 180), 7
    Line (330, 180)-(337, 210), 7
    Line (337, 210)-(350, 180), 7
    Line (350, 180)-(360, 180), 7
    Line (360, 180)-(380, 190), 7
    Line (380, 190)-(385, 250), 7
    Line (385, 250)-(400, 205), 7
    Line (400, 205)-(410, 220), 7
    Line (410, 220)-(420, 230), 7
    Line (420, 230)-(420, 260), 7
    Line (420, 260)-(410, 280), 7
    Line (410, 280)-(430, 340), 7
    Line (430, 340)-(448, 380), 7
    Line (448, 380)-(450, 400), 7
    Line (450, 400)-(500, 420), 7

    Line (195, 360)-(180, 330), 7
    Line (180, 330)-(190, 310), 7
    Line (190, 310)-(200, 270), 7
    Line (200, 270)-(220, 250), 7
    Line (220, 250)-(220, 240), 7
    Line (220, 240)-(230, 230), 7
    Line (230, 230)-(250, 200), 7
    Line (250, 200)-(260, 200), 7
    Line (260, 200)-(280, 187), 7
    Line (280, 187)-(290, 180), 7
    Line (290, 180)-(300, 165), 7
    Line (300, 165)-(320, 160), 7
    Line (320, 160)-(345, 170), 7
    Line (345, 170)-(360, 170), 7
    Line (360, 170)-(380, 180), 7
    Line (380, 180)-(390, 180), 7
    Line (390, 180)-(410, 190), 7
    Line (410, 190)-(420, 220), 7
    Line (420, 220)-(425, 225), 7
    Line (425, 225)-(430, 260), 7
    Line (430, 260)-(440, 280), 7
    Line (440, 280)-(430, 290), 7
    Line (430, 290)-(431, 305), 7
    Line (431, 305)-(445, 325), 7
    Line (445, 325)-(432, 345), 7

    '-----------------------------

    Line (50, 225)-(60, 223), 9
    Line (60, 223)-(70, 230), 9
    Line (70, 230)-(90, 220), 9
    Line (90, 220)-(110, 225), 9
    Line (110, 225)-(145, 218), 9
    Line (125, 250)-(130, 240), 9
    Line (130, 240)-(150, 210), 9
    Line (150, 210)-(155, 190), 9
    Line (155, 190)-(160, 160), 9
    Line (160, 160)-(170, 140), 9
    Line (170, 140)-(170, 120), 9
    Line (170, 120)-(185, 90), 9
    Line (185, 90)-(193, 120), 9
    Line (193, 120)-(200, 130), 9
    Line (200, 130)-(208, 140), 9
    Line (208, 140)-(210, 150), 9
    Line (210, 150)-(211, 160), 9

    Line (209, 143)-(225, 148), 9
    Line (216, 167)-(230, 140), 1
    Line (230, 140)-(240, 120), 1
    Line (240, 120)-(250, 110), 1
    Line (250, 110)-(260, 90), 1
    Line (260, 90)-(270, 70), 1
    Line (270, 70)-(280, 55), 1
    Line (280, 55)-(288, 60), 1
    Line (230, 170)-(240, 150), 9
    Line (240, 150)-(250, 130), 9
    Line (250, 130)-(270, 90), 9
    Line (270, 90)-(285, 70), 9
    Line (285, 70)-(290, 50), 9
    Line (290, 50)-(303, 70), 9
    Line (303, 70)-(305, 90), 9
    Line (305, 90)-(320, 110), 9
    Line (320, 110)-(320, 130), 9
    Line (320, 130)-(330, 140), 9
    Line (320, 160)-(330, 140), 9
    Line (330, 140)-(340, 120), 9
    Line (340, 120)-(360, 90), 9
    Line (360, 90)-(380, 60), 9
    Line (380, 60)-(385, 80), 1
    Line (385, 80)-(400, 100), 1
    Line (400, 100)-(405, 80), 1
    Line (405, 80)-(410, 90), 1
    Line (410, 90)-(420, 60), 1
    Line (420, 60)-(430, 90), 9
    Line (430, 90)-(440, 130), 9
    Line (440, 130)-(450, 150), 9
    Line (450, 150)-(455, 170), 9
    Line (455, 170)-(480, 140), 9
    Line (480, 140)-(500, 160), 9
    Line (500, 160)-(520, 200), 9
    Line (510, 210)-(530, 190), 9
    Line (530, 190)-(540, 210), 9
    Line (540, 210)-(560, 200), 9
    Line (560, 200)-(590, 210), 9
    Line (380, 60)-(390, 40), 9
    Line (390, 40)-(410, 30), 9
    Line (410, 30)-(420, 60), 9
    Line (193, 155)-(188, 170), 1
    Line (188, 170)-(200, 175), 1
    Line (200, 175)-(200, 185), 1
    Line (300, 110)-(300, 120), 1
    Line (300, 120)-(303, 120), 1
    Line (303, 120)-(306, 130), 1
    Line (350, 135)-(348, 145), 1
    Line (405, 133)-(415, 132), 1
    Line (415, 132)-(418, 140), 1
    Line (418, 140)-(423, 140), 1
    Line (423, 140)-(423, 142), 1
    Line (423, 142)-(428, 160), 1


    Line (305, 80)-(320, 70), 1
    Line (320, 70)-(330, 90), 1
    Line (330, 90)-(340, 100), 1
    Line (340, 100)-(360, 89), 1


    '--------------------------

    Line (203, 388)-(198, 398), 2
    Line (198, 398)-(200, 410), 2
    Line (200, 410)-(215, 410), 2
    Line (215, 410)-(220, 400), 2
    Line (220, 400)-(215, 390), 2
    Line (200, 405)-(190, 404), 2
    Line (190, 404)-(183, 410), 2
    Line (183, 410)-(180, 413), 2
    Line (180, 413)-(170, 413), 2
    Line (170, 413)-(165, 410), 2

    Line (208, 382)-(213, 383), 2
    Circle (203, 383), 5, 2, .4, 5
    Circle (218, 385), 5, 2, 4.6, 2.6

    ScaleText 100, 50, LangRes$("TITLE_1"), 15, -1, 3
    ScaleText 450, 110, LangRes$("TITLE_2"), 7, -1, 2

    ScaleText 40, 300, LangRes$("TITLE_3"), 6, -1, 2
    ScaleText 10, 350, LangRes$("TITLE_4"), 6, -1, 2

    ScaleText 480, 300, LangRes$("TITLE_5"), 6, -1, 2
    ScaleText 480, 350, LangRes$("TITLE_6"), 6, -1, 2

    ScaleText 50, 450, LangRes$("TITLE_7"), 15, -1, 1
    ScaleText 270, 450, LangRes$("TITLE_8"), 15, -1, 1

    startTime = Timer

    Do
        eye1 = Rnd Mod 2
        eye2 = Rnd Mod 2
        eye3 = Rnd Mod 2
        If eye1 = 0 Then eyeColor1 = 0 Else eyeColor1 = 12
        If eye2 = 0 Then eyeColor2 = 0 Else eyeColor2 = 12
        If eye3 = 0 Then eyeColor3 = 0 Else eyeColor3 = 12

        If Timer - startTime >= 2 Then
            startTime = Timer

            Circle (240, 265), 1, eyeColor1
            Circle (241, 265), 1, eyeColor1
            Circle (250, 265), 1, eyeColor1
            Circle (251, 265), 1, eyeColor1

            Circle (325, 230), 1, eyeColor2
            Circle (326, 230), 1, eyeColor2
            Circle (335, 230), 1, eyeColor2
            Circle (336, 230), 1, eyeColor2

            Circle (415, 360), 1, eyeColor3
            Circle (416, 360), 1, eyeColor3
            Circle (425, 360), 1, eyeColor3
            Circle (426, 360), 1, eyeColor3

        End If
    Loop Until InKey$ <> ""

    Call Instructions
End Sub

Sub Instructions ()
    Screen 12
    SetScrollBlock 0, 1, 30, 20, 60: SetColor 0, 15, 0
    Cls: LocateC 0, 10, 1: CenterPrintC 0, LangRes$("TITLE_9"), -1
    Do
        q$ = UCase$(InKey$)
    Loop Until q$ = "Y" Or q$ = "N"
    If q$ = "N" Then Exit Sub

    8000 Cls: LocateC 0, 1, 1
    8010 PrintC 0, "", -1: PrintC 0, "", -1: CenterPrintC 0, LangRes$("8010_1"), -1: CenterPrintC 0, LangRes$("8010_2"), -1: CenterPrintC 0, LangRes$("8010_3"), -1: CenterPrintC 0, LangRes$("8010_4"), -1
    8020 CenterPrintC 0, LangRes$("8020_1"), -1: CenterPrintC 0, LangRes$("8020_2"), -1: CenterPrintC 0, LangRes$("8020_3"), -1
    8030 CenterPrintC 0, LangRes$("8030_1"), -1: PrintC 0, "", -1: CenterPrintC 0, LangRes$("8030_2"), -1: CenterPrintC 0, LangRes$("8030_3"), -1: CenterPrintC 0, LangRes$("8030_4"), -1: CenterPrintC 0, "", -1: PrintC 0, "", -1: CenterPrintC 0, LangRes$("8030_5"), 0: 'GET Q$
    While InKey$ = "": Wend
    8100 Cls: LocateC 0, 1, 1: PrintC 0, TabC$(0, 2), 0: PrintC 0, TabC$(0, 12), 0: PrintC 0, LangRes$("8100_1"), -1
    8105 PrintC 0, "", -1: PrintC 0, LangRes$("8105_1"), -1: PrintC 0, TabC$(0, 13), 0: PrintC 0, LangRes$("8105_2"), -1
    8110 PrintC 0, "", -1: PrintC 0, LangRes$("8110_1"), -1: PrintC 0, TabC$(0, 13), 0: PrintC 0, LangRes$("8110_2"), -1
    8120 PrintC 0, "", -1: PrintC 0, LangRes$("8120_1"), -1: PrintC 0, TabC$(0, 13), 0: PrintC 0, LangRes$("8120_2"), -1
    8130 PrintC 0, "", -1: PrintC 0, LangRes$("8130_1"), -1: PrintC 0, TabC$(0, 13), 0: PrintC 0, LangRes$("8130_2"), -1
    8140 PrintC 0, "", -1: PrintC 0, LangRes$("8140_1"), -1: PrintC 0, TabC$(0, 13), 0: PrintC 0, LangRes$("8140_2"), -1
    8150 PrintC 0, "", -1: PrintC 0, LangRes$("8150_1"), -1
    8160 PrintC 0, "", -1: PrintC 0, "", -1: PrintC 0, TabC$(0, 8), 0: PrintC 0, LangRes$("8160_1"), 0: ' GET Q$
    While InKey$ = "": Wend
    Cls: LocateC 0, 1, 1
    PrintC 0, "", -1: PrintC 0, TabC$(0, 8), 0: PrintC 0, LangRes$("INSTR_1"), -1: PrintC 0, TabC$(0, 10), 0: PrintC 0, LangRes$("INSTR_2"), -1
    PrintC 0, TabC$(0, 10), 0: PrintC 0, LangRes$("INSTR_3"), -1
    PrintC 0, "", -1: PrintC 0, TabC$(0, 8), 0: PrintC 0, LangRes$("INSTR_4"), -1: PrintC 0, TabC$(0, 10), 0: PrintC 0, LangRes$("INSTR_5"), -1
    PrintC 0, TabC$(0, 10), 0: PrintC 0, LangRes$("INSTR_6"), -1
    PrintC 0, "", -1: PrintC 0, TabC$(0, 8), 0: PrintC 0, LangRes$("INSTR_7"), -1: PrintC 0, TabC$(0, 10), 0: PrintC 0, LangRes$("INSTR_8"), -1
    PrintC 0, "", -1
    PrintC 0, "", -1: PrintC 0, TabC$(0, 8), 0: PrintC 0, LangRes$("INSTR_9"), -1: PrintC 0, TabC$(0, 10), 0: PrintC 0, LangRes$("INSTR_10"), -1
    PrintC 0, "", -1: PrintC 0, TabC$(0, 8), 0: PrintC 0, LangRes$("INSTR_11"), -1: PrintC 0, TabC$(0, 10), 0: PrintC 0, LangRes$("INSTR_12"), -1
    PrintC 0, TabC$(0, 10), 0: PrintC 0, LangRes$("INSTR_13"), -1
    x1 = 150: y1 = 10
    Line (x1 + 10, y1 + 10)-(x1 + 20, y1 + 10): Line -(x1 + 20, y1 + 40): Line -(x1 + 10, y1 + 40)
    Line -(x1 + 10, y1 + 30): Line -(x1 + 40, y1 + 30): Line -(x1 + 40, y1 + 40): Line -(x1 + 30, y1 + 40): Line -(x1 + 30, y1 + 10): Line -(x1 + 40, y1 + 10)
    Line -(x1 + 40, y1 + 20): Line -(x1 + 10, y1 + 20): Line -(x1 + 10, y1 + 10)
    x1 = 150: y1 = 70
    Line (x1, y1)-(x1 + 50, y1): Line -(x1 + 50, y1 + 50): Line -(x1, y1 + 50): Line -(x1, y1)
    Line (x1 + 10, y1 + 10)-(x1 + 10, y1 + 40), 4: Line -(x1 + 40, y1 + 40), 4
    Line -(x1 + 40, y1 + 10), 4: Line -(x1 + 10, y1 + 10), 4: Line -(x1 + 40, y1 + 40), 12: Line (x1 + 10, y1 + 40)-(x1 + 40, y1 + 10), 12
    x1 = 150: y1 = 140
    Line (x1 + 10, y1 + 50)-(x1 + 10, y1 + 40): Line -(x1 + 20, y1 + 30): Line -(x1 + 40, y1 + 30)
    Line -(x1 + 40, y1 + 50): Line (x1, y1 + 10)-(x1 + 10, y1 + 10): Line (x1 + 50, y1 + 10)-(x1 + 40, y1 + 10)
    Line (x1, y1 + 40)-(x1 + 10, y1 + 40): Line (x1 + 40, y1 + 40)-(x1 + 50, y1 + 40)
    Line (x1 + 10, y1)-(x1 + 10, y1 + 20): Line -(x1 + 20, y1 + 20): Line -(x1 + 20, y1 + 30): Line -(x1 + 30, y1 + 30)
    Line -(x1 + 30, y1 + 10): Line -(x1 + 40, y1 + 10): Line -(x1 + 40, y1)
    x1 = 150: y1 = 200
    Line (x1 + 20, y1 + 20)-(x1 + 30, y1 + 20): Line -(x1 + 30, y1 + 30): Line -(x1 + 20, y1 + 30): Line -(x1 + 20, y1 + 20)
    x1 = 150: y1 = 250
    Line (x1 + 20, y1 + 20)-(x1 + 30, y1 + 30): Line (x1 + 20, y1 + 30)-(x1 + 30, y1 + 20)
    PrintC 0, "", -1: CenterPrintC 0, LangRes$("INSTR_14"), 0
    While InKey$ = "": Wend

    8200 Cls: LocateC 0, 1, 1: PrintC 0, "", -1: CenterPrintC 0, LangRes$("8200_1"), -1
    8210 PrintC 0, "", -1: PrintC 0, "", -1: CenterPrintC 0, LangRes$("8210_1"), -1: CenterPrintC 0, LangRes$("8210_2"), -1
    8220 CenterPrintC 0, LangRes$("8220_1"), -1: CenterPrintC 0, LangRes$("8220_2"), -1
    8230 CenterPrintC 0, LangRes$("8230_1"), -1: CenterPrintC 0, LangRes$("8230_2"), -1
    8240 PrintC 0, "", -1: PrintC 0, "", -1: PrintC 0, TabC$(0, 12), 0: PrintC 0, LangRes$("8240_1"), -1
    8250 PrintC 0, "", -1: CenterPrintC 0, LangRes$("8250_1"), -1: CenterPrintC 0, LangRes$("8250_2"), -1: CenterPrintC 0, LangRes$("8250_3"), -1: CenterPrintC 0, LangRes$("8250_4"), -1
    8270 PrintC 0, "", -1: PrintC 0, "", -1: PrintC 0, TabC$(0, 8), 0: CenterPrintC 0, LangRes$("8270_1"), 0: 'GET Q$
    While InKey$ = "": Wend
    8300 Cls: LocateC 0, 1, 1: PrintC 0, "", -1: PrintC 0, "", -1: PrintC 0, TabC$(0, 16), 0: CenterPrintC 0, LangRes$("8300_1"), -1
    8310 PrintC 0, "", -1: PrintC 0, "", -1: PrintC 0, TabC$(0, 4) + LangRes$("8310_1"), 0: PrintC 0, TabC$(0, 14), 0: PrintC 0, LangRes$("8310_2"), 0: PrintC 0, TabC$(0, 28), 0: PrintC 0, LangRes$("8310_3"), -1
    8320 PrintC 0, "", -1: PrintC 0, LangRes$("8320_1"), -1: PrintC 0, LangRes$("8320_2"), -1: PrintC 0, LangRes$("8320_3"), -1
    8330 PrintC 0, LangRes$("8330_1"), -1: PrintC 0, LangRes$("8330_2"), -1: PrintC 0, LangRes$("8330_3"), -1: PrintC 0, LangRes$("8330_4"), -1
    8335 PrintC 0, LangRes$("8335_1"), -1: PrintC 0, LangRes$("8335_2"), -1: PrintC 0, LangRes$("8335_3"), -1
    8350 PrintC 0, "", -1: PrintC 0, "", -1: PrintC 0, TabC$(0, 8), 0: CenterPrintC 0, LangRes$("8350_1"), 0: 'GET Q$
    While InKey$ = "": Wend
    8400 Cls: LocateC 0, 1, 1: PrintC 0, TabC$(0, 5), 0: CenterPrintC 0, LangRes$("8400_1"), -1: PrintC 0, "", -1: CenterPrintC 0, LangRes$("8400_2"), -1
    8410 PrintC 0, "", -1: CenterPrintC 0, LangRes$("8410_1"), -1: PrintC 0, "", -1: CenterPrintC 0, LangRes$("8410_2"), -1
    8420 PrintC 0, "", -1: PrintC 0, "", -1: CenterPrintC 0, LangRes$("8420_1"), -1: PrintC 0, "", -1: CenterPrintC 0, LangRes$("8420_2"), -1
    8430 PrintC 0, "", -1: PrintC 0, "", -1: CenterPrintC 0, LangRes$("8430_1"), -1: CenterPrintC 0, LangRes$("8430_2"), -1
    8450 PrintC 0, "", -1: PrintC 0, "", -1: PrintC 0, TabC$(0, 8), 0: CenterPrintC 0, LangRes$("8450_1"), -1: 'GET Q$
    8999 SetColor 0, 0, 15: CenterPrintC 0, LangRes$("8999_1"), 0
    While InKey$ = "": Wend

End Sub

Function LangRes$ (langIndex As String)
    'Language resource (For Traditional Chinese BIG-5)
    '訊息文字資源庫
    Select Case langIndex
        Case "10_1": LangRes$ = "歡迎進入阿卡拉貝 末日之境" '" WELCOME TO AKALABETH, WORLD OF DOOM!"
        Case "35_1": LangRes$ = "  (請耐心等候)" '"  (PLEASE WAIT)"
        Case "42_1": LangRes$ = "開始冒險 (方向鍵 ↑/↓/←/→)" '""
        Case "249_1": LangRes$ = "寶箱！" '"CHEST! "
        Case "252_1": LangRes$ = "北" '""
        Case "252_2": LangRes$ = "東" '""
        Case "252_3": LangRes$ = "西" '""
        Case "252_4": LangRes$ = "南" '""
        Case "266_1": LangRes$ = "寶箱！" '"CHEST! "
        Case "1000_1": LangRes$ = "指令？                      " '"COMMAND?                    "
        Case "1081_1": LangRes$ = "PASS" '"PASS"
        Case "1086_1": LangRes$ = "繼續遊戲" '"PAUSE OFF"
        Case "1087_1": LangRes$ = "遊戲暫停" '"PAUSE ON"
        Case "1089_1": LangRes$ = "無法辨識？" '"HUH?"
        Case "1090_1": LangRes$ = "汝已饑餓而亡！！！！" '"YOU HAVE STARVED!!!!!"
        Case "1091_1": LangRes$ = "食物=" '"FOOD="
        Case "1091_2": LangRes$ = "生命=" '"H.P.="
        Case "1091_3": LangRes$ = "金幣=" '"GOLD="
        Case "1091_4": LangRes$ = "樓層=" '"LEVEL="
        Case "1091_5": LangRes$ = "S-狀態 A-攻擊 P-暫停" '""
        Case "1091_6": LangRes$ = "X-進入 /攀上 /爬下  " '""
        Case "1096_1": LangRes$ = "食物=" '"FOOD="
        Case "1096_2": LangRes$ = "生命=" '"H.P.="
        Case "1096_3": LangRes$ = "金幣=" '"GOLD="
        Case "1096_4": LangRes$ = "樓層=" '"LEVEL="
        Case "1096_5": LangRes$ = "S-狀態 A-攻擊 P-暫停" '""
        Case "1096_6": LangRes$ = "X-進入 /攀上 /爬下  " '""
        Case "1100_1": LangRes$ = "向北" '"NORTH"
        Case "1100_2": LangRes$ = "無法越過此山脈" '"YOU CAN'T PASS THE MOUNTAINS"
        Case "1155_1": LangRes$ = "前進" '"FORWARD"
        Case "1160_1": LangRes$ = "啊啊啊啊！陷阱！" '"AAARRRGGGHHH!!! A TRAP!"
        Case "1160_2": LangRes$ = "跌落至層級 " '"FALLING TO LEVEL "
        Case "1170_1": LangRes$ = "發現金幣！！" '"GOLD!!!!!"
        Case "1170_2": LangRes$ = "枚金幣" '"-PIECES OF EIGHT"
        Case "1175_1": LangRes$ = "撿到" '"AND A"
        Case "1200_1": LangRes$ = "向東" '"EAST"
        Case "1200_2": LangRes$ = "您無法越過山脈" '"YOU CAN'T PASS THE MOUNTAINS"
        Case "1250_1": LangRes$ = "轉右" '"TURN RIGHT"
        Case "1300_1": LangRes$ = "向西" '"WEST"
        Case "1300_2": LangRes$ = "您無法越過山脈" '"YOU CAN'T PASS THE MOUNTAINS"
        Case "1350_1": LangRes$ = "轉左" '"TURN LEFT"
        Case "1400_1": LangRes$ = "向南" '"SOUTH"
        Case "1400_2": LangRes$ = "您無法越過山脈" '"YOU CAN'T PASS THE MOUNTAINS"
        Case "1450_1": LangRes$ = "向後轉" '"TURN AROUND"
        Case "1510_1": LangRes$ = "進入地下城" '"GO DUNGEON"
        Case "1510_2": LangRes$ = "請耐心等候 " '"PLEASE WAIT "
        Case "1520_1": LangRes$ = "無法辨識？" '"HUH?"
        Case "1555_1": LangRes$ = "向下進入層級 " '"GO DOWN TO LEVEL "
        Case "1580_1": LangRes$ = "無法辨識？" '"HUH?"
        Case "1581_1": LangRes$ = "離開地下城" '"LEAVE DUNGEON"
        Case "1584_1": LangRes$ = "向上回到層級 " '"GO UP TO LEVEL "
        Case "1586_1": LangRes$ = "命運眷顧，你獲得了" '"THOU HAST GAINED"
        Case "1586_2": LangRes$ = " 點生命" '" HIT POINTS"
        Case "1650_1": LangRes$ = "攻擊 " '"ATTACK "
        Case "1650_2": LangRes$ = "使用武器 <R>長劍 <A>斧頭 <S>盾牌 <B>弓箭 <M>護身符" '"WHICH WEAPON "
        Case "1651_1": LangRes$ = "長劍" '"RAPIER"
        Case "1651_2": LangRes$ = "未擁有此物" '"NOT OWNED"
        Case "1652_1": LangRes$ = "斧頭" '"AXE"
        Case "1652_2": LangRes$ = "未擁有此物" '"NOT OWNED"
        Case "1653_1": LangRes$ = "盾牌" '"SHIELD"
        Case "1653_2": LangRes$ = "未擁有此物" '"NOT OWNED"
        Case "1654_1": LangRes$ = "弓箭" '"BOW"
        Case "1654_2": LangRes$ = "未擁有此物" '"NOT OWNED"
        Case "1655_1": LangRes$ = "魔法護身符" '"MAGIC AMULET"
        Case "1656_1": LangRes$ = "法師不能使用弓箭！" '"MAGES CAN'T USE BOWS!"
        Case "1657_1": LangRes$ = "法師不能使用長劍！" '"MAGES CAN'T USE RAPIERS!"
        Case "1659_1": LangRes$ = "徒手" '"HANDS"
        Case "1662_1": LangRes$ = " 攻擊落空" '" YOU MISSED"
        Case "1663_1": LangRes$ = "攻擊！！" '"HIT!!!"
        Case "1664_1": LangRes$ = "的生命 =" '"'S HIT POINTS="
        Case "1665_1": LangRes$ = "你已斬殺 " '"THOU HAST KILLED A "
        Case "1665_2": LangRes$ = "搜尋後獲得" '"THOU SHALT RECEIVE"
        Case "1665_3": LangRes$ = " 枚金幣" '" PIECES OF EIGHT"
        Case "1668_1": LangRes$ = "按 <Enter> 繼續。 " '"-CR- TO CONT. "
        Case "1670_1": LangRes$ = "<T>投擲 或 <S>揮舞:" '"TO THROW OR SWING:"
        Case "1670_2": LangRes$ = "揮舞" '"SWING"
        Case "1671_1": LangRes$ = "投擲" '"THROW"
        Case "1680_1": LangRes$ = "未擁有此物" '"NONE OWNED"
        Case "1682_1": LangRes$ = "<1>上攀爬梯" '"1-LADDER-UP"
        Case "1682_2": LangRes$ = "<2>向下爬梯" '"2-LADDER-DN"
        Case "1682_3": LangRes$ = "<3>攻擊" '"3-KILL"
        Case "1682_4": LangRes$ = "<4>壞咒語？？" '"4-BAD??"
        Case "1682_5": LangRes$ = "請選擇" '"CHOICE"
        Case "1683_1": LangRes$ = "護身符剩最後一次機會！" '"LAST CHARGE ON THIS AMULET!"
        Case "1686_1": LangRes$ = "上攀爬梯" '"LADDER UP"
        Case "1690_1": LangRes$ = "向下爬梯" '"LADDER DOWN"
        Case "1691_1": LangRes$ = "魔法攻擊" '"MAGIC ATTACK"
        Case "1693_1": LangRes$ = "很不幸的咒語唸錯" '"YOU HAVE BEEN TURNED"
        Case "1693_2": LangRes$ = "你變成一隻癩蛤蟆！" '"INTO A TOAD!"
        Case "1695_1": LangRes$ = "糟糕咒語反彈" '"YOU HAVE BEEN TURNED"
        Case "1695_2": LangRes$ = "你變成蜥蜴人" '"INTO A LIZARD MAN"
        Case "1697_1": LangRes$ = "意外失效" '"BACKFIRE"
        Case "1700_1": LangRes$ = "按 <Enter> 繼續。" '"PRESS -CR- TO CONTINUE"
        Case "4509_1": LangRes$ = "你正受到" '"YOU ARE BEING ATTACKED"
        Case "4509_2": LangRes$ = "" '"BY A "
        Case "4509_3": LangRes$ = "攻擊" '""
        Case "4510_1": LangRes$ = "閃過" '"MISSED"
        Case "4525_1": LangRes$ = "按 <Enter> 繼續 " '"-CR- TO CONT. "
        Case "4610_1": LangRes$ = "食物被小精靈偷了" '"A GREMLIN STOLE SOME FOOD"
        Case "4630_1": LangRes$ = "被盜賊偷走 " '"A THIEF STOLE A "
        Case "6000_1": LangRes$ = "        吾等哀悼昔日風華今則長辭" '"        WE MOURN THE PASSING OF"
        Case "6010_1": LangRes$ = "鄉民" '"THE PEASANT"
        Case "6020_1": LangRes$ = " 以及與他相伴的電腦" '" AND HIS COMPUTER"
        Case "6035_1": LangRes$ = "  將以奇術喚起復甦之奇蹟！" '"  TO INVOKE A MIRACLE OF RESSURECTION"
        Case "6040_1": LangRes$ = "    <Y>重生繼續冒險 / <N>離開遊戲" '"             <HIT ESC KEY>"
        Case "7020_1": LangRes$ = "    此乃權威所臨之地，謹迎鄉民進入聖殿" '"     WELCOME PEASANT INTO THE HALLS OF"
        Case "7020_2": LangRes$ = "威光普照的" '"THE MIGHTY"
        Case "7020_3": LangRes$ = " Lord British " '" LORD BRITISH. "
        Case "7020_4": LangRes$ = "恩廣如海，賜汝機緣" '"HEREIN THOU MAYCHOOSE TO DARE BATTLE WITH THE EVIL"
        Case "7020_5": LangRes$ = "挑戰深淵之邪祟，或能立奇功揚名朝堂" '"CREATURES OF THE DEPTHS, FOR GREAT"
        Case "7020_6": LangRes$ = "必有重賞！" '"REWARD!"
        Case "7030_1": LangRes$ = "汝且速報名來 " '"WHAT IS THY NAME PEASANT "
        Case "7040_1": LangRes$ = "汝可心懷壯志，渴望投身偉大冒險？ <Y/N> " '"DOEST THOU WISH FOR GRAND ADVENTURE ? "
        Case "7040_2": LangRes$ = "既如此便速速退下，莫污朕的殿堂之氣！" '"THEN LEAVE AND BEGONE!"
        Case "7040_3": LangRes$ = "         按 <SPACE> 鍵繼續" '"         PRESS -SPACE- TO CONT."
        Case "7050_1": LangRes$ = "極好！爾既有此抱負，便當奮力一試" '"GOOD! THOU SHALT TRY TO BECOME A "
        Case "7050_2": LangRes$ = "進入朕的麾下 - 英勇騎士！！！" '"KNIGHT!!!"
        Case "7050_3": LangRes$ = "汝之首要使命，乃是進入地城深處" '"THY FIRST TASK IS TO GO INTO THE"
        Case "7050_4": LangRes$ = "如欲得勝而歸重返此殿" '"DUNGEONS AND TO RETURN ONLY AFTER"
        Case "7050_5": LangRes$ = "必須斬殺 " '"KILLING A(N) "
        Case "7060_1": LangRes$ = "    速速啟程，踏上征途" '"     GO NOW UPON THIS QUEST, AND MAY"
        Case "7060_2": LangRes$ = "願幸運女神垂青於汝....." '"LADY LUCK BE FAIR UNTO YOU....."
        Case "7060_3": LangRes$ = "......此外，朕特賞賜" '".....ALSO I, BRITISH, HAVE INCREASED"
        Case "7060_4": LangRes$ = "每項屬性皆增一分，切莫辜負厚望！" '"EACH OF THY ATTRIBUTES BY ONE!"
        Case "7070_1": LangRes$ = "         按 <SPACE> 鍵繼續" '"         PRESS -SPACE- TO CONT."
        Case "7500_1": LangRes$ = "  汝為何空手而返？任務未竟，竟敢擅回！" '" WHY HAST THOU RETURNED?"
        Case "7500_2": LangRes$ = "速速前去，斬殺那 " '"THOU MUST KILL A(N) "
        Case "7500_3": LangRes$ = "完成朕之託付，方許汝歸返此殿！" '"GO NOW AND COMPLETE THY QUEST!"
        Case "7500_4": LangRes$ = "         按 <SPACE> 鍵繼續" '"         PRESS -SPACE- TO CONT."
        Case "7510_1": LangRes$ = "唉呀呀！！....." '"AAHH!!....."
        Case "7510_2": LangRes$ = "汝已完成使命！果然不負眾望，可喜可賀！" '"THOU HAST ACOMPLISHED THY QUEST!"
        Case "7520_1": LangRes$ = "可惜的是，此成就尚不足以令汝" '"UNFORTUNATELY, THIS IS NOT ENOUGH TO"
        Case "7520_2": LangRes$ = "晉爵騎士！" '"BECOME A KNIGHT."
        Case "7520_3": LangRes$ = "汝之使命必須斬殺 " '"NOW THOU MUST KILL A(N) "
        Case "7900_1": LangRes$ = "LORD " '"LORD "
        Case "7910_1": LangRes$ = "       您已證明自身配得上騎士之榮譽！" '"       THOU HAST PROVED THYSELF WORTHY"
        Case "7910_2": LangRes$ = "若願，仍可繼續此遊戲探尋更多奇遇" '"OF KNIGHTHOOD, CONTINUE PLAY IF THOU"
        Case "7910_3": LangRes$ = "然汝之成就成實為不凡" '"DOTH WISH, BUT THOU HAST ACOMPLISHED"
        Case "7910_4": LangRes$ = "已達本遊戲之主旨..." '"THE MAIN OBJECTIVE OF THIS GAME..."
        Case "7930_1": LangRes$ = "    或許你膽大包天，愚勇至極" '"   NOW MAYBE THOU ART FOOLHEARTY"
        Case "7930_2": LangRes$ = "願挑戰更高難度之試煉 " '"ENOUGH TOTRY DIFFICULTY LEVEL "
        Case "7950_1": LangRes$ = "...請致電 CALIFORNIA PACIFIC COMPUTER" '"...CALL CALIFORNIA PACIFIC COMPUTER"
        Case "7950_2": LangRes$ = "(415)-569-9126 報告這項" '"AT (415)-569-9126 TO REPORT THIS"
        Case "7950_3": LangRes$ = "驚人的壯舉！ (編按：現應是上網PO文)" '"AMAZING FEAT!"
        Case "60000_1": LangRes$ = "請輸入您的幸運數字" '"TYPE THY LUCKY NUMBER....."
        Case "60000_2": LangRes$ = "  以見命運所藏之玄機 (任一數字)....." '""
        Case "60005_1": LangRes$ = "選擇遊戲級數，將決定自身挑戰 (1-10)......" '"LEVEL OF PLAY (1-10)......"
        Case "60020_1": LangRes$ = "生  命........." '"HIT POINTS....."
        Case "60020_2": LangRes$ = "力  量........." '"STRENGTH......."
        Case "60020_3": LangRes$ = "敏  捷........." '"DEXTERITY......"
        Case "60020_4": LangRes$ = "耐  力........." '"STAMINA........"
        Case "60020_5": LangRes$ = "智  慧........." '"WISDOM........."
        Case "60020_6": LangRes$ = "金  幣........." '"GOLD..........."
        Case "60042_1": LangRes$ = "骷髏怪" '"SKELETON"
        Case "60042_2": LangRes$ = "盜賊" '"THIEF"
        Case "60042_3": LangRes$ = "大老鼠" '"GIANT RAT"
        Case "60042_4": LangRes$ = "獸人" '"ORC"
        Case "60042_5": LangRes$ = "毒蛇" '"VIPER"
        Case "60042_6": LangRes$ = "腐肉爬行者" '"CARRION CRAWLER"
        Case "60042_7": LangRes$ = "小魔怪" '"GREMLIN"
        Case "60042_8": LangRes$ = "寶箱怪" '"MIMIC"
        Case "60042_9": LangRes$ = "惡魔" '"DAEMON"
        Case "60042_10": LangRes$ = "炎魔" '"BALROG"
        Case "60060_1": LangRes$ = "引領未知的挑戰與奇遇" '"SHALT THOU PLAY WITH THESE QUALITIES?"
        Case "60060_2": LangRes$ = "欲以這些屬性繼續遊戲？<Y>確認 / <N>亂數產生" '""
        Case "60061_1": LangRes$ = "命運的道路將隨之改變" '"AND SHALT THOU BE A FIGHTER OR A MAGE?"
        Case "60061_2": LangRes$ = "      欲成為 " '""
        Case "60061_3": LangRes$ = "<F>戰士，揮舞利劍，征戰四方" '""
        Case "60061_4": LangRes$ = "            還是成為 " '""
        Case "60061_5": LangRes$ = "<M>法師，施展魔法，操控元素？" '""
        Case "60070_1": LangRes$ = "<F>食物" '"FOOD"
        Case "60070_2": LangRes$ = "<R>長劍" '"RAPIER"
        Case "60070_3": LangRes$ = "<A>斧頭" '"AXE"
        Case "60070_4": LangRes$ = "<S>盾牌" '"SHIELD"
        Case "60070_5": LangRes$ = "<B>長弓與箭矢" '"BOW AND ARROWS"
        Case "60070_6": LangRes$ = "<M>魔法護身符" '"MAGIC AMULET"
        Case "60080_1": LangRes$ = "    屬  性              武  器 " '"     STAT'S              WEAPONS"
        Case "60081_1": LangRes$ = "<Q>離開" '"Q-QUIT"
        Case "60090_1": LangRes$ = "價格" '"PRICE"
        Case "60090_2": LangRes$ = "傷害程度" '"DAMAGE"
        Case "60090_3": LangRes$ = "品項" '"ITEM"
        Case "60200_1": LangRes$ = "歡迎來到冒險家商店" '"WELCOME TO THE ADVENTURE SHOP"
        Case "60210_1": LangRes$ = "此地乃英雄所需之寶庫，哪些是您想購入" '"WHICH ITEM SHALT THOU BUY        "
        Case "60210_2": LangRes$ = "BYE" '"BYE"
        Case "60220_1": LangRes$ = "食物" '"FOOD"
        Case "60221_1": LangRes$ = "長劍" '"RAPIER"
        Case "60222_1": LangRes$ = "斧頭" '"AXE"
        Case "60223_1": LangRes$ = "盾牌" '"SHIELD"
        Case "60224_1": LangRes$ = "長弓" '"BOW"
        Case "60225_1": LangRes$ = "護身符" '"AMULET"
        Case "60226_1": LangRes$ = "很抱歉這物品暫時缺貨 " '"I'M SORRY WE DON'T HAVE THAT."
        Case "60227_1": LangRes$ = "非常抱歉，法師" '"I'M SORRY MAGES"
        Case "60227_2": LangRes$ = "無法使用此物！" '"CAN'T USE THAT!"
        Case "60228_1": LangRes$ = "非常抱歉，法師" '"I'M SORRY MAGES"
        Case "60228_2": LangRes$ = "無法使用此物！" '"CAN'T USE THAT!"
        Case "60230_1": LangRes$ = "客倌，財帛不足以購此珍品。" '"M'LORD THOU CAN NOT AFFORD THAT ITEM."
        Case "TITLE_1": LangRes$ = "AKALABETH 阿卡拉貝" '
        Case "TITLE_2": LangRes$ = "中文版" '
        Case "TITLE_3": LangRes$ = "小心了" '"Beware,"
        Case "TITLE_4": LangRes$ = "愚昧的凡人" '"Foolis mortal,"
        Case "TITLE_5": LangRes$ = "膽敢擅闖" '"You trespass in"
        Case "TITLE_6": LangRes$ = "末日之境" '"Akalabeth! World of Doom!!"
        Case "TITLE_7": LangRes$ = "BY LORD BRITISH, 1979" '
        Case "TITLE_8": LangRes$ = "CHINESE LOCALIZED BY INDIANA CHIOU, 2024" '
        Case "TITLE_9": LangRes$ = "遊戲指引及說明 (Y/N)" '"Instructions (Y/N)"
        Case "INSTR_1": LangRes$ = "- 城鎮" '
        Case "INSTR_2": LangRes$ = "這裡是冒險者的補給站" '
        Case "INSTR_3": LangRes$ = "可於商店中進行交易。" '
        Case "INSTR_4": LangRes$ = "- Lord British宮殿" '
        Case "INSTR_5": LangRes$ = "此乃接受冒險任務的啟程之地" '
        Case "INSTR_6": LangRes$ = "完成任務即為勝利的關鍵！" '
        Case "INSTR_7": LangRes$ = "- 山脈" '
        Case "INSTR_8": LangRes$ = "難以逾越的障礙物。" '
        Case "INSTR_9": LangRes$ = "- 樹林" '
        Case "INSTR_10": LangRes$ = "地圖中可作為辨識方向的地標參考。" '
        Case "INSTR_11": LangRes$ = "- 地牢" '
        Case "INSTR_12": LangRes$ = "邪惡藏匿危險重重的試煉之地" '
        Case "INSTR_13": LangRes$ = "勇氣與智慧將在此受到考驗！" '
        Case "INSTR_14": LangRes$ = "(按 <SPACE> 繼續)" '
        Case "8010_1": LangRes$ = "    很久、很久、很久以前" '"     MANY, MANY, MANY YEARS AGO THE"
        Case "8010_2": LangRes$ = "Lord Britith宿敵闇王蒙丹(Mondain)" '"DARK LORD MONDAIN, ARCHFOE OF BRITISH,"
        Case "8010_3": LangRes$ = "曾肆虐於阿卡拉貝(Akalabeth)區域" '"TRAVERSED THE LANDS OF AKALABETH"
        Case "8010_4": LangRes$ = "所至之處邪惡蔓延，死亡隨行" '"SPREADING EVIL AND DEATH AS HE PASSED."
        Case "8020_1": LangRes$ = "雖然蒙丹遭到Lord Britith驅逐" '"BY THE TIME MONDAIN WAS DRIVEN FROM THE"
        Case "8020_2": LangRes$ = "但阿卡拉貝大地已造成深重的創傷" '"LAND BY BRITISH, BEARER OF THE WHITE"
        Case "8020_3": LangRes$ = "千里焦土" '"LIGHT, HE HAD DONE MUCH DAMAGE UNTO"
        Case "8030_1": LangRes$ = "生靈塗炭" '"THE LANDS."
        Case "8030_2": LangRes$ = "汝之天命乃是拯救這片土地" '"'TIS THY DUTY TO HELP RID AKALABETH OF"
        Case "8030_3": LangRes$ = "剷除其上所有邪穢之物" '"THE FOUL BEASTS WHICH INFEST IT,"
        Case "8030_4": LangRes$ = "唯有保全自身，方能完成使命！" '"WHILE TRYING TO STAY ALIVE!!!"
        Case "8030_5": LangRes$ = "       (按 <SPACE> 繼續)" '"       (PRESS SPACE TO CONTINUE)"
        Case "8100_1": LangRes$ = "玩家屬性:" '"THE PLAYER STAT'S:"
        Case "8105_1": LangRes$ = "生命-------  能承受的傷害總量" '"HIT POINTS- AMOUNT OF DAMAGE A PLAYER"
        Case "8105_2": LangRes$ = "耗盡則性命不保" '"CAN ABSORB BEFORE DEATH"
        Case "8110_1": LangRes$ = "力量-------  影響對怪物造成的傷害" '"STRENGTH--- RELATED TO DAMAGE INFLICTED"
        Case "8110_2": LangRes$ = "力量越高，攻擊越猛" '"BY PLAYER AGAINST MONSTERS."
        Case "8120_1": LangRes$ = "敏捷-------  決定攻擊命中怪物的可能性" '"DEXTERITY-- RELATED TO THE PROBABILITY"
        Case "8120_2": LangRes$ = "敏捷越高，擊中率越高" '"OF A PLAYER HITTING A MONST."
        Case "8130_1": LangRes$ = "體力-------  提升抵禦怪物攻擊的能力" '"STAMINA---- RELATED TO PLAYER DEFENSE"
        Case "8130_2": LangRes$ = "體力越強，生存幾率越大" '"AGAINST MONSTERS"
        Case "8140_1": LangRes$ = "智慧-------  運用於特定(如任務賦予)情境" '"WISDOM----- THIS ATTRIBUTE IS USED"
        Case "8140_2": LangRes$ = "展現深思熟慮之力" '"IN SPECIAL (QUEST!) ROUTINES"
        Case "8150_1": LangRes$ = "金幣-------  可用於購買裝備、道具" '"GOLD------- MONEY!! CASH!! ASSETS!!"
        Case "8160_1": LangRes$ = "(按 <SPACE> 繼續)" '"(PRESS SPACE TO CONTINUE)"
        Case "8200_1": LangRes$ = "       城鎮與購物指南：" '"       THE TOWNS AND BUYING ITEMS:"
        Case "8210_1": LangRes$ = "在城鎮商店中，購買想要的物品" '"     TO BUY ANY ITEM ONE NEED ONLY"
        Case "8210_2": LangRes$ = "只需輸入物品名稱前的字母" '"TYPE THE FIRST LETTER OF THE ITEM"
        Case "8220_1": LangRes$ = "各物品之價格在商店內清楚標示" '"WANTED. THE COST OF THE RESPECTIVE"
        Case "8220_2": LangRes$ = "協助做出明確的選擇" '"ITEMS IS DISPLAYED WHILE IN THE TOWN."
        Case "8230_1": LangRes$ = "冒險之初將是20x20格的地圖某處" '"THE GAME IS STARTED IN A TOWN SOMEWHERE"
        Case "8230_2": LangRes$ = "也是整裝待發的起點城鎮！" '"ON THE 20X20 MAP."
        Case "8240_1": LangRes$ = "戰士與法師的抉擇：" '"FIGHTERS AND MAGI"
        Case "8250_1": LangRes$ = "戰士雖以剛猛之力見長，其顯著的缺陷" '"     THE DISADVANTAGE OF BEING A"
        Case "8250_2": LangRes$ = "是無法駕馭魔法護身符" '"FIGHTER IS THE LACK OF THE ABILITY TO"
        Case "8250_3": LangRes$ = "反之，法師雖然能掌控護身符咒" '"CONTROL THE MAGIC AMULET, WHEREAS MAGI"
        Case "8250_4": LangRes$ = "但物理戰鬥弱，無法使用長劍及弓箭！" '"CAN NOT USE RAPIERS OR BOWS."
        Case "8270_1": LangRes$ = "(按 <SPACE> 繼續)" '"(PRESS SPACE TO CONTINUE)"
        Case "8300_1": LangRes$ = "操作方式:" '"MOVEMENT:"
        Case "8310_1": LangRes$ = "按鍵" '"-KEY-"
        Case "8310_2": LangRes$ = "戶外" '"OUTDOORS"
        Case "8310_3": LangRes$ = "地下城" '"DUNGEON"
        Case "8320_1": LangRes$ = "     ↑       向北          前進" '"  CR     MOVE NORTH    MOVE FORWARD"
        Case "8320_2": LangRes$ = "     ←       向西          左轉   " '"  <=     MOVE WEST     TURN LEFT   "
        Case "8320_3": LangRes$ = "     →       向東          右轉" '"  =>     MOVE EAST     TURN RIGHT"
        Case "8330_1": LangRes$ = "     ↓       向南          原地向後轉" '"  /      MOVE SOUTH    TURN AROUND"
        Case "8330_2": LangRes$ = "      S       狀態          狀態" '"  S      STATISTICS    STATISTICS"
        Case "8330_3": LangRes$ = "      A       N/A           攻擊    " '"  A      N/A           ATTACK    "
        Case "8330_4": LangRes$ = "      P       暫停開關      暫停開關" '"  P      PAUSE ON/OFF  PAUSE ON/OFF"
        Case "8335_1": LangRes$ = "      X       進入城鎮      上下爬梯" '"  X      GO INTO TOWN  CLIMB LADDER"
        Case "8335_2": LangRes$ = "      X       進入宮殿      跳入坑洞     " '"  X      GO CASTLE     GO HOLE     "
        Case "8335_3": LangRes$ = "    SPACE     PASS          PASS        " '"SPACE    PASS          PASS        "
        Case "8350_1": LangRes$ = "(按 <SPACE> 繼續)" '"(PRESS SPACE TO CONTINUE)"
        Case "8400_1": LangRes$ = "現在應該已掌握遊戲的基本要領" '"     THOU DOEST NOW KNOW THE BASICS OF"
        Case "8400_2": LangRes$ = "接下來的旅程當自行摸索與嘗試！" '"THE GAME, EXPERIMENT WITH THE COMMANDS."
        Case "8410_1": LangRes$ = "世間仍有許多祕密無法言表" '"THERE IS MUCH THAT IS LEFT UNSAID FOR"
        Case "8410_2": LangRes$ = "需要等待在冒險中親自揭開" '"THEE TO DISCOVER IN THE FUTURE..."
        Case "8420_1": LangRes$ = "去吧！前往探索未知之地" '"     GO NOW UNTO THE WORLD AND SEEK"
        Case "8420_2": LangRes$ = "尋找專屬的榮耀與奇遇吧！" '"ADVENTURE WHERE THOU MIGHT!!!"
        Case "8430_1": LangRes$ = "P.S. 切記要先找尋Lord British宮殿" '"P.S.-SEARCH OUT THE CASTLE OF"
        Case "8430_2": LangRes$ = "並按下 <X> 鍵就可進入！！" '"LORD BRITISH, USE THE -X- KEY TO GO IN!"
        Case "8450_1": LangRes$ = "(按 <SPACE> 繼續)" '"(PRESS SPACE TO CONTINUE)"
        Case "8999_1": LangRes$ = "開始進入 阿卡拉貝" '"RUN AKALABETH START"
    End Select

End Function

Sub LoadINIFile ()
    Dim fileNum As Integer
    Dim strLine As String
    Dim i As Integer
    Dim equalPos As Integer
    Dim sKey As String
    Dim sValue As String

    fileNum = FreeFile
    Open ".\AK_CHT.ini" For Input As #fileNum
    i = 1
    Do While Not EOF(fileNum)
        Line Input #fileNum, strLine

        equalPos = InStr(strLine, "=")
        sKey = LTrim$(Left$(strLine, equalPos - 1))
        sValue = Mid$(strLine, equalPos + 1)

        Select Case sKey
            Case "Fullscreen"
                If UCase$(sValue) = "TRUE" Then
                    isFullscreen = -1
                Else
                    isFullscreen = 0
                End If
            Case "Stretche"
                If UCase$(sValue) = "TRUE" Then
                    isStretche = -1
                Else
                    isStretche = 0
                End If
            Case "Smooth"
                If UCase$(sValue) = "TRUE" Then
                    isSmooth = -1
                Else
                    isSmooth = 0
                End If
            Case "Map"
                If UCase$(sValue) = "TRUE" Then
                    isMap = -1
                Else
                    isMap = 0
                End If
            Case "CHTFont"
                CHTFileName = sValue
            Case "ENGFont"
                ENGFileName = sValue
        End Select
    Loop
    Close #fileNum
End Sub

