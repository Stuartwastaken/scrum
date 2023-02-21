# Project SCRUM

SCRUM is an educational web application that promotes the eduction of Agile methodologies and their components. Instructors who have created an account with SCRUM are allowed to create, host, and download educational quizzes. Local competitions, named SCRUM battles, allow students to test their knowledge against thier peers. Questions are displayed on a shared screen, and participants use their own devices (such as smartphones or tablets) to submit their answers. Participants earn points for correct answers, and the leaderboard is displayed after each question, adding an element of friendly competition. Project SCRUM is built upon the Flutter framework and utilizes Google's Firebase authentication, firestore database, and realtime database services.   

## Getting Started

This repository contains the working components of our application. The repository code is preloaded with some basic components like basic app architecture, database connectivity, and required dependencies to render our project.

## How to Use

**Step 1**
It is recommended to use Visual Studio Code as your code editor, which can be downloaded [here](https://code.visualstudio.com/download). 

**Step 2**
_Install or upgrade to the latest version of Flutter. Follow these installation [guides.](https://docs.flutter.dev/get-started/install)_

**Step 3**
_Install the latest Firebase CLI. Folllow these installation[guides.](https://firebase.google.com/docs/cli#setup_update_cli)_

**Step 4**
Download or clone this repo by using the link below:
```
https://gitlab.com/team-one9490505/scrum.git`
```

**Step 5**
Go to project root and execute the following command in console to get the required dependencies:
```
flutter pub get 
```
**Step 6**
Execute the following command in console to execute the application:
```
flutter run -d chrome
```

## Folder Structure

Here is the folder structure we have been using in this project
```
lib/
|- screens/
|- widgets/
|- main.dart
```
Now, lets dive into the lib folder which has the main code for the application.
```
1- screens - Directory containing the viewable screens are defined in this directory with-in their respective files. 
2- widgets — Directory containing the common widgets for your applications. For example, Button, TextField etc.
3- main.dart - This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.
```