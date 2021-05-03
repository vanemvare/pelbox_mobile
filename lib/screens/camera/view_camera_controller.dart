import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewCameraController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ViewCamera();
  }
}

class ViewCamera extends State<ViewCameraController> {
  @override
  void initState() {
    super.initState();
    _getCameraInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: WebView(
        initialUrl: "http://192.168.1.158:8081/index.html",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }

  void _getCameraInformation() {}
}
