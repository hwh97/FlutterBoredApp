import 'dart:io';

import 'package:path_provider/path_provider.dart';

class PathUtil {
  String documentPath = "";
  String externalStoragePath = "";

  Future<PathUtil> init() async {
    this.documentPath = (await getApplicationDocumentsDirectory()).path;
    this.externalStoragePath = Platform.isAndroid
        ? (await getExternalStorageDirectory()).path
        : this.documentPath;
    return this;
  }
}
