import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


String userName, userEmail, userPhoto, userUIDPref, userTU, userTP, keyOfExercise, exerciseNameForInfo;
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
List<dynamic> onlineWarmup = [];
List<dynamic> onlineExercises = [];
List<dynamic> exerciseSnapshots = [];
bool isEmpty = false;
bool repsDone = false;
bool isEndPlaying = false;
bool restShowed = false; 
/// for disabling android back button when rest and  ready are active
bool restGoing = false, readyGoing = false;
String userNotes = '';

bool alertQuit = false;
