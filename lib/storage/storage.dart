
import 'dart:io';

import 'package:attt/interface/storageInterface.dart';
import 'package:path_provider/path_provider.dart';

class Storage implements StorageInterface {

  /// get local path 
   Future<String> get localPath async {
      final dir = await getApplicationDocumentsDirectory();
      return dir.path;
   }

   /// getter for local file
   Future<File> get localFile async {
      final path = await localPath;
      return File('$path/videoLinks.txt');
   }

   /// function for read data from this file 
   @override
   Future<String> readData() async {
     try {

       final file = await localFile;
       String body = await file.readAsString();
       return body;

     } catch (e) {
        return e.toString();
     }
   }

   @override 
   Future<File> writeData(String data) async {
      final file = await localFile;
      return file.writeAsString('$data'); 
   }
}