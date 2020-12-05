import 'dart:io';

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:share/share.dart';
import 'package:whats_is/shared/contants.dart';
import 'package:whats_is/shared/save_to_gallery.dart';

class DisplayImage extends StatelessWidget {
  final File imagePath;
  final String imageName = 'Preview';

  DisplayImage({this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        textTheme: TextTheme(),
        title: Text(
          imageName ?? 'Image Viewer',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 11,
            child: InteractiveViewer(
              child: Image.file(this.imagePath),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  color: primaryColor,
                  textColor: Colors.white,
                  child: Text("Save to Gallery"),
                  onPressed: () => {
                    saveToGallery(this.imagePath)
                        .then(
                          (value) => context.showToast(msg: value),
                        )
                        .catchError(
                          (onError) => context.showToast(
                            msg: onError.toString(),
                          ),
                        )
                  },
                ),
                RaisedButton(
                  color: primaryColor,
                  textColor: Colors.white,
                  child: Text("Share"),
                  onPressed: () async {
                    Share.shareFiles(
                      [
                        this.imagePath.path,
                      ],
                      text: this.imageName,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
