B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.70
@EndOfDesignText@
#IgnoreWarnings:12,9

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Public Drawer As B4XDrawer
	Private Built As Boolean = False
End Sub

Public Sub Initialize
	DataManager.InitializeData
	Dim catPage As B4XPageCategories
	catPage.Initialize
	B4XPages.AddPage("categories", catPage)

	Dim gamePage As B4XPageGame
	gamePage.Initialize
	B4XPages.AddPage("game", gamePage)

	Dim lbPage As B4XPageLeaderboard
	lbPage.Initialize
	B4XPages.AddPage("leaderboard", lbPage)

	Dim setPage As B4XPageSettings
	setPage.Initialize
	B4XPages.AddPage("settings", setPage)

	Dim aboutPage As B4XPageAbout
	aboutPage.Initialize
	B4XPages.AddPage("about", aboutPage)
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.Color = UI.CLR_BG
	Drawer.Initialize(Me, "Drawer", Root, 230dip)
	Sleep(0)
	BuildDashboard
	BuildLeftMenu
End Sub

Private Sub B4XPage_Appear
	If Built = False Then
		Built = True
	End If
End Sub

Private Sub B4XPage_Resize (Width As Int, Height As Int)
	If Drawer.IsInitialized Then Drawer.Resize(Width, Height)
End Sub

Private Sub Drawer_StateChanged (Open As Boolean)
End Sub

Private Sub BuildDashboard
	Dim p As B4XView = Drawer.CenterPanel
	p.Color = UI.CLR_BG
	Dim w As Int = p.Width
	Dim h As Int = p.Height

	' Top app bar
	Dim topBar As B4XView = UI.RoundPanel(p, 0, 0, w, 56dip, UI.CLR_PRIMARY, 0)
	Dim btnMenu As Button = UI.AddButton(topBar, Chr(0x2630), 8dip, 8dip, 40dip, 40dip, UI.CLR_PRIMARY, Colors.White, 8dip, "Menu", Null)
	Dim lblTitle As Label = UI.AddLabel(topBar, "Logo Quiz", 56dip, 10dip, w - 150dip, 36dip, 20, True, Colors.White)
	Dim lblCoins As Label = UI.AddLabel(topBar, "Coins: " & DataManager.Coins, w - 90dip, 10dip, 82dip, 36dip, 13, True, Colors.White)
	lblCoins.Gravity = Gravity.RIGHT

	' Scroll content
	Dim sv As ScrollView
	sv.Initialize(h)
	p.AddView(sv, 0, 56dip, w, h - 56dip)
	Dim panel As B4XView = sv.Panel
	panel.Color = UI.CLR_BG
	Dim y As Int = 12dip

	' Hero card
	Dim hero As B4XView = UI.RoundPanel(panel, 12dip, y, w - 24dip, 110dip, UI.CLR_PRIMARY_DARK, 16dip)
	UI.AddLabel(hero, "Welcome back!", 16dip, 12dip, w - 56dip, 28dip, 18, True, Colors.White)
	UI.AddLabel(hero, "Level " & DataManager.Level & "  |  Score " & DataManager.Score, 16dip, 44dip, w - 56dip, 22dip, 13, False, UI.CLR_ACCENT)
	UI.AddLabel(hero, "Keep guessing logos to earn coins and climb the leaderboard.", 16dip, 68dip, w - 56dip, 34dip, 12, False, Colors.White)
	y = y + 122dip

	' Stats row
	Dim cardW As Int = (w - 36dip) / 3
	Dim c1 As B4XView = UI.RoundPanel(panel, 12dip, y, cardW, 74dip, UI.CLR_CARD, 12dip)
	UI.AddLabel(c1, "Coins", 8dip, 6dip, cardW - 16dip, 18dip, 11, False, UI.CLR_MUTED)
	UI.AddLabel(c1, DataManager.Coins, 8dip, 26dip, cardW - 16dip, 30dip, 18, True, UI.CLR_PRIMARY)
	Dim c2 As B4XView = UI.RoundPanel(panel, 12dip + cardW + 6dip, y, cardW, 74dip, UI.CLR_CARD, 12dip)
	UI.AddLabel(c2, "Streak", 8dip, 6dip, cardW - 16dip, 18dip, 11, False, UI.CLR_MUTED)
	UI.AddLabel(c2, DataManager.Streak, 8dip, 26dip, cardW - 16dip, 30dip, 18, True, UI.CLR_WARNING)
	Dim c3 As B4XView = UI.RoundPanel(panel, 12dip + (cardW + 6dip) * 2, y, cardW, 74dip, UI.CLR_CARD, 12dip)
	UI.AddLabel(c3, "Best", 8dip, 6dip, cardW - 16dip, 18dip, 11, False, UI.CLR_MUTED)
	UI.AddLabel(c3, DataManager.BestStreak, 8dip, 26dip, cardW - 16dip, 30dip, 18, True, UI.CLR_SUCCESS)
	y = y + 86dip

	' Continue card
	Dim cont As B4XView = UI.RoundPanel(panel, 12dip, y, w - 24dip, 76dip, UI.CLR_CARD, 12dip)
	UI.AddLabel(cont, "Continue: " & DataManager.CurrentCategory, 14dip, 8dip, w - 120dip, 24dip, 15, True, UI.CLR_TEXT)
	Dim prog As Int = DataManager.CategoryProgress(DataManager.CurrentCategory)
	UI.AddLabel(cont, "Progress " & prog & "%", 14dip, 34dip, w - 120dip, 18dip, 12, False, UI.CLR_MUTED)
	Dim btnPlay As Button = UI.AddButton(cont, "Play", w - 90dip, 18dip, 70dip, 40dip, UI.CLR_PRIMARY, Colors.White, 10dip, "PlayNow", DataManager.CurrentCategory)
	y = y + 88dip

	' Daily challenge
	Dim daily As B4XView = UI.RoundPanel(panel, 12dip, y, w - 24dip, 70dip, 0xFFFEF3C7, 12dip)
	UI.AddLabel(daily, "Daily Challenge", 14dip, 8dip, w - 40dip, 22dip, 15, True, 0xFF92400E)
	UI.AddLabel(daily, "Guess 5 logos in 60 seconds for a 100 coin bonus!", 14dip, 32dip, w - 40dip, 30dip, 12, False, 0xFF92400E)
	y = y + 82dip

	' Categories title
	UI.AddLabel(panel, "Categories", 12dip, y, w - 24dip, 24dip, 17, True, UI.CLR_TEXT)
	y = y + 30dip

	For Each cat As Map In DataManager.Categories
		Dim name As String = cat.Get("name")
		Dim color As Int = cat.Get("color")
		Dim initial As String = cat.Get("initial")
		Dim card As B4XView = UI.RoundPanel(panel, 12dip, y, w - 24dip, 78dip, UI.CLR_CARD, 12dip)
		' colored icon circle
		Dim circ As B4XView = UI.RoundPanel(card, 12dip, 12dip, 54dip, 54dip, color, 27dip)
		UI.AddLabel(circ, initial, 0, 12dip, 54dip, 30dip, 22, True, Colors.White).Gravity = Gravity.CENTER
		UI.AddLabel(card, name, 76dip, 8dip, w - 110dip, 24dip, 15, True, UI.CLR_TEXT)
		Dim desc As String = cat.Get("desc")
		UI.AddLabel(card, desc, 76dip, 32dip, w - 110dip, 18dip, 11, False, UI.CLR_MUTED)
		Dim prog2 As Int = DataManager.CategoryProgress(name)
		UI.AddLabel(card, prog2 & "% complete", 76dip, 52dip, 80dip, 16dip, 11, False, UI.CLR_MUTED)
		Dim btnCat As Button = UI.AddButton(card, "Play", w - 90dip, 19dip, 66dip, 40dip, color, Colors.White, 10dip, "CatPlay", name)
		y = y + 90dip
	Next

	sv.Panel.Height = y + 20dip
End Sub

Private Sub BuildLeftMenu
	Dim lp As B4XView = Drawer.LeftPanel
	lp.Color = Colors.White
	Dim header As B4XView = UI.RoundPanel(lp, 0, 0, lp.Width, 110dip, UI.CLR_PRIMARY, 0)
	UI.AddLabel(header, "Logo Quiz", 16dip, 24dip, lp.Width - 32dip, 28dip, 20, True, Colors.White)
	UI.AddLabel(header, "Guess the logo!", 16dip, 54dip, lp.Width - 32dip, 20dip, 12, False, UI.CLR_ACCENT)
	Dim avatar As B4XView = UI.RoundPanel(header, lp.Width - 64dip, 18dip, 48dip, 48dip, Colors.White, 24dip)
	UI.AddLabel(avatar, "P", 0, 10dip, 48dip, 28dip, 20, True, UI.CLR_PRIMARY).Gravity = Gravity.CENTER

	Dim itemLabels() As String = Array As String("Home", "Categories", "Random Play", "Leaderboard", "Coin Shop", "Settings", "About")
	Dim itemTags() As String = Array As String("home", "categories", "random", "leaderboard", "shop", "settings", "about")

	Dim y As Int = 120dip
	For i = 0 To itemLabels.Length - 1
		Dim btn As Button = UI.AddButton(lp, itemLabels(i), 10dip, y, lp.Width - 20dip, 42dip, Colors.White, UI.CLR_TEXT, 8dip, "MenuItem", itemTags(i))
		btn.Gravity = Gravity.LEFT
		y = y + 46dip
	Next
End Sub

Private Sub Menu_Click
	Drawer.setLeftOpen(True)
End Sub

Private Sub PlayNow_Click
	Dim btn As Button = Sender
	Dim cat As String = btn.Tag
	DataManager.CurrentCategory = cat
	B4XPages.ShowPage("game")
End Sub

Private Sub CatPlay_Click
	Dim btn As Button = Sender
	Dim cat As String = btn.Tag
	DataManager.CurrentCategory = cat
	B4XPages.ShowPage("game")
End Sub

Private Sub MenuItem_Click
	Dim btn As Button = Sender
	Dim tag As String = btn.Tag
	Drawer.setLeftOpen(False)
	Select Case tag
		Case "home"
			B4XPages.ShowPage("MainPage")
		Case "categories"
			B4XPages.ShowPage("categories")
		Case "random"
			Dim rc As Map = DataManager.Categories.Get(Rnd(0, DataManager.Categories.Size))
			DataManager.CurrentCategory = rc.Get("name")
			B4XPages.ShowPage("game")
		Case "leaderboard"
			B4XPages.ShowPage("leaderboard")
		Case "shop"
			B4XPages.ShowPage("settings") ' placeholder
		Case "settings"
			B4XPages.ShowPage("settings")
		Case "about"
			B4XPages.ShowPage("about")
	End Select
End Sub