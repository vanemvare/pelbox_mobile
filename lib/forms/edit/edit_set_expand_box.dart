import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pelbox_mobile/bloc/events/pelbox_events.dart';
import 'package:pelbox_mobile/bloc/pelbox_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditSetExpandBox extends StatefulWidget {
  final int _expandingValue;

  EditSetExpandBox(this._expandingValue);

  @override
  State<StatefulWidget> createState() {
    return SetLockUnlockBox(this._expandingValue);
  }
}

class SetLockUnlockBox extends State<EditSetExpandBox> {
  final _formKey = GlobalKey<FormState>();

  int _expandingValue;

  final _pelboxBloc = PelBoxBloc();

  bool _updatingState = false;

  SetLockUnlockBox(this._expandingValue) {}
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: _updatingState
          ? Center(
              child: SpinKitCubeGrid(
                color: Colors.white,
                size: 50.0,
              ),
            )
          : Column(
              children: [
                Text(
                  '$_expandingValue',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 150,
                      height: 43,
                      child: RaisedButton(
                        onPressed: () =>
                            _updateExpandingValue(_expandingValue - 1),
                        child: Icon(Icons.remove, color: Colors.white),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: Colors.red,
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 43,
                      child: RaisedButton(
                        onPressed: () =>
                            _updateExpandingValue(_expandingValue + 1),
                        child: Icon(Icons.add, color: Colors.white),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: Color(0xff078dff),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 150,
                      height: 43,
                      child: RaisedButton(
                        onPressed: () => _updateExpandingValue(0),
                        child: Icon(Icons.call_received, color: Colors.white),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: Colors.red,
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 43,
                      child: RaisedButton(
                        onPressed: () => _updateExpandingValue(5),
                        child: Icon(Icons.north_east, color: Colors.white),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: Color(0xff078dff),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 150,
                      height: 43,
                      child: RaisedButton(
                        onPressed: () => _updateDoorStatus("close"),
                        child: Text(
                          'CLOSE DOOR',
                          style: TextStyle(color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: Colors.red,
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 43,
                      child: RaisedButton(
                        onPressed: () => _updateDoorStatus("open"),
                        child: Text(
                          'OPEN DOOR',
                          style: TextStyle(color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: Color(0xff078dff),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  Future<void> _updateExpandingValue(int newValue) async {
    final int leftValue = 0;
    final int rightValue = 5;
    if (newValue < leftValue || newValue > rightValue) {
      _createAlertDialog(context, 'Error',
          'Value can be in range between $leftValue and $rightValue');
      return;
    }

    setState(() {
      _updatingState = true;
      _expandingValue = newValue;
    });

    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token');

    _pelboxBloc.pelboxEventSink
        .add(UpdateExpandingValue(accessToken, newValue));
    Map response = await _pelboxBloc.pelbox.first;

    if (response['success'] == false) {
      _createAlertDialog(
          context, 'Error', 'There is a problem with updating expanding value');
    } else {
      setState(() {
        _updatingState = false;
      });
    }
  }

  Future<void> _updateDoorStatus(String status) async {
    setState(() {
      _updatingState = true;
    });

    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token');

    _pelboxBloc.pelboxEventSink.add(UpdateDoorStatus(accessToken, status));
    Map response = await _pelboxBloc.pelbox.first;

    if (response['success'] == false) {
      _createAlertDialog(
          context, 'Error', 'There is a problem with updating door status');
    } else {
      setState(() {
        _updatingState = false;
      });
    }
  }

  Future<void> _createAlertDialog(
      BuildContext context, String title, String message) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              MaterialButton(
                child: Text('Close'),
                onPressed: () => {Navigator.of(context).pop()},
              )
            ],
          );
        });
  }
}
