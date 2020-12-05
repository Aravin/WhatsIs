import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:whats_is/widgets/app_drawer.dart';
import 'package:whats_is/widgets/bottom_navigation_bar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whats_is/screens/image_viewer.dart';
import 'package:whats_is/shared/save_to_gallery.dart';

class StatusViewerScreen extends StatefulWidget {
  @override
  _StatusViewerScreenState createState() => _StatusViewerScreenState();
}

class _StatusViewerScreenState extends State<StatusViewerScreen> {
  Future<List<File>> _statusImages() async {
    var status = await Permission.storage.request();

    if (status.isDenied) {
      context.showToast(
          msg: 'Permissied Required to view/download WhatsApp Status');
      openAppSettings();
      return [];
    }

    final dir = Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');

    if (dir.existsSync() == false) {
      return [];
    }
    List<File> _images = [];
    var files = dir.listSync().toList();

    files.forEach((e) {
      if (e.path.split('.').length > 2 && e.path.split('.')[2] == 'jpg') {
        _images.add(e);
      }
    });

    return _images;
  }

  Future<List<File>> _statusVideos() async {
    final dir = Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');
    List<File> _videos = [];

    var files = dir.listSync().toList();

    files.forEach((e) {
      if (e.path.split('.')[2] == 'mp4') {
        _videos.add(e);
      }
    });

    return _videos;
  }

  Future<List<File>> _showDownloadedImages() async {
    final appDir = await getApplicationDocumentsDirectory();
    List<File> _images = [];
    String filePath = appDir.path + '/status/images/';
    // print(dir.existsSync()); // <---- it also print: false

    if (!Directory(filePath).existsSync()) {
      Directory(filePath).createSync(recursive: true);
    }

    var files = Directory(filePath).listSync().toList();

    files.forEach((e) {
      print(e.path);
      // if (e.path.split('.')[2] == 'jpg') {
      _images.add(e);
      // }
    });

    return _images;
  }

  Future<String> _deleteFromGallery(File fileToDelete) async {
    String result = '';

    await File(fileToDelete.path)
        .delete()
        .then((value) => result = 'Image Deleted Successfully from Gallery!')
        .catchError(
          (onError) => result = onError.message.toString(),
        );

    return result;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('WhatsApp Status'),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.image),
                text: 'New Status',
              ),
              Tab(
                icon: Icon(Icons.download_done_rounded),
                text: 'Downloaded',
              ),
            ],
          ),
        ),
        drawer: CustomAppDrawer(),
        body: TabBarView(
          children: [
            FutureBuilder<List<File>>(
              future: _statusImages(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<File>> snapshot) {
                if (snapshot.hasData && snapshot.data.length == 0) {
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        'No Status Found!'.text.bold.makeCentered(),
                        HeightBox(20),
                        '1. Open WhatsApp'.text.makeCentered(),
                        '2. Go to Status Screen, watch the status'
                            .text
                            .makeCentered(),
                        '3. Come Back to this App'.text.makeCentered(),
                      ],
                    ),
                  );
                }
                if (snapshot.hasData) {
                  return GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(
                      snapshot.data?.length ?? 0,
                      (index) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 500,
                              height: 500,
                              child: GestureDetector(
                                child: Image.file(
                                  snapshot.data[index],
                                  fit: BoxFit.cover,
                                ),
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctxt) => DisplayImage(
                                      imagePath: snapshot.data[index],
                                    ),
                                  ),
                                ),
                              ),
                            ).p(2),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                color: Colors.lightGreen[50],
                                child: IconButton(
                                  onPressed: () => {
                                    saveToGallery(snapshot.data[index])
                                        .then(
                                          (value) => setState(() {
                                            context.showToast(msg: value);
                                          }),
                                        )
                                        .catchError(
                                          (onError) => context.showToast(
                                            msg: onError.toString(),
                                          ),
                                        )
                                  },
                                  icon: Icon(
                                    Icons.download_rounded,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return 'Error: ${snapshot.error}'.text.makeCentered();
                } else {
                  return SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  );
                }
              },
            ),
            FutureBuilder<List<File>>(
              future: _showDownloadedImages(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<File>> snapshot) {
                if (snapshot.hasData && snapshot.data.length == 0) {
                  return 'No Downloaded Images Found'.text.bold.makeCentered();
                }
                if (snapshot.hasData) {
                  return GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(
                      snapshot.data?.length ?? 0,
                      (index) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 500,
                              height: 500,
                              child: GestureDetector(
                                child: Image.file(
                                  snapshot.data[index],
                                  fit: BoxFit.cover,
                                ),
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctxt) => DisplayImage(
                                      imagePath: snapshot.data[index],
                                    ),
                                  ),
                                ),
                              ),
                            ).p(2),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                color: Colors.redAccent[50],
                                child: IconButton(
                                  onPressed: () => {
                                    _deleteFromGallery(snapshot.data[index])
                                        .then(
                                          (value) => setState(() {
                                            context.showToast(msg: value);
                                          }),
                                        )
                                        .catchError(
                                          (onError) => context.showToast(
                                            msg: onError.toString(),
                                          ),
                                        )
                                  },
                                  icon: Icon(
                                    Icons.delete_rounded,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return 'Error: ${snapshot.error}'.text.makeCentered();
                } else {
                  return SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  );
                }
              },
            ),
          ],
        ),
        bottomNavigationBar: CustomNavigationBar(currentIndex: 1),
      ),
    );
  }
}
