import 'package:flutter/material.dart';

class NotificationsModal extends StatelessWidget {
  final String _notification_title;
  final String _notification_text;
  final String _notification_image_url;
  final String _created_at;

  NotificationsModal(this._notification_title, this._notification_text, this._notification_image_url, this._created_at);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Text(
              this._notification_title,
              style: TextStyle(
                fontSize: 20
              ),
            ),
            SizedBox(
              height: 20
            ),
            Container(
              width: 300,
              height: 300,
              child: Image.network(
                _notification_image_url
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              _notification_text,
              style: TextStyle(
                fontSize: 14
              ),
            ),
          ],
        ),
      ),
    );
  }
}