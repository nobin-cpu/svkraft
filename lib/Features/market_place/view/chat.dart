import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';

class WebViewExample extends StatefulWidget {
  final String id1, id2;
  WebViewExample({required this.id1, required this.id2});
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      gestureNavigationEnabled: true,
      backgroundColor: const Color(0x00000000),
      geolocationEnabled: true,
      initialUrl:
          'https://svkraft.shop/chat-room/' + widget.id1 + '/' + widget.id2,
    );
  }
}
