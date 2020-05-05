# Athlete.co

Athlete.co is an application that is intended for training.
Everyone who wants to get their body and life into shape should use this application. The app is made in Flutter.
Through this application, people can develop, and make their bodies a super machine.

# Prerequisites
In order to run the application on emulator or on device (so far, it is runnable from IDE only), following is required:<br/>
•	Download Git and run Git Bash<br/>
•	Download Flutter and run flutter_console.bot<br/>
•	Download Andorid Studio for emulator<br/>
•	Copy path of bin folder (from Flutter installation folder) into system paths

# Installing
Get the project files, open the project from the IDE. After the device/emulator is connected, in order to run the application, type in terminal:
		flutter run
After some time, the application will be built on the device/emulator connected and it will be usasble on the device.


# Changes
**•	V1 – Sprint 1 (13.04. - 16.04.)<br/>** *
  	User story 1 - planning project, we have planned 
   planning of project architecture and structure.
   Arranging naming convention, code refactoring, class names, and class architectures.<br/><br/>*
   	User Story 2 – We created a splash screen, and sign in screen. In sign in screen we have logo of the app, and we have 3 buttons for sign up methods.
       One for google sign in, one for facebook., one for twitter.<br/><br/>*
   	User Story 3 -We created a autologin functionality. If user is signed in and quit the app, he doesn't have to sign up again.<br/><br/>*
    User Story 4 - In this user story we needed to show to the user available trainers and their training plan name, and duration, so that user can choose one from it.<br/><br/>


**•	V2 – Sprint 2 (16.04. - 21.04.)<br/>** *
  	User story 1 - Implementation of Training Plan Screen which is showed after user choses an athlete. All information about chosen training plan is showed and weeks of the plan are listed. For current week, all it workouts are listed and they are clickable. When use clicks on a workout, Workout Screen is showed. Also, user is able to contact the contact person wia WhatsApp by clicking on 'ANY QUESTION'.<br/><br/>*
   	User Story 2 – Implementation of Workout Screen which lists all Series and their Exercises with all details.<br/><br/>


**•	V3 – Sprint 3 (21.04. - 28.04.)<br/>** *
  	User story 1 - Implementation of starting a Workout and playing its videos. Functionalities implementes so far: Showing get ready screen at the very beginning of a workout for 5 seconds, Playing videos from list (starting from first one until last one), After each video showing rest screen for 10 seconds, After last video rest screen is not showed and user is redirected to Training Plan Screen, While in workout on back dialog box is showed and if accepted, user is redirected to Training Plan without saving the progress.<br/><br/>

 **•	V4 – Sprint 4 (28.04. - 05.05.)<br/>** *
  	User story 1 - AS a developer I want to implement threads so that Athlete app have better performance.<br/><br/>* DONE. We implemented threads, so that our app is working faster, videos are playing smoothly. 
    User story 2 - As a developer I want to have warmup as a single series in db so that I can firstly play video.<br/><br/>* DONE. Database reconstruction
	User story 3 - Online preview of videos. DONE. We are taking videos from our db. We are listing them and sorting by our wowrkouts, so if you select a workout you will see those videos playing.
	User story 4 - As a user I want to have all info about exercise I am doing, so that I can properly do it in the right way.<br/><br/>*  DONE <br/><br/>
