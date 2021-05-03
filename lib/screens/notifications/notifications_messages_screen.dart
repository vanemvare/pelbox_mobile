import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pelbox_mobile/bloc/account_bloc.dart';
import 'package:pelbox_mobile/bloc/events/account_events.dart';
import 'package:pelbox_mobile/screens/cards/notification_card.dart';
import 'package:pelbox_mobile/screens/modals/notification_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsMessagesScreen extends StatefulWidget {
  final List<dynamic> _notifications;

  NotificationsMessagesScreen(this._notifications);

  @override
  State<StatefulWidget> createState() {
    return NotificationsMessages(_notifications);
  }

}

class NotificationsMessages extends State<NotificationsMessagesScreen> {
  final List<dynamic> _notifications;

  NotificationsMessages(this._notifications);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage('assets/images/background2.png'),
          fit: BoxFit.cover
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Notifications'),
            backgroundColor: Colors.transparent,
          ),
          body: _notifications.length > 0 ? Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.all(17),
            child: ListView(
              children: _notifications.map((notification) {
                return InkWell(
                  onTap: () {
                    _readNotification(notification["id"].toString());
                    showBarModalBottomSheet(
                      context: context,
                      builder: (context) => SingleChildScrollView(
                        controller: ModalScrollController.of(context),
                        child: Container(
                          margin: EdgeInsets.all(17),
                          child: NotificationsModal(notification["notification_title"], notification["notification_text"], notification["notification_image_url"], notification["created_at"])
                        ),
                      ),
                    );
                  },
                  child: NotificationCard(notification["notification_title"], notification["notification_text"], notification["notification_image_url"], notification["created_at"], Colors.white),
                );
              }).toList()
            ),
          )
          :
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.notifications_none_rounded,
                  color: Colors.white,
                  size: 150,
                ),
                Text(
                  'No new notifications!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30
                  )
                )
              ],
            ),
          )
        ) 
      ),
    );
  }

  Future<void> _readNotification(String id) async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token');
      
    final _accountBlock = AccountBloc();
    _accountBlock.accountEventSink.add(ReadNotification(accessToken, id));
  }
}