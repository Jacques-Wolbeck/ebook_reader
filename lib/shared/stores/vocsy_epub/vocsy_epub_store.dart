import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:ebook_reader/shared/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
part 'vocsy_epub_store.g.dart';

class VocsyEpubStore = _VocsyEpubStore with _$VocsyEpubStore;

abstract class _VocsyEpubStore with Store {
  final dio = Dio();
  @observable
  String filePath = "";
  @observable
  bool isLoading = false;

  @action
  Future<void> download(BookModel book) async {
    if (Platform.isAndroid || Platform.isIOS) {
      String? firstPart;
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.deviceInfo;
      final allInfo = deviceInfo.data;
      if (allInfo['version']["release"].toString().contains(".")) {
        int indexOfFirstDot = allInfo['version']["release"].indexOf(".");
        firstPart = allInfo['version']["release"].substring(0, indexOfFirstDot);
      } else {
        firstPart = allInfo['version']["release"];
      }
      int intValue = int.parse(firstPart!);
      if (intValue >= 13) {
        await startDownload(book);
      } else {
        if (await Permission.storage.isGranted) {
          await Permission.storage.request();
          await startDownload(book);
        } else {
          await startDownload(book);
        }
      }
    } else {
      isLoading = false;
    }
  }

  @action
  Future<void> startDownload(BookModel book) async {
    isLoading = true;
    Directory? appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    final fileName = Uri.parse(book.downloadUrl).pathSegments.last;
    String fileExtension = 'epub3';
    if (fileName.contains('.epub')) {
      fileExtension = 'epub';
    }

    String path = '${appDocDir!.path}/$fileName.$fileExtension';
    File file = File(path);

    if (!File(path).existsSync()) {
      await file.create();
      await dio.download(
        book.downloadUrl,
        path,
        deleteOnError: true,
        onReceiveProgress: (receivedBytes, totalBytes) {
          debugPrint('Download --- ${(receivedBytes / totalBytes) * 100}');
          isLoading = true;
        },
      ).whenComplete(() {
        isLoading = false;
        filePath = path;
      });
    } else {
      isLoading = false;
      filePath = path;
    }
  }
}
