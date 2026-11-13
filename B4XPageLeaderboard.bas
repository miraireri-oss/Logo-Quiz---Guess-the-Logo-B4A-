B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.70
@EndOfDesignText@

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
End Sub

Public Sub Initialize
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.Color = UI.CLR_BG
	BuildUI
End Sub

Private Sub BuildUI
	Dim w As Int = Root.Width
	Dim h As Int = Root.Height

	Dim topBar As B4XView = UI.RoundPanel(Root, 0, 0, w, 56dip, UI.CLR_PRIMARY, 0)
	Dim btnBack As Button = UI.AddButton(topBar, Chr(0x2190), 8dip, 8dip, 40dip, 40dip, UI.CLR_PRIMARY, Colors.White, 8dip, "Back", Null)
	UI.AddLabel(topBar, "Leaderboard", 56dip, 10dip, w - 80dip, 36dip, 20, True, Colors.White)

	Dim sv As ScrollView
	sv.Initialize(h)
	Root.AddView(sv, 0, 56dip, w, h - 56dip)
	Dim panel As B4XView = sv.Panel
	panel.Color = UI.CLR_BG
	Dim y As Int = 12dip

	' Header card
	Dim header As B4XView = UI.RoundPanel(panel, 12dip, y, w - 24dip, 90dip, UI.CLR_PRIMARY_DARK, 12dip)
	UI.AddLabel(header, "Your Rank", 14dip, 8dip, w - 40dip, 22dip, 14, False, UI.CLR_ACCENT)
	UI.AddLabel(header, "#7", 14dip, 30dip, 80dip, 40dip, 30, True, Colors.White)
	UI.AddLabel(header, "Score: " & DataManager.Score & "  |  Coins: " & DataManager.Coins, 90dip, 40dip, w - 110dip, 22dip, 13, False, Colors.White)
	y = y + 102dip

	' Top players (dummy)
	Dim names() As String = Array As String("Alex", "Maria", "John", "Priya", "Chen", "Fatima", "You", "David", "Sara", "Tom")
	Dim scores() As Int = Array As Int(980, 920, 870, 810, 760, 720, DataManager.Score, 610, 580, 540)
	For i = 0 To names.Length - 1
		Dim card As B4XView = UI.RoundPanel(panel, 12dip, y, w - 24dip, 52dip, UI.CLR_CARD, 10dip)
		Dim rankColor As Int = UI.CLR_MUTED
		If i = 0 Then rankColor = 0xFFFFD700
		If i = 1 Then rankColor = 0xFFC0C0C0
		If i = 2 Then rankColor = 0xFFCD7F32
		UI.AddLabel(card, (i + 1), 12dip, 12dip, 30dip, 28dip, 16, True, rankColor)
		UI.AddLabel(card, names(i), 48dip, 14dip, w - 140dip, 24dip, 14, (i = 6), UI.CLR_TEXT)
		UI.AddLabel(card, scores(i), w - 80dip, 14dip, 60dip, 24dip, 14, True, UI.CLR_PRIMARY).Gravity = Gravity.RIGHT
		y = y + 60dip
	Next

	sv.Panel.Height = y + 20dip
End Sub

Private Sub Back_Click
	B4XPages.ShowPage("MainPage")
End Sub