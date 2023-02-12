import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';

class WebViewExam extends StatefulWidget {
  final String id1;
  WebViewExam({required this.id1});
  @override
  WebViewExamState createState() => WebViewExamState();
}

class WebViewExamState extends State<WebViewExam> {
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
      initialUrl: 'https://svkraft.shop/chat-room/' + widget.id1,
    );
  }
}
