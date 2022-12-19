# Trending Repos

## Architecture
I used MVP with clean architecture layers.
- Presentation: for ui scenes.
- Domain: for business logic.
- Data: for data repos.

Please refer to this url for the architecture diagram
https://drive.google.com/file/d/1pqp3zURdyRLNVFYzE_feUEh0BWhM0x3o/view?usp=sharing

## Assumptions
The app displays a list of repos, each cell has the following info:
- repo owner avatar
- repo owner name
- repo title
- repo description
- repo number of starts
- repo language

App Behavior:
For the first time app is launched, app will fetch the repos from the api, if it fails, a network error view is displayed.
On further launches, as long as repos haven't been fetched successfully before, the app will hit the endpoint to fetch the available repos.
If repos have been loaded before, on app launch app will display the locally stored repos.
When user pulls to refresh, app will try to fetch the remote repos and display them when there is no network issue, otherwise it will fallback to the local ones.
Each time the repos are fetched from the api, the local cache will be updated. 

## Milestones
Development happened on multiple branches, I followed TDD approach.
1. chore/project-setup: general configuration of the app.
2. chore/architecture-setup: Initial layout of the components and their interactions.
3. feat/Repos-list-viewcontroller-behavior: the behavior of the view controller and its interaction with the presenter (display logic)
4. feat/repos-list-cell-behavior: the configuration of the cell.
5. feat/repos-list-presenter-behavior: the behavior of the presenter and its interaction with its dependencies ( presentation logic )
6. feat/repos-list-interactor-behavior: the implementation of the business logic
7. feat/repos-list-clients-behavior: for setting up remote and local clients.
8. feat/integration: when all components are integrated to together to run and test the app and enhance the visuals.

Then all these branches were merged into the main branch.
I used this trello board to help me plan the task ahead and during development.
https://trello.com/invite/b/LzweBhSv/ATTI4fba9e2f3c6b96e1ded6cf9138cbbeaf6ABDDBF1/trending-project

## Dependencies
- Networking: URLSession.
- Local Storage: Userdefaults.
- Lottie animation
- Shimmering: https://github.com/omerfarukozturk/UIView-Shimmer
- ImageLoading: https://github.com/onevcat/Kingfisher

## General Notes
- LocalStorageClient, and NetworkClient are there for the ease of testing of networkService and localService, and to easily swap the clients, for example swapping URLSession with alamofire, and UserDefaults with any local storage alternative.
- Repo language is modeled as string, If the possible languages were mentioned anywhere, I would have modeled it as enum.

