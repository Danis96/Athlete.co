import 'package:flutter/material.dart';


String userName, userEmail, userPhoto, userUIDPref, userTU, userTP, keyOfExercise, exerciseNameForInfo;
int currentWeek = 0;
int totalWeeks = 0;
bool isLoggedIn = false, isTwitter = false, isInfo = false;
String name = '';
bool isPaused = false;
bool isReady = false;
OverlayEntry overlayEntryPaused;
OverlayState overlayStatePaused;
List<dynamic> exerciseTipsforView;
List<dynamic> allVideos;
