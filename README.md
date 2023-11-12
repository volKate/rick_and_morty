# Rick and Morty

Test project

## Screens

- Launch Screen
- Episodes (main screen of the app)
- Character details (details page for selected character from selected episode)
- Favourites (episodes saved to favourites)

## Requirements

- You cannot use package managers
- Implement using UIKit
- UI should be implemented in code
- iOS Deployment Target 14.0

## Features implemented
### Launch Screen
- Show screen for three seconds +1
- Animate "portal" to spin when screen is visible +2
- redirect to Episodes screen after three seconds

### Episodes
- Add TabBar with two tabs: episodes, favourites +1
- On Episodes and Favourites pages add UINavigationController +1
- Use UICollectionView to create episodes collection +1
- Implement setting episode name and code +2
- Implement setting random character name and Image +3
- Implement pagination for episodes. More episodes are loaded when close to scroll bottom +3
- On character image tap open details page +1
- Tap on heart icon makes it red +1
- Tap on heart icon adds episode to "Favourites", next tap on same icon makes it blue outlined and removes episode from "Favourites" +3
- Implement search by episode number +2
- Filter: add ability to choose by which field episodes should be filtered (I implement by name and episode) +3

### Details page
- Implment Details page +1
- Use UITableView to implement details +2
- Add icon to NavBar +2

### Favourites
- Implement screen +1
- Tap on heart should remove episode from favourites +1 (I let episodes remain on the creen from UX point of view, but they are removed from array and on re-entering the page, they will no longer appear on screen)
- On character image tap open details page +1
- On switching app off and on, favourite episodes should persist +3

## Features sum score
**35**
