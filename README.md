# GithubApp

Application allows user to search repositories and/or users on Github.

## Description

This application was made to show my understanding of Combine framework and MVVM arhitecture while usin Coordinator pattern for navigation. 
When started user can choose to search github for users, repositories or both. After typing search querry and tapping 'search' button request is sent to 
github api, new screen is shown and results populate table view. Users and Repository results are shown in seperate tabs from which user can search again with
different querry. Tabs are made using 'Tabman' (https://github.com/uias/Tabman). Application also implements Webview and can open results in external browser if selected.

## Implementation

** UIKit
** MVVM arhitecure
** Combine framework
** TableView
** Tabman
** WebView
** Coordinators

## Screenshots
<img width="568" alt="Screenshot 2021-06-28 at 15 18 19" src="https://user-images.githubusercontent.com/68013386/123645724-db07a400-d826-11eb-8392-599e5e58e6a3.png">
<img width="568" alt="Screenshot 2021-06-28 at 15 19 46" src="https://user-images.githubusercontent.com/68013386/123645738-de9b2b00-d826-11eb-8b0b-f4bc1f5df478.png">
<img width="568" alt="Screenshot 2021-06-28 at 15 36 24" src="https://user-images.githubusercontent.com/68013386/123645746-e064ee80-d826-11eb-84ea-1eeb0b0bb468.png">
<img width="568" alt="Screenshot 2021-06-28 at 15 36 33" src="https://user-images.githubusercontent.com/68013386/123645751-e22eb200-d826-11eb-892d-20b6156bee2c.png">

## Getting Started

### Installing

* Libraries are imported using cocoapods, run pod install and pod update

## Authors

Ivan Simunovic 
