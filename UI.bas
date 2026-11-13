B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCodeModule
Version=13.70
@EndOfDesignText@
'Code module
Sub Process_Globals
	Private xui As XUI
	Public CLR_BG As Int = 0xFFF5F6FA
	Public CLR_PRIMARY As Int = 0xFF6C5CE7
	Public CLR_PRIMARY_DARK As Int = 0xFF5641E3
	Public CLR_ACCENT As Int = 0xFFA29BFE
	Public CLR_CARD As Int = 0xFFFFFFFF
	Public CLR_TEXT As Int = 0xFF2D3436
	Public CLR_MUTED As Int = 0xFF636E72
	Public CLR_SUCCESS As Int = 0xFF00B894
	Public CLR_WARNING As Int = 0xFFFDCB6E
	Public CLR_DANGER As Int = 0xFFD63031
	Public CLR_BORDER As Int = 0xFFE0E0E0
End Sub

Public Sub RoundPanel(Parent As B4XView, Left As Int, Top As Int, Width As Int, Height As Int, Color As Int, Radius As Int) As B4XView
	Dim p As B4XView = xui.CreatePanel("")
	p.SetColorAndBorder(Color, 0, Color, Radius)
	Parent.AddView(p, Left, Top, Width, Height)
	Return p
End Sub

Public Sub RoundPanelBorder(Parent As B4XView, Left As Int, Top As Int, Width As Int, Height As Int, Color As Int, Radius As Int, BorderColor As Int, BorderWidth As Int) As B4XView
	Dim p As B4XView = xui.CreatePanel("")
	p.SetColorAndBorder(Color, BorderWidth, BorderColor, Radius)
	Parent.AddView(p, Left, Top, Width, Height)
	Return p
End Sub

Public Sub AddLabel(Parent As B4XView, Text As String, Left As Int, Top As Int, Width As Int, Height As Int, Size As Int, Bold As Boolean, Color As Int) As Label
	Dim lbl As Label
	lbl.Initialize("")
	lbl.Text = Text
	lbl.TextSize = Size
	lbl.TextColor = Color
	If Bold Then lbl.Typeface = Typeface.DEFAULT_BOLD
	Parent.AddView(lbl, Left, Top, Width, Height)
	Return lbl
End Sub

Public Sub AddButton(Parent As B4XView, Text As String, Left As Int, Top As Int, Width As Int, Height As Int, Color As Int, TextColor As Int, Radius As Int, EventName As String, Tag As Object) As Button
	Dim btn As Button
	btn.Initialize(EventName)
	btn.Text = Text
	btn.TextColor = TextColor
	btn.TextSize = 14
	Dim cd As ColorDrawable
	cd.Initialize2(Color, Radius, 0, Color)
	btn.Background = cd
	btn.Tag = Tag
	Parent.AddView(btn, Left, Top, Width, Height)
	Return btn
End Sub

Public Sub AddImageView(Parent As B4XView, Left As Int, Top As Int, Width As Int, Height As Int) As ImageView
	Dim iv As ImageView
	iv.Initialize("")
	Parent.AddView(iv, Left, Top, Width, Height)
	Return iv
End Sub