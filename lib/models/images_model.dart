import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

enum PickedFileType { image, video, document }

class FilesDataModel {
  GenericFile? file;
  List<GenericFile> filesList = [];
}

class GenericFile {
  static const List<String> allowExtensions = [
    ...imageExtensions,
    // ...videoExtensions,
    // ...documentExtensions,
  ];

  static const List<String> imageExtensions = [
    "png",
    "jpg",
    "jpeg",
    "pjpeg",
    "gif",
    "jfif",
  ];
  static const List<String> videoExtensions = [
    "mp4",
    "mov",
    "wmv",
    "avi",
    "mkv"
  ];

  static const List<String> documentExtensions = [
    "pdf",
    "txt",
    "xls",
    "xlsx",
    "csv",
    "doc",
    "docx"
  ];

  static PickedFileType? getFileType(String? extension) {
    extension = extension?.toLowerCase().replaceAll(".", "");
    if (imageExtensions.contains(extension)) return PickedFileType.image;
    if (videoExtensions.contains(extension)) return PickedFileType.video;
    return null;
  }

  final String filename;
  final String path;
  final PickedFileType? fileType;
  final Uint8List bytes;
  final Key key;
  final double? size;
  final String? extension;

  GenericFile._(
      {required this.filename,
      this.extension,
      required this.bytes,
      required this.path,
      this.size,
      required this.key,
      this.fileType});

  factory GenericFile.fromPlatformFile(PlatformFile file) {
    Uint8List? fileBytes = file.bytes;
    if (file.bytes == null && file.path != null) {
      fileBytes = File(file.path!).readAsBytesSync();
    }
    return GenericFile._(
      path: file.path ?? "",
      fileType: getFileType(file.extension),
      filename: file.name,
      bytes: fileBytes!,
      size: file.size.toDouble(),
      extension: file.extension,
      key: Key(
        DateTime.now().millisecondsSinceEpoch.toString(),
      ),
    );
  }

  static fromXFile(XFile file) async {
    return GenericFile._(
      path: file.path,
      fileType: getFileType(p.extension(file.name)),
      filename: file.name,
      bytes: await file.readAsBytes(),
      key: Key(
        DateTime.now().millisecondsSinceEpoch.toString(),
      ),
    );
  }
}
