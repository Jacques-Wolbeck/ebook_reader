import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:ebook_reader/shared/models/book_model.dart';
import 'package:ebook_reader/views/widgets/app_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';
import 'package:dio/dio.dart';

class BookView extends StatefulWidget {
  final BookModel book;
  const BookView({super.key, required this.book});

  @override
  State<BookView> createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  final platform = const MethodChannel('my_channel');
  bool loading = false;
  Dio dio = Dio();
  String filePath = "";
  @override
  void initState() {
    _download();
    super.initState();
  }

  _download() async {
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
        await startDownload();
      } else {
        if (await Permission.storage.isGranted) {
          await Permission.storage.request();
          await startDownload();
        } else {
          await startDownload();
        }
      }
    } else {
      loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          centerTitle: true,
          title: Text(widget.book.title),
        ),
        body: _body(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pop(context),
          child: Icon(Icons.back_hand),
        ));
  }

  Widget _body() {
    return SafeArea(
      child: Center(
          child: loading
              ? const Column(
                  children: [Text('Baixando E-pub...'), AppProgressIndicator()],
                )
              : ElevatedButton(
                  onPressed: () {
                    if (filePath == "") {
                      _download();
                    } else {
                      VocsyEpub.setConfig(
                        themeColor: Theme.of(context).primaryColor,
                        identifier: "book",
                        scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
                        allowSharing: true,
                        enableTts: true,
                        nightMode: false,
                      );

                      // get current locator
                      VocsyEpub.locatorStream.listen((locator) {
                        print('LOCATOR: $locator');
                      });
                      VocsyEpub.open(
                        filePath,
                        lastLocation: EpubLocator.fromJson({
                          "bookId": "2239",
                          "href": "/OEBPS/ch06.xhtml",
                          "created": 1539934158390,
                          "locations": {
                            "cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"
                          }
                        }),
                      );
                    }
                  },
                  child: const Text('Fazer download'))),
    );
  }

  startDownload() async {
    setState(() {
      loading = true;
    });
    Directory? appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    String path = appDocDir!.path + '/sample.epub';
    File file = File(path);

    if (!File(path).existsSync()) {
      await file.create();
      await dio.download(
        "https://vocsyinfotech.in/envato/cc/flutter_ebook/uploads/22566_The-Racketeer---John-Grisham.epub",
        path,
        deleteOnError: true,
        onReceiveProgress: (receivedBytes, totalBytes) {
          print('Download --- ${(receivedBytes / totalBytes) * 100}');
          setState(() {
            loading = true;
          });
        },
      ).whenComplete(() {
        setState(() {
          loading = false;
          filePath = path;
        });
      });
    } else {
      setState(() {
        loading = false;
        filePath = path;
      });
    }
  }
}
