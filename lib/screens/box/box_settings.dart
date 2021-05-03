import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pelbox_mobile/bloc/events/pelbox_events.dart';
import 'package:pelbox_mobile/bloc/pelbox_bloc.dart';
import 'package:pelbox_mobile/screens/edit/edit_dismantle.dart';
import 'package:pelbox_mobile/screens/edit/edit_expand_box.dart';
import 'package:pelbox_mobile/screens/edit/edit_set_lock_unlock.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoxSettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BoxSettings();
  }
}

class BoxSettings extends State<BoxSettingsScreen> {
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
            title: Text('Box Settings'),
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
                              builder: (context) => EditSetLockUnlock(
                              pelbox['locked']))).then((value) {
                                setState(() {
                                  _hasPelBoxSettings = false;
                                });

                                setState(() {
                                  _getPelBoxDetails();
                                });
                            })
                        } else {
                          Fluttertoast.showToast(msg: 'You can\'t lock your box since it is in state of dismantle')
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
                                'Locked',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                pelbox != null && pelbox['locked'] ? 'Yes' : 'No',
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
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditDismantle(
                            pelbox['dismantle']))).then((value) {
                              setState(() {
                                _hasPelBoxSettings = false;
                              });

                              setState(() {
                                _getPelBoxDetails();
                              });
                           })
                      },
                      child: Container(
                        height: 55,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Dismantled',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                pelbox != null && pelbox['dismantle'] ? 'Yes' : 'No',
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
                    InkWell(
                      onTap: () => {
                        if (pelbox != null && pelbox['dismantle'] != true) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditExpandBox(
                              pelbox['expanding_value']))).then((value) {
                                setState(() {
                                  _hasPelBoxSettings = false;
                                });

                                setState(() {
                                  _getPelBoxDetails();
                                });
                            })
                        } else {
                          Fluttertoast.showToast(msg: 'You can\'t expand your box since it is in state of dismantle')
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
                                'Expanding',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                pelbox != null ? pelbox['expanding_value'].toString() : '0',
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
    _pelboxBloc.pelboxEventSink.add(GetBoxLocking(accessToken));
    Map response = await _pelboxBloc.pelbox.first;

    if (response['success']) {
      setState(() {
        pelbox = response['settings'];
        for (String key in pelbox.keys) {
          pelbox[key] = pelbox[key] != null ? pelbox[key] : "";
        }

        _hasPelBoxSettings = true;
      });
    }
  }
}
