import 'package:flutter/material.dart';


String userName, userEmail, userPhoto, userUIDPref, userTU, userTP;
int currentWeek = 0;
int totalWeeks = 0;
bool isLoggedIn = false, isTwitter = false;
String name = '';
bool isPaused = false;
bool isReady = false;
OverlayEntry overlayEntryPaused;
OverlayState overlayStatePaused;
