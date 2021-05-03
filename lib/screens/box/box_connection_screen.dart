import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pelbox_mobile/bloc/events/pelbox_events.dart';
import 'package:pelbox_mobile/bloc/pelbox_bloc.dart';
import 'package:pelbox_mobile/forms/edit/edit_pelbox_security_key.dart';
import 'package:pelbox_mobile/screens/camera/view_camera_screen.dart';
import 'package:pelbox_mobile/screens/edit/edit_security_key_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BoxConnectionScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BoxConnection();
  }
}

class BoxConnection extends State<BoxConnectionScreen> {
  bool _hasPelBoxSettings = false;
  Map<String, dynamic> pelbox = Map<String, dynamic>();

  @override
  void initState() {
    super.initState();
    _getPelBoxDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
            image: AssetImage('assets/images/background2.png'),
            fit: BoxFit.cover),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text('Connection Settings'),
          ),
          body: _hasPelBoxSettings
              ? Container(
                  margin: EdgeInsets.all(17),
                  child: ListView(children: [
                    Container(
                      child: Text(
                        'PELBOX SETTINGS',
                        style: TextStyle(
                            color: Color(0xffc3c2c9),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () => {
                        if (pelbox != null && pelbox['dismantle'] != true) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditSecurityKeyScreen(
                                      pelbox['user_security_key'],
                                      pelbox['security_key']))).then((value) {
                            setState(() {
                              _hasPelBoxSettings = false;
                            });

                            setState(() {
                              _getPelBoxDetails();
                              _hasPelBoxSettings = true;
                            });
                          })
                        } else {
                          Fluttertoast.showToast(msg: 'Box is in dismantle state, can\'t open camera')
                        }
                      },
                      child: Container(
                        height: 55,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Security key',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                pelbox['user_security_key'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5)),
                            color: Colors.white.withOpacity(0.8)),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    InkWell(
                      onTap: () { 
                        if (pelbox != null && pelbox['user_security_key'] != "" && pelbox['dismantle'] != true) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ViewCameraScreen())).then((value) {
                                setState(() {
                                  _hasPelBoxSettings = false;
                                });

                                setState(() {
                                  _getPelBoxDetails();
                                  _hasPelBoxSettings = true;
                                });
                              });
                        } else if (pelbox['user_security_key'] == "") {
                          Fluttertoast.showToast(msg: 'Please enter your security key');
                        } else if (pelbox['dismantle'] == true) {
                          Fluttertoast.showToast(msg: 'Box is in dismantle state, can\'t open camera');
                        }
                      },
                      child: Container(
                        height: 55,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Open the camera',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8)),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                  ]),
                )
              : Center(
                  child: SpinKitCubeGrid(
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
        ),
      ),
    );
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
  }
}
