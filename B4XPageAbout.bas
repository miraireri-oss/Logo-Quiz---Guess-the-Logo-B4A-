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
	UI.AddLabel(topBar, "About", 56dip, 10dip, w - 80dip, 36dip, 20, True, Colors.White)

	Dim sv As ScrollView
	sv.Initialize(h)
	Root.AddView(sv, 0, 56dip, w, h - 56dip)
	Dim panel As B4XView = sv.Panel
	panel.Color = UI.CLR_BG
	Dim y As Int = 12dip

	Dim card As B4XView = UI.RoundPanel(panel, 12dip, y, w - 24dip, 160dip, UI.CLR_CARD, 12dip)
	UI.AddLabel(card, "Logo Quiz", 14dip, 12dip, w - 40dip, 28dip, 22, True, UI.CLR_PRIMARY)
	UI.AddLabel(card, "Version 1.0", 14dip, 44dip, w - 40dip, 20dip, 12, False, UI.CLR_MUTED)
	UI.AddLabel(card, "Guess the logo from hundreds of brands across categories. Earn coins, build streaks and climb the leaderboard.", 14dip, 70dip, w - 40dip, 80dip, 13, False, UI.CLR_TEXT)
	y = y + 172dip

	Dim card2 As B4XView = UI.RoundPanel(panel, 12dip, y, w - 24dip, 120dip, UI.CLR_CARD, 12dip)
	UI.AddLabel(card2, "How to play", 14dip, 10dip, w - 40dip, 22dip, 15, True, UI.CLR_TEXT)
	UI.AddLabel(card2, "1. Pick a category." & CRLF & "2. Look at the logo." & CRLF & "3. Choose the correct brand name." & CRLF & "4. Use hints if stuck. Faster answers earn bonus coins.", 14dip, 36dip, w - 40dip, 74dip, 12, False, UI.CLR_MUTED)
	y = y + 132dip

	Dim btnRate As Button = UI.AddButton(panel, "Rate App", 12dip, y, w - 24dip, 44dip, UI.CLR_PRIMARY, Colors.White, 10dip, "Rate", Null)
	y = y + 54dip
	Dim btnShare As Button = UI.AddButton(panel, "Share with Friends", 12dip, y, w - 24dip, 44dip, UI.CLR_ACCENT, Colors.White, 10dip, "Share", Null)
	y = y + 54dip

	sv.Panel.Height = y + 20dip
End Sub

Private Sub Rate_Click
	ToastMessageShow("Thank you for rating!", False)
End Sub

Private Sub Share_Click
	ToastMessageShow("Share link copied.", False)
End Sub

Private Sub Back_Click
	B4XPages.ShowPage("MainPage")
End Sub