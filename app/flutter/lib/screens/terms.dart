import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:whats_is/widgets/app_drawer.dart';

class TermsScreen extends StatefulWidget {
  @override
  _TermsScreenState createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  bool isLoading = true;
  final _key = UniqueKey();

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms & Privacy'),
      ),
      drawer: CustomAppDrawer(),
      body: WebView(
        key: _key,
        initialUrl: 'https://www.epix.io/terms-policy',
        gestureNavigationEnabled: false,
        javascriptMode: JavascriptMode.disabled,
        onPageFinished: (String url) {
          setState(() {
            isLoading = false;
          });
        },
      ),
    );
  }
}
