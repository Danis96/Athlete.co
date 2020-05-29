import 'dart:io';
import 'package:path_provider/path_provider.dart';

class AppUtil {
  static Future<String> createFolderInAppDocDirectory(String folderName) async {
    /// get this app document directory
    final Directory _appDocDir = await getApplicationDocumentsDirectory();

    /// app documents directory + folder name
    final Directory _appDocDirFolder =
        Directory('${_appDocDir.path}/$folderName/');

    if (await _appDocDirFolder.exists()) {
      return _appDocDirFolder.path;
    } else {
      final Directory _appDocDirectoryNewFolder =
          await _appDocDirFolder.create(recursive: true);
      return _appDocDirectoryNewFolder.path;
    }
  }
}


