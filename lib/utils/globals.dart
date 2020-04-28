import 'package:flutter/material.dart';

String userName, userEmail, userPhoto;
int currentWeek = 0;
int totalWeeks = 0;
bool isLoggedIn = false;
String name = '';
bool isPaused = false;
bool isReady = false;
OverlayEntry overlayEntryPaused;
OverlayState overlayStatePaused;
