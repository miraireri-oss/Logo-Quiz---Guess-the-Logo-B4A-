B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCodeModule
Version=13.70
@EndOfDesignText@
'Code module
Sub Process_Globals
	Private xui As XUI
	Public Coins As Int = 500
	Public Score As Int = 0
	Public Level As Int = 1
	Public Streak As Int = 0
	Public BestStreak As Int = 0
	Public CurrentCategory As String = "Brands"
	Public CurrentLogo As Map
	Public CurrentOptions As List
	Public Categories As List
	Public Logos As List
End Sub

Public Sub InitializeData
	Categories.Initialize
	Logos.Initialize
	CurrentLogo.Initialize
	CurrentOptions.Initialize

	AddCategory("Brands", "B", 0xFF6C5CE7, "Top global brands", 12)
	AddCategory("Cars", "C", 0xFF0984E3, "Car manufacturer logos", 8)
	AddCategory("Technology", "T", 0xFF00B894, "Tech company logos", 10)
	AddCategory("Sports", "S", 0xFFE17055, "Sports team logos", 8)
	AddCategory("Food & Drinks", "F", 0xFFD63031, "Food and beverage brands", 10)
	AddCategory("Fashion", "A", 0xFFE84393, "Fashion brand logos", 6)

	' Brands
	AddLogo("Brands", "Apple", "Hint: Bitten fruit")
	AddLogo("Brands", "Nike", "Hint: Just do it")
	AddLogo("Brands", "Adidas", "Hint: Three stripes")
	AddLogo("Brands", "Google", "Hint: Search engine colors")
	AddLogo("Brands", "Samsung", "Hint: Korean electronics")
	AddLogo("Brands", "Amazon", "Hint: Arrow from A to Z")
	AddLogo("Brands", "Microsoft", "Hint: Four colored squares")
	AddLogo("Brands", "Coca-Cola", "Hint: Red with white script")
	AddLogo("Brands", "Pepsi", "Hint: Red white blue circle")
	AddLogo("Brands", "McDonald's", "Hint: Golden arches")
	AddLogo("Brands", "Starbucks", "Hint: Green mermaid")
	AddLogo("Brands", "BMW", "Hint: Blue white propeller")

	' Cars
	AddLogo("Cars", "Ferrari", "Hint: Prancing horse")
	AddLogo("Cars", "Mercedes", "Hint: Three pointed star")
	AddLogo("Cars", "Audi", "Hint: Four rings")
	AddLogo("Cars", "Toyota", "Hint: Red ellipses")
	AddLogo("Cars", "Honda", "Hint: Red H")
	AddLogo("Cars", "Ford", "Hint: Blue oval")
	AddLogo("Cars", "Tesla", "Hint: Red T")
	AddLogo("Cars", "Lamborghini", "Hint: Golden bull")

	' Technology
	AddLogo("Technology", "Intel", "Hint: Blue lowered e")
	AddLogo("Technology", "AMD", "Hint: Green square")
	AddLogo("Technology", "Nvidia", "Hint: Green eye")
	AddLogo("Technology", "Sony", "Hint: Simple wordmark")
	AddLogo("Technology", "LG", "Hint: Red face")
	AddLogo("Technology", "HP", "Hint: Blue circle")
	AddLogo("Technology", "Dell", "Hint: Blue wordmark")
	AddLogo("Technology", "Lenovo", "Hint: Red box")
	AddLogo("Technology", "Asus", "Hint: Blue arrow")
	AddLogo("Technology", "Acer", "Hint: Green wordmark")

	' Sports
	AddLogo("Sports", "Nike", "Hint: Swoosh")
	AddLogo("Sports", "Adidas", "Hint: Trefoil")
	AddLogo("Sports", "Puma", "Hint: Leaping cat")
	AddLogo("Sports", "Reebok", "Hint: Vector")
	AddLogo("Sports", "Under Armour", "Hint: UA monogram")
	AddLogo("Sports", "New Balance", "Hint: NB")
	AddLogo("Sports", "Converse", "Hint: Star chevron")
	AddLogo("Sports", "Vans", "Hint: Side stripe")

	' Food & Drinks
	AddLogo("Food & Drinks", "KFC", "Hint: Colonel Sanders")
	AddLogo("Food & Drinks", "Burger King", "Hint: Burger bun")
	AddLogo("Food & Drinks", "Subway", "Hint: Green yellow arrows")
	AddLogo("Food & Drinks", "Domino's", "Hint: Domino tile")
	AddLogo("Food & Drinks", "Pizza Hut", "Hint: Red roof")
	AddLogo("Food & Drinks", "Starbucks", "Hint: Green siren")
	AddLogo("Food & Drinks", "Dunkin", "Hint: Pink orange")
	AddLogo("Food & Drinks", "Nescafe", "Hint: Red mug")
	AddLogo("Food & Drinks", "Red Bull", "Hint: Two bulls")
	AddLogo("Food & Drinks", "Heineken", "Hint: Red star")

	' Fashion
	AddLogo("Fashion", "Gucci", "Hint: GG monogram")
	AddLogo("Fashion", "Louis Vuitton", "Hint: LV monogram")
	AddLogo("Fashion", "Chanel", "Hint: Double C")
	AddLogo("Fashion", "Prada", "Hint: Triangle")
	AddLogo("Fashion", "Zara", "Hint: Minimal wordmark")
	AddLogo("Fashion", "H&M", "Hint: Red ampersand")
End Sub

Private Sub AddCategory(Name As String, Initial As String, Color As Int, Desc As String, Total As Int)
	Dim m As Map
	m.Initialize
	m.Put("name", Name)
	m.Put("initial", Initial)
	m.Put("color", Color)
	m.Put("desc", Desc)
	m.Put("total", Total)
	m.Put("done", 0)
	Categories.Add(m)
End Sub

Private Sub AddLogo(Category As String, Name As String, Hint As String)
	Dim m As Map
	m.Initialize
	m.Put("category", Category)
	m.Put("name", Name)
	m.Put("hint", Hint)
	Logos.Add(m)
End Sub

Public Sub GetCategoryMap(Name As String) As Map
	For Each m As Map In Categories
		If m.Get("name") = Name Then Return m
	Next
	Dim empty As Map
	empty.Initialize
	Return empty
End Sub

Public Sub GetLogosByCategory(Cat As String) As List
	Dim res As List
	res.Initialize
	For Each m As Map In Logos
		If m.Get("category") = Cat Then res.Add(m)
	Next
	Return res
End Sub

Public Sub GetRandomLogo(Cat As String) As Map
	Dim lst As List = GetLogosByCategory(Cat)
	If lst.Size = 0 Then
		Dim empty As Map
		empty.Initialize
		Return empty
	End If
	Return lst.Get(Rnd(0, lst.Size))
End Sub

Public Sub GetOptions(Correct As String, Cat As String) As List
	Dim opts As List
	opts.Initialize
	opts.Add(Correct)
	Dim others As List
	others.Initialize
	For Each m As Map In Logos
		If m.Get("category") = Cat And m.Get("name") <> Correct Then others.Add(m.Get("name"))
	Next
	' pick up to 3 distinct wrong answers
	Dim used As List
	used.Initialize
	Do While opts.Size < 4 And others.Size > 0
		Dim idx As Int = Rnd(0, others.Size)
		Dim cand As String = others.Get(idx)
		If used.IndexOf(cand) = -1 Then
			opts.Add(cand)
			used.Add(cand)
		End If
		others.RemoveAt(idx)
	Loop
	' shuffle
	For i = opts.Size - 1 To 1 Step -1
		Dim j As Int = Rnd(0, i + 1)
		Dim tmp As Object = opts.Get(i)
		opts.Set(i, opts.Get(j))
		opts.Set(j, tmp)
	Next
	Return opts
End Sub

Public Sub MarkCompleted(Name As String, Cat As String)
	Dim m As Map = GetCategoryMap(Cat)
	If m.IsInitialized And m.Size > 0 Then
		Dim done As Int = m.Get("done")
		done = done + 1
		If done > m.Get("total") Then done = m.Get("total")
		m.Put("done", done)
	End If
End Sub

Public Sub CategoryProgress(Cat As String) As Int
	Dim m As Map = GetCategoryMap(Cat)
	If m.IsInitialized And m.Size > 0 Then
		Dim total As Int = m.Get("total")
		Dim done As Int = m.Get("done")
		If total > 0 Then Return (done * 100) / total
	End If
	Return 0
End Sub

Public Sub GetCategoryColor(Cat As String) As Int
	Dim m As Map = GetCategoryMap(Cat)
	If m.IsInitialized And m.Size > 0 Then Return m.Get("color")
	Return 0xFF6C5CE7
End Sub

Public Sub GetCategoryInitial(Cat As String) As String
	Dim m As Map = GetCategoryMap(Cat)
	If m.IsInitialized And m.Size > 0 Then Return m.Get("initial")
	Return "?"
End Sub