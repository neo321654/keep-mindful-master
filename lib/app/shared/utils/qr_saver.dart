import 'dart:io';
import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';

class QrSaver {
  Future<void> saveImageToGallery(RenderRepaintBoundary boundary) async {
    try {
      final image = await boundary.toImage();
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/keep_mindful_qr.png').create();
      await file.writeAsBytes(pngBytes);
      await Gal.putImage(file.path);
    } catch (_) {
      //TODO: Add implementation
    }
  }
}
