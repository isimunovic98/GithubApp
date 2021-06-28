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
<img width="424" alt="Screenshot 2021-06-28 at 15 17 08" src="https://user-images.githubusercontent.com/68013386/123645590-c4614d00-d826-11eb-90b3-154d0e80959b.png">


## Getting Started

### Installing

* Libraries are imported using cocoapods, run pod install and pod update

## Authors

Ivan Simunovic 
