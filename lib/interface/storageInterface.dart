import 'dart:io';

abstract class StorageInterface {
   Future<String> readData();
   Future<File> writeData(String data);
}