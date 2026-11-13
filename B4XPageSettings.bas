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
	UI.AddLabel(topBar, "Settings", 56dip, 10dip, w - 80dip, 36dip, 20, True, Colors.White)

	Dim sv As ScrollView
	sv.Initialize(h)
	Root.AddView(sv, 0, 56dip, w, h - 56dip)
	Dim panel As B4XView = sv.Panel
	panel.Color = UI.CLR_BG
	Dim y As Int = 12dip

	Dim sections() As String = Array As String("Sound", "Vibration", "Notifications", "Dark Mode", "Language", "Reset Progress")
	For i = 0 To sections.Length - 1
		Dim card As B4XView = UI.RoundPanel(panel, 12dip, y, w - 24dip, 56dip, UI.CLR_CARD, 10dip)
		UI.AddLabel(card, sections(i), 14dip, 16dip, w - 100dip, 24dip, 14, False, UI.CLR_TEXT)
		Dim btn As Button = UI.AddButton(card, "On", w - 70dip, 10dip, 52dip, 36dip, UI.CLR_PRIMARY, Colors.White, 8dip, "Toggle", i)
		btn.Tag = sections(i)
		y = y + 66dip
	Next

	' About link
	Dim aboutCard As B4XView = UI.RoundPanel(panel, 12dip, y, w - 24dip, 56dip, UI.CLR_CARD, 10dip)
	Dim btnAbout As Button = UI.AddButton(aboutCard, "About & Help", 14dip, 10dip, w - 40dip, 36dip, UI.CLR_CARD, UI.CLR_PRIMARY, 8dip, "OpenAbout", Null)
	btnAbout.Gravity = Gravity.LEFT
	y = y + 66dip

	sv.Panel.Height = y + 20dip
End Sub

Private Sub Toggle_Click
	Dim btn As Button = Sender
	If btn.Text = "On" Then btn.Text = "Off" Else btn.Text = "On"
End Sub

Private Sub OpenAbout_Click
	B4XPages.ShowPage("about")
End Sub

Private Sub Back_Click
	B4XPages.ShowPage("MainPage")
End Sub