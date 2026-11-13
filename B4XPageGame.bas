B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.70
@EndOfDesignText@

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private lblLogoName As Label
	Private pnlLogo As B4XView
	Private lblLogoInitial As Label
	Private lblHint As Label
	Private lblTimer As Label
	Private lblCoins As Label
	Private lblScore As Label
	Private optionButtons As List
	Private btnRemove As Button
	Private btnFirst As Button
	Private btnSkip As Button
	Private tmr As Timer
	Private timeLeft As Int = 30
	Private answered As Boolean = False
	Private removedUsed As Boolean = False
	Private firstUsed As Boolean = False
End Sub

Public Sub Initialize
	optionButtons.Initialize
	tmr.Initialize("tmr", 1000)
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.Color = UI.CLR_BG
	BuildUI
End Sub

Private Sub B4XPage_Appear
	NewQuestion
End Sub

Private Sub B4XPage_Disappear
	tmr.Enabled = False
End Sub

Private Sub BuildUI
	Dim w As Int = Root.Width
	Dim h As Int = Root.Height

	Dim topBar As B4XView = UI.RoundPanel(Root, 0, 0, w, 56dip, UI.CLR_PRIMARY, 0)
	Dim btnBack As Button = UI.AddButton(topBar, Chr(0x2190), 8dip, 8dip, 40dip, 40dip, UI.CLR_PRIMARY, Colors.White, 8dip, "Back", Null)
	UI.AddLabel(topBar, "Guess the Logo", 56dip, 10dip, w - 200dip, 36dip, 18, True, Colors.White)
	lblTimer = UI.AddLabel(topBar, "30s", w - 140dip, 10dip, 40dip, 36dip, 16, True, Colors.White)
	lblCoins = UI.AddLabel(topBar, "C: " & DataManager.Coins, w - 95dip, 10dip, 45dip, 36dip, 12, False, Colors.White)
	lblScore = UI.AddLabel(topBar, "S: " & DataManager.Score, w - 50dip, 10dip, 45dip, 36dip, 12, False, Colors.White)

	' Logo card
	Dim logoCard As B4XView = UI.RoundPanel(Root, 12dip, 68dip, w - 24dip, 220dip, UI.CLR_CARD, 16dip)
	pnlLogo = UI.RoundPanel(logoCard, (w - 24dip - 180dip) / 2, 12dip, 180dip, 180dip, UI.CLR_PRIMARY, 90dip)
	lblLogoInitial = UI.AddLabel(pnlLogo, "?", 0, 55dip, 180dip, 70dip, 72, True, Colors.White)
	lblLogoInitial.Gravity = Gravity.CENTER

	lblHint = UI.AddLabel(Root, "Hint:", 12dip, 296dip, w - 24dip, 40dip, 13, False, UI.CLR_MUTED)
	lblHint.Gravity = Gravity.CENTER

	' Options grid
	Dim optY As Int = 344dip
	Dim btnW As Int = (w - 36dip) / 2
	Dim btnH As Int = 46dip
	For i = 0 To 3
		Dim col As Int = i Mod 2
		Dim row As Int = i / 2
		Dim left As Int = 12dip + col * (btnW + 12dip)
		Dim top As Int = optY + row * (btnH + 10dip)
		Dim btn As Button = UI.AddButton(Root, "", left, top, btnW, btnH, UI.CLR_CARD, UI.CLR_TEXT, 10dip, "Option", i)
		btn.Tag = i
		optionButtons.Add(btn)
	Next

	' Hint buttons
	Dim hy As Int = optY + 2 * (btnH + 10dip) + 10dip
	btnRemove = UI.AddButton(Root, "Remove 2", 12dip, hy, (w - 36dip) / 3, 40dip, UI.CLR_WARNING, UI.CLR_TEXT, 10dip, "RemoveTwo", Null)
	btnFirst = UI.AddButton(Root, "First Letter", 12dip + (w - 36dip) / 3 + 6dip, hy, (w - 36dip) / 3, 40dip, UI.CLR_ACCENT, Colors.White, 10dip, "ShowFirst", Null)
	btnSkip = UI.AddButton(Root, "Skip", 12dip + 2 * ((w - 36dip) / 3 + 6dip) - 6dip, hy, (w - 36dip) / 3, 40dip, UI.CLR_DANGER, Colors.White, 10dip, "SkipQ", Null)
End Sub

Private Sub NewQuestion
	answered = False
	removedUsed = False
	firstUsed = False
	timeLeft = 30
	btnRemove.Enabled = True
	btnFirst.Enabled = True
	btnSkip.Enabled = True

	Dim cat As String = DataManager.CurrentCategory
	Dim logo As Map = DataManager.GetRandomLogo(cat)
	DataManager.CurrentLogo = logo
	Dim name As String = logo.Get("name")
	Dim hint As String = logo.Get("hint")
	lblHint.Text = hint

	' logo placeholder
	Dim color As Int = DataManager.GetCategoryColor(cat)
	pnlLogo.SetColorAndBorder(color, 0, color, 90dip)
	lblLogoInitial.Text = name.SubString2(0, 1).ToUpperCase

	' options
	Dim opts As List = DataManager.GetOptions(name, cat)
	DataManager.CurrentOptions = opts
	For i = 0 To 3
		Dim btn As Button = optionButtons.Get(i)
		btn.Text = opts.Get(i)
		btn.Enabled = True
		Dim cd As ColorDrawable
		cd.Initialize2(UI.CLR_CARD, 10dip, 1dip, UI.CLR_BORDER)
		btn.Background = cd
		btn.TextColor = UI.CLR_TEXT
	Next

	lblTimer.Text = timeLeft & "s"
	tmr.Enabled = True
End Sub

Private Sub tmr_Tick
	timeLeft = timeLeft - 1
	If timeLeft < 0 Then timeLeft = 0
	lblTimer.Text = timeLeft & "s"
	If timeLeft = 0 Then
		tmr.Enabled = False
		HandleTimeout
	End If
End Sub

Private Sub HandleTimeout
	answered = True
	Dim name As String = DataManager.CurrentLogo.Get("name")
	ToastMessageShow("Time's up! Answer: " & name, False)
	DataManager.Streak = 0
	Sleep(1200)
	NewQuestion
End Sub

Private Sub Option_Click
	If answered Then Return
	Dim btn As Button = Sender
	Dim chosen As String = btn.Text
	Dim correct As String = DataManager.CurrentLogo.Get("name")
	answered = True
	tmr.Enabled = False

	If chosen = correct Then
		Dim bonus As Int = timeLeft / 3
		DataManager.Coins = DataManager.Coins + 10 + bonus
		DataManager.Score = DataManager.Score + 10
		DataManager.Streak = DataManager.Streak + 1
		If DataManager.Streak > DataManager.BestStreak Then DataManager.BestStreak = DataManager.Streak
		DataManager.MarkCompleted(correct, DataManager.CurrentCategory)
		Dim cd As ColorDrawable
		cd.Initialize2(UI.CLR_SUCCESS, 10dip, 0, UI.CLR_SUCCESS)
		btn.Background = cd
		btn.TextColor = Colors.White
		ToastMessageShow("Correct! +" & (10 + bonus) & " coins", False)
	Else
		DataManager.Coins = Max(0, DataManager.Coins - 5)
		DataManager.Streak = 0
		Dim cd As ColorDrawable
		cd.Initialize2(UI.CLR_DANGER, 10dip, 0, UI.CLR_DANGER)
		btn.Background = cd
		btn.TextColor = Colors.White
		' highlight correct
		For Each b As Button In optionButtons
			If b.Text = correct Then
				Dim cd2 As ColorDrawable
				cd2.Initialize2(UI.CLR_SUCCESS, 10dip, 0, UI.CLR_SUCCESS)
				b.Background = cd2
				b.TextColor = Colors.White
			End If
		Next
		ToastMessageShow("Wrong! Answer: " & correct, False)
	End If
	lblCoins.Text = "C: " & DataManager.Coins
	lblScore.Text = "S: " & DataManager.Score
	Sleep(1400)
	NewQuestion
End Sub

Private Sub RemoveTwo_Click
	If answered Or removedUsed Then Return
	removedUsed = True
	btnRemove.Enabled = False
	Dim correct As String = DataManager.CurrentLogo.Get("name")
	Dim removed As Int = 0
	For Each b As Button In optionButtons
		If removed >= 2 Then Exit
		If b.Text <> correct And b.Enabled Then
			b.Enabled = False
			Dim cd As ColorDrawable
			cd.Initialize2(0xFFE0E0E0, 10dip, 0, 0xFFE0E0E0)
			b.Background = cd
			b.TextColor = UI.CLR_MUTED
			removed = removed + 1
		End If
	Next
	DataManager.Coins = Max(0, DataManager.Coins - 3)
	lblCoins.Text = "C: " & DataManager.Coins
End Sub

Private Sub ShowFirst_Click
	If answered Or firstUsed Then Return
	firstUsed = True
	btnFirst.Enabled = False
	Dim name As String = DataManager.CurrentLogo.Get("name")
	lblHint.Text = lblHint.Text & "  |  Starts with: " & name.SubString2(0, 1).ToUpperCase
	DataManager.Coins = Max(0, DataManager.Coins - 5)
	lblCoins.Text = "C: " & DataManager.Coins
End Sub

Private Sub SkipQ_Click
	If answered Then Return
	answered = True
	tmr.Enabled = False
	DataManager.Coins = Max(0, DataManager.Coins - 2)
	lblCoins.Text = "C: " & DataManager.Coins
	DataManager.Streak = 0
	ToastMessageShow("Skipped", False)
	Sleep(600)
	NewQuestion
End Sub

Private Sub Back_Click
	B4XPages.ShowPage("MainPage")
End Sub

