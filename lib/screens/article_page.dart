import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticlePage extends StatelessWidget {
  final String articleUrl;
  final String title;

  ArticlePage({this.articleUrl, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          this.title,
          style: TextStyle(color: Colors.white, fontSize: 14.0),
        ),
      ),
      body: Container(
        child: WebView(
          initialUrl: articleUrl,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
