import 'package:flutter/material.dart';

class NotificationCard extends StatefulWidget {
  final String _notification_title;
  final String _notification_text;
  final String _notification_image_url;
  final String _created_at;
  final Color _color;

  NotificationCard(this._notification_title, this._notification_text, this._notification_image_url, this._created_at, this._color);

  @override
  State<StatefulWidget> createState() {
    return NotificationInformation(_notification_title, _notification_text, _notification_image_url, _created_at, this._color);
  }
}

class NotificationInformation extends State<NotificationCard> {
  final String _notification_title;
  final String _notification_text;
  final String _notification_image_url;
  final String _created_at;
  final Color _color;

  NotificationInformation(this._notification_title, this._notification_text, this._notification_image_url, this._created_at, this._color);

  void _refresh() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _color.withOpacity(0.8),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text(
              _notification_title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date: $_created_at',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          _notification_text,
                          style: TextStyle(
                            color: Colors.black
                          )
                        )
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}