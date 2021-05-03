import 'package:flutter/material.dart';
import 'package:pelbox_mobile/forms/edit/edit_pelbox_security_key.dart';
import 'package:pelbox_mobile/screens/camera/view_camera_controller.dart';

class ViewCameraScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ViewCamera();
  }
}

class ViewCamera extends State<ViewCameraScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
            image: AssetImage('assets/images/background2.png'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('View Camera'),
        ),
        body: Container(
            margin: EdgeInsets.all(17),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Container(
                    width: 640, height: 269, child: ViewCameraController())
              ],
            )),
      ),
    );
  }
}
