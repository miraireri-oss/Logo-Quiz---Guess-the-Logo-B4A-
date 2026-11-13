# Logo Quiz - Guess the Logo (B4A)

A B4A (Basic4Android) logo quiz / trivia game inspired by the CodeCanyon item
"Logo Quiz Guess the Logo Quiz Trivia Game". Built with **B4XPages**, **B4XDrawer**,
**XUI** and standard Android views. All data is dummy data so you can easily
add, edit or recode it.

## Project location
`C:\B4A-APPS\LogoQuiz\LogoQuiz.b4a`

## Features
- Purple gradient theme with rounded cards and a left drawer menu
- Dashboard with hero card, stats (coins / streak / best), continue card,
  daily challenge card and category cards with progress
- Categories: Brands, Cars, Technology, Sports, Food & Drinks, Fashion
- Game screen with logo placeholder, hint, 4 answer options, 30s timer,
  scoring, coins, streak and hints (remove 2, first letter, skip)
- Leaderboard, Settings, About pages
- 13 reference screenshots from CodeCanyon in `screenshots/`

## Requirements
- B4A 14.x (tested with B4ABuilder v14.20)
- Libraries: `b4xdrawer`, `b4xpages`, `core`, `xcustomlistview`, `xui`

## Build
```
cd C:\B4A-APPS\LogoQuiz
C:\TestB4A\B4ABuilder.exe -task=Build -Project=LogoQuiz.b4a -NoSign=True
```
Output: `Objects\bin\temp.ap_`

## Project structure
| File | Purpose |
| --- | --- |
| `LogoQuiz.b4a` | Project definition and manifest |
| `B4XMainPage.bas` | App entry, dashboard, drawer menu |
| `B4XPageCategories.bas` | Category browser |
| `B4XPageGame.bas` | Quiz gameplay |
| `B4XPageLeaderboard.bas` | Top players (dummy) |
| `B4XPageSettings.bas` | Settings toggles |
| `B4XPageAbout.bas` | About / help |
| `DataManager.bas` | Dummy data + progress logic |
| `UI.bas` | Theme colors and view helpers |

## How to add / recode data
Open `DataManager.bas` -> `InitializeData`:

- Add a category:
  ```
  AddCategory("Music", "M", 0xFF00CEC9, "Music brand logos", 8)
  ```
- Add a logo:
  ```
  AddLogo("Music", "Spotify", "Hint: Green sound waves")
  ```

To change theme colors, edit constants in `UI.bas` (`CLR_PRIMARY`, etc.).
To change game rules (timer, rewards, penalties), edit `B4XPageGame.bas`
(`NewQuestion`, `Option_Click`, `RemoveTwo_Click`, etc.).
To add a new page, create a new `B4XPage*.bas`, register it in
`B4XMainPage.Initialize` with `B4XPages.AddPage`, and add a menu entry in
`BuildLeftMenu`.

## PayPal donations
If you find this project useful, donations (big or small) are welcome:
PayPal: `miraireri@gmail.com`

## License
Provided as a learning/example project. Use and recode freely. The reference
screenshots belong to their original author on CodeCanyon.