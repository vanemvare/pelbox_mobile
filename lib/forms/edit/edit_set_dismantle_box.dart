import 'package:flutter/material.dart';
import 'package:pelbox_mobile/bloc/events/pelbox_events.dart';
import 'package:pelbox_mobile/bloc/pelbox_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditSetDismantleBox extends StatefulWidget {
  final bool _dismantle;

  EditSetDismantleBox(this._dismantle);

  @override
  State<StatefulWidget> createState() {
    return SetDismantle(this._dismantle);
  }
}

class SetDismantle extends State<EditSetDismantleBox> {
  final _formKey = GlobalKey<FormState>();

  bool _dismantle;

  String _newDismantleState;

  final _pelboxBloc = PelBoxBloc();

  SetDismantle(this._dismantle) {}

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
                 _newDismantleState = value;
              });
            },
            value: _dismantle == null ? _newDismantleState : _dismantle == true ? 'Yes' : 'No',
          ),
          SizedBox(
             height: 10,
          ),
          Container(
            width: double.infinity,
            height: 43,
            child: RaisedButton(
              onPressed: () => _updateDismantleState(),
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

  Future<void> _updateDismantleState() async {
      String currentState = _dismantle ? 'Yes' : 'No';
      String _dismantleState = currentState == 'Yes' ? 'dismantled' : 'mantled';

      if ( _newDismantleState == null || _newDismantleState == currentState) {
        _createAlertDialog(context, 'Information', 'Box is already $_dismantleState');
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString('access_token');
      
      _pelboxBloc.pelboxEventSink.add(UpdateDismantle(accessToken, _newDismantleState == 'Yes' ? true : false));
      Map response = await _pelboxBloc.pelbox.first;

      if (response['success']) {
        _dismantleState = _newDismantleState == 'Yes' ? 'dismantled' : 'mantled';
        _createAlertDialog(context, 'Information', 'Box is $_dismantleState');
        setState(() {
          _dismantle = _newDismantleState == 'Yes' ? true : false;
        });
      } else {
        _createAlertDialog(context, 'Error', 'There is a problem with updating state of dismantling box');
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