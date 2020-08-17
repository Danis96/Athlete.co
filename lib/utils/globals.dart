import 'package:flutter/material.dart';
import 'dart:async';

String userName,
    userEmail,
    userPhoto,
    userUIDPref,
    userTU,
    userTP,
    keyOfExercise;
int currentWeek = 0;
int totalWeeks = 0;
bool isLoggedIn = false, isTwitter = false, isTimerDone = false;
String name = '';
bool isPaused = false;
bool isReady = false;
OverlayEntry overlayEntryPaused;
OverlayState overlayStatePaused;
List<dynamic> allVideos;
List<dynamic> onlineVideos = [];
List<dynamic> onlineCovers = [];
List<dynamic> onlineWarmup = [];
List<dynamic> listOfBoundarySets = [0];
List<dynamic> onlineExercises = [];
List<dynamic> exerciseSnapshots = [];
bool isEmpty = false;
bool repsDone = false;
bool isEndPlaying = false;
bool restShowed = false;
bool focused = false;
bool loadingFinished = false;

/// for disabling android back button when rest and  ready are active
bool restGoing = false, readyGoing = false;
String userNotes = '';
String userNotesHistory = '';

///Couunters for note and info
bool infoClicked = true;
bool noteClicked = true;
OverlayState overlayState;
OverlayEntry overlayEntry;

Timer videoTimer;

/// for alert back exit on video
bool alertQuit = false;

/// [isTips] for paused, [goBackToChewie] is for orientation
bool isTips = false, goBackToChewie = false;

/// for checking are apps instaleld
bool isInstalled = false;

/// for skip rest feature
bool isRestSkipped = false;

/// list for sets
List<dynamic> workoutExercisesWithSets = [];
List<dynamic> namesWithSet = [];

/// for full training stopwatch
String displayTime = '00:00:00';
var swatch = Stopwatch();

/// for landscape mode from info and note
bool isFromPortrait = true;

/// from settings and chooseAthlete
bool isFromSettings = false;

///if index is 0 from previous or not
bool isPrevious = false;

/// when button done is pressed on time choose dialog
/// we set this to true to start timer
bool isTimeChoosed = false;
int minutesForIndicators = 0, secondsForIndicators = 0;
bool isTimerPaused = false;

/// activate pause from chewie on indicators
bool activatePause = false;

/// actiavte reset from chewie
bool resetFromChewie = false;

/// for reseting
bool reseted = false;

/// to show time
bool showTime = false;

/// for getting data
bool hasActiveConnection = false;

///for history
List<dynamic> finishedWeeks = [];

///for manual finishing workout
bool checked = false;

/// isDone for handling timer reset after done has update db
bool isDone = false;

/// isFromRepsOnly checking from which type of exercise is user coming
bool isFromRepsOnly = false;

int numOfSeries;

/// is Keyboard open 
FocusNode focusKeyboard;

