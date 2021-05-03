import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pelbox_mobile/bloc/account_bloc.dart';
import 'package:pelbox_mobile/bloc/events/account_events.dart';
import 'package:pelbox_mobile/bloc/events/pelbox_events.dart';
import 'package:pelbox_mobile/bloc/pelbox_bloc.dart';
import 'package:pelbox_mobile/screens/box/box_connection_screen.dart';
import 'package:pelbox_mobile/screens/box/box_settings.dart';
import 'package:pelbox_mobile/screens/notifications/notifications_messages_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PelBoxScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PelBox();
  }
}

class PelBox extends State<PelBoxScreen> {
  int _numberOfNotifications;
  String _notificationBackgroundImage = 'assets/images/no_notifications.png';

  final int _boxDimensionWidth = 230;
  final int _boxDimensionHeight = 158;

  bool _hasDetails = false;
  bool _hasPelBoxSettings = false;

  List<dynamic> notifications = List<dynamic>();
  Map<String, dynamic> pelbox = Map<String, dynamic>();

  @override
  void initState() {
    super.initState();

    _getNumberOfNotifications();
    _getPelBoxDetails();
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Pelbox Control Center'),
        ),
        body: _hasDetails && _hasPelBoxSettings ? Container(
          margin: EdgeInsets.all(17),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NotificationsMessagesScreen(notifications))
                      ).then((value) {
                        setState(() {
                          _hasDetails = false;
                          _hasPelBoxSettings = false;
                        });

                        setState(() {
                          _getNumberOfNotifications();
                          _getPelBoxDetails();

                          _hasDetails = true;
                          _hasPelBoxSettings = true;
                        });
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(40))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'NOTIFICATIONS',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              )
                            ),
                            SizedBox(
                              width: 2
                            ),
                            Column(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      _notificationBackgroundImage,
                                      height: 25,
                                      width: 25
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      child: Text(
                                        _numberOfNotifications.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                        )
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(40))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            'TRACK YOUR PACKAGE',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            )
                          ),
                          Text(
                            'Locate your deliveries',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                            )
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Image.asset(
                            'assets/images/map.png',
                            width: 200,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                 InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BoxConnectionScreen())
                      ).then((value) {
                        setState(() {
                          _hasDetails = false;
                          _hasPelBoxSettings = false;
                        });

                        setState(() {
                          _getNumberOfNotifications();
                          _getPelBoxDetails();

                          _hasDetails = true;
                          _hasPelBoxSettings = true;
                        });
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(40))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'BOX CONNECTION',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                                SizedBox(
                                  height: 5
                                ),
                                Text(
                                  pelbox["connected"] ? "CONNECTED" : "OFFLINE",
                                  style: pelbox["connected"] ? TextStyle(
                                    color: Colors.green
                                  ) : null,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BoxSettingsScreen())
                        );
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(40))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              'BOX SETTINGS',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              )
                            ),
                            Text(
                              'Current box dimensions',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                              )
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 42, 0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                                    child: Text(
                                      '${_boxDimensionWidth.toString()}"',
                                      style: GoogleFonts.getFont(
                                        'Martel',
                                        textStyle: TextStyle(
                                          fontStyle: FontStyle.italic
                                        )
                                      )
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                                        child: Text(
                                          '${_boxDimensionHeight.toString()}"',
                                          style: GoogleFonts.getFont(
                                            'Martel',
                                            textStyle: TextStyle(
                                              fontStyle: FontStyle.italic
                                            )
                                          )
                                        ),
                                      ),
                                      Image.asset(
                                        'assets/images/box.png',
                                        width: 200,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ],
          ),
        )
        :
        Center(
          child: SpinKitCubeGrid(
            color: Colors.white,
            size: 50.0,
          ),
        ),
      ),
    );
  }

  Future<void> _getNumberOfNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token');

    final _accountBloc = AccountBloc();
    _accountBloc.accountEventSink.add(GetUnreadNotifications(accessToken));
    Map response = await _accountBloc.account.first;
    
    if (response['success']) {
      setState(() {
        notifications = response['message'];

        _numberOfNotifications = notifications.length;
        _notificationBackgroundImage = notifications.length == 0 ? 'assets/images/no_notifications.png' : 'assets/images/has_notifications.png';
        _hasDetails = true;
      });
    }
  }

  Future<void> _getPelBoxDetails() async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token');

    final _pelboxBloc = PelBoxBloc();
    _pelboxBloc.pelboxEventSink.add(BoxAllSettings(accessToken));
    Map response = await _pelboxBloc.pelbox.first;

    if (response['success']) {
      setState(() {
        pelbox = response['message'];
        for (String key in pelbox.keys) {
          pelbox[key] = pelbox[key] != null ? pelbox[key] : "";
        }

       _hasPelBoxSettings = true;
      });
    }

    final _pelboxBlocPing = PelBoxBloc();
    _pelboxBlocPing.pelboxEventSink.add(PingBox(accessToken));
    response = await _pelboxBlocPing.pelbox.first;

    if (response['success']) {
      setState(() {
        pelbox["connected"] = true;
      });
    } else {
      if (mounted) {
        setState(() {
          pelbox["connected"] = false;
        });
      }
    }
  }
}