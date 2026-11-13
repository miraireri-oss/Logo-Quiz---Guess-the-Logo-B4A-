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

Private Sub B4XPage_Appear
End Sub

Private Sub BuildUI
	Dim w As Int = Root.Width
	Dim h As Int = Root.Height

	Dim topBar As B4XView = UI.RoundPanel(Root, 0, 0, w, 56dip, UI.CLR_PRIMARY, 0)
	Dim btnBack As Button = UI.AddButton(topBar, Chr(0x2190), 8dip, 8dip, 40dip, 40dip, UI.CLR_PRIMARY, Colors.White, 8dip, "Back", Null)
	UI.AddLabel(topBar, "Categories", 56dip, 10dip, w - 80dip, 36dip, 20, True, Colors.White)

	Dim sv As ScrollView
	sv.Initialize(h)
	Root.AddView(sv, 0, 56dip, w, h - 56dip)
	Dim panel As B4XView = sv.Panel
	panel.Color = UI.CLR_BG
	Dim y As Int = 12dip

	For Each cat As Map In DataManager.Categories
		Dim name As String = cat.Get("name")
		Dim color As Int = cat.Get("color")
		Dim initial As String = cat.Get("initial")
		Dim desc As String = cat.Get("desc")
		Dim total As Int = cat.Get("total")
		Dim done As Int = cat.Get("done")

		Dim card As Panel
		card.Initialize("CatCard")
		card.Tag = name
		Dim cd As ColorDrawable
		cd.Initialize2(UI.CLR_CARD, 12dip, 0, UI.CLR_CARD)
		card.Background = cd
		panel.AddView(card, 12dip, y, w - 24dip, 92dip)

		Dim circ As B4XView = UI.RoundPanel(card, 12dip, 19dip, 54dip, 54dip, color, 27dip)
		UI.AddLabel(circ, initial, 0, 12dip, 54dip, 30dip, 22, True, Colors.White).Gravity = Gravity.CENTER

		UI.AddLabel(card, name, 76dip, 8dip, w - 110dip, 24dip, 16, True, UI.CLR_TEXT)
		UI.AddLabel(card, desc, 76dip, 32dip, w - 110dip, 18dip, 11, False, UI.CLR_MUTED)
		Dim prog As Int = DataManager.CategoryProgress(name)
		UI.AddLabel(card, done & "/" & total & "  (" & prog & "%)", 76dip, 54dip, w - 110dip, 16dip, 11, False, UI.CLR_MUTED)

		Dim btnPlay As Button = UI.AddButton(card, "Play", w - 90dip, 26dip, 66dip, 40dip, color, Colors.White, 10dip, "CatPlay", name)
		y = y + 104dip
	Next

	sv.Panel.Height = y + 20dip
End Sub

Private Sub CatCard_Click
	Dim pnl As Panel = Sender
	Dim cat As String = pnl.Tag
	DataManager.CurrentCategory = cat
	B4XPages.ShowPage("game")
End Sub

Private Sub CatPlay_Click
	Dim btn As Button = Sender
	Dim cat As String = btn.Tag
	DataManager.CurrentCategory = cat
	B4XPages.ShowPage("game")
End Sub

Private Sub Back_Click
	B4XPages.ShowPage("MainPage")
End Sub