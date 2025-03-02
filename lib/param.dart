import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:file_picker/file_picker.dart';

const double scaleFactor = 2;

final class ThemeColors {
  static const Color blue = Color.fromRGBO(91, 152, 221, 1);
  static const Color lightWhite = Color.fromRGBO(255, 255, 255, 0.6);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color green = Color.fromRGBO(46, 183, 160, 1);
  static const Color yellow = Color.fromRGBO(220, 162, 68, 1);
  static const Color red = Color.fromRGBO(192, 91, 73, 1);
}

final class BackgroundColors {
  static const Color navigationBar = Color.fromRGBO(40, 42, 57, 1);
  static const Color slidebar = Color.fromRGBO(24, 25, 32, 1);
  static const Color slidebarItem = Color.fromRGBO(47, 49, 62, 1);
  static const Color body = Color.fromRGBO(30, 29, 36, 1);
  static const Color information = Color.fromRGBO(255, 255, 255, 0.05);
  static const Color line = Color.fromRGBO(170, 170, 170, 0.5);
}

Logger logger = Logger();

class ThemeTextStyle extends TextStyle {
  const ThemeTextStyle({
    super.color,
    super.fontSize,
    super.fontWeight=FontWeight.normal,
    super.height,
  }) : super(
    fontFamily: 'Microsoft YaHei',
  );
}

String getFileNameWithoutExtension(String fileName) {
  if (fileName.contains('.')) {
    return fileName.split('.').sublist(0, fileName.split('.').length - 1).join('.');
  } else {
    return fileName;
  }
}

Future<void> pickFile(Function(String) setFileFun) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  if (result != null) {
    PlatformFile file = result.files.first;
    String fileName = getFileNameWithoutExtension(file.name);
    setFileFun(fileName);
  } 
}
