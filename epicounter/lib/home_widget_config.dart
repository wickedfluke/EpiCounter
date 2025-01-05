import 'dart:io';
import 'dart:typed_data';

import 'package:davinci/davinci.dart';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:path_provider/path_provider.dart';

class HomeWidgetConfig {
  static Future<void> update(BuildContext context, Widget widget) async {
    Uint8List bytes = await DavinciCapture.offStage(widget,
        context: context,
        returnImageUint8List: true,
        wait: const Duration(seconds: 1));

    final directory = await getApplicationSupportDirectory();
    File tempFile = File("${directory.path}/widget_image.png");
    await tempFile.writeAsBytes(bytes);

    await HomeWidget.saveWidgetData('filename', tempFile.path);
    await HomeWidget.updateWidget(
      iOSName: "AnimeWidget",
      androidName: "AnimeWidget",
    );
  }

  static Future<void> initialize() async {
    await HomeWidget.setAppGroupId("group.your.app");
  }
}
