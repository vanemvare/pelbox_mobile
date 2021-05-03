import 'package:flutter/material.dart';
import 'package:pelbox_mobile/bloc/events/pelbox_events.dart';
import 'package:pelbox_mobile/bloc/pelbox_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditSetLockUnlockBox extends StatefulWidget {
  final bool _locked;

  EditSetLockUnlockBox(this._locked);

  @override
  State<StatefulWidget> createState() {
    return SetLockUnlockBox(this._locked);
  }
}

class SetLockUnlockBox extends State<EditSetLockUnlockBox> {
  final _formKey = GlobalKey<FormState>();

  bool _locked;

  String _previousLockState;
  String _newLockState;

  final _pelboxBloc = PelBoxBloc();

  SetLockUnlockBox(this._locked) {
    _previousLockState = _locked ? 'Yes' : 'No';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          DropdownButtonFormField(
            items: ['Yes', 'No'].map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
            decoration: InputDecoration(
              filled: true,
              fillColor: Color.fromRGBO(255, 255, 255, 0.7),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none
              ),
              contentPadding: EdgeInsets.all(10)
            ),
            onChanged: (value) {
              setState(() {
                 _newLockState = value;
              });
            },
            value: _locked == null ? _newLockState : _locked == true ? 'Yes' : 'No',
          ),
          SizedBox(
             height: 10,
          ),
          Container(
            width: double.infinity,
            height: 43,
            child: RaisedButton(
              onPressed: () => _updateLockState(),
              child: Text(
                'Update',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)
              ),
              color: Color(0xff078dff),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updateLockState() async {
      String currentState = _locked ? 'Yes' : 'No';
      String _lockState = currentState == 'Yes' ? 'locked' : 'unlocked';

      if ( _newLockState == null || _newLockState == currentState) {
        _createAlertDialog(context, 'Information', 'Box is already $_lockState');
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString('access_token');
      
      _pelboxBloc.pelboxEventSink.add(UpdateLocking(accessToken, _newLockState == 'Yes' ? true : false));
      Map response = await _pelboxBloc.pelbox.first;

      if (response['success']) {
        _lockState = _newLockState == 'Yes' ? 'locked' : 'unlocked';
        _createAlertDialog(context, 'Information', 'Box is $_lockState');
        setState(() {
          _locked = _newLockState == 'Yes' ? true : false;
        });
      } else {
        _createAlertDialog(context, 'Error', 'There is a problem with updating state of locking');
      }
  }

  Future<void> _createAlertDialog(BuildContext context, String title, String message) async {
    await showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          MaterialButton(
            child: Text('Close'),
            onPressed: () => {
              Navigator.of(context).pop()
            },
          )
        ],
      );
    });
  }
}