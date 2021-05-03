import 'package:flutter/material.dart';
import 'package:pelbox_mobile/bloc/events/logout_events.dart';
import 'package:pelbox_mobile/bloc/logout_bloc.dart';
import 'package:pelbox_mobile/main.dart';
import 'package:pelbox_mobile/screens/account_screen.dart';
import 'package:pelbox_mobile/screens/member_orders_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberSettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MemberSettings();
  }
}

class MemberSettings extends State<MemberSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Member Settings'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout), 
              onPressed: () => _logoutMember()
            )
          ],
        ),
        body: Container(
          margin: EdgeInsets.all(17),
          child: ListView(
            children: [
              Container(
                child: Text(
                  'MEMBER SETTINGS',
                  style: TextStyle(
                    color: Color(0xffc3c2c9),
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AccountScreen())
                  );
                },
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_box_rounded,
                          size: 40,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Account',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_right_rounded
                        )
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5)
                    ),
                    color: Color.fromRGBO(255, 255, 255, 0.8)
                  ),
                ),
              ),
              SizedBox(
                height: 2
              ),
              InkWell(
                onTap: () => print('Billing'),
                child: Container(
                  color: Color.fromRGBO(255, 255, 255, 0.8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.payment,
                          size: 40,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Billing',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_right_rounded
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MemberOrdersScreen())
                  );
                },
                child: Container(
                  color: Color.fromRGBO(255, 255, 255, 0.8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add_shopping_cart_outlined,
                          size: 40,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Orders',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_right_rounded
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2
              ),
              InkWell(
                onTap: () => print('Notifications'),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.notification_important,
                          size: 40,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Notifications',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_right_rounded
                        )
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5)
                    ),
                    color: Color.fromRGBO(255, 255, 255, 0.8)
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  Future<void> _logoutMember() async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token');
    String refreshToken = prefs.getString('refresh_token');

    final _logoutBloc = LogoutBloc();
    _logoutBloc.logoutEventSink.add(LogoutMember(accessToken, refreshToken));
    Map response = await _logoutBloc.logout.first;
    
    if (response['success']) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => App()),
        (Route<dynamic> route) => false,
      );
    }
  }
}
