import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

bool isFinished = false, isExerciseDone = false, alertQuit = false;

ChewieController chewieController;
bool disposed = false;
 Future<void> initializeVideoPlayerFuture;
 
  