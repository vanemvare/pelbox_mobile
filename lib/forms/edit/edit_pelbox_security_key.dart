import 'package:flutter/material.dart';
import 'package:pelbox_mobile/bloc/account_bloc.dart';
import 'package:pelbox_mobile/bloc/events/account_events.dart';
import 'package:pelbox_mobile/bloc/events/pelbox_events.dart';
import 'package:pelbox_mobile/bloc/pelbox_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPelBoxUserSecurityKeyForm extends StatefulWidget {
  final String _userSecurityKey;
  final String _securityKey;

  EditPelBoxUserSecurityKeyForm(this._userSecurityKey, this._securityKey);

  @override
  State<StatefulWidget> createState() {
    return PelBoxUserSecurityKeyForm(this._userSecurityKey, this._securityKey);
  }
}

class PelBoxUserSecurityKeyForm extends State<EditPelBoxUserSecurityKeyForm> {
  final _formKey = GlobalKey<FormState>();

  String _userSecurityKey;
  String _securityKey;
  final _securityKeyController = TextEditingController();

  final _pelboxBloc = PelBoxBloc();

  PelBoxUserSecurityKeyForm(this._userSecurityKey, this._securityKey) {
    _securityKeyController.text = _userSecurityKey != null ? _userSecurityKey : "";
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Security key',
              filled: true,
              fillColor: Color.fromRGBO(255, 255, 255, 0.7),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none
              ),
              contentPadding: EdgeInsets.all(10)
            ),
            cursorColor: Color(0xff078dff),
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
            controller: _securityKeyController,
            validator: (input) => _validateSecurityKey(input),
            enableSuggestions: false,
            autocorrect: false,
          ),
          SizedBox(
             height: 10,
          ),
          Container(
            width: double.infinity,
            height: 43,
            child: RaisedButton(
              onPressed: () => _validateForm(),
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

  Future<void> _validateForm() async {

    if (_formKey.currentState.validate()) {
      if (_securityKeyController.text == _userSecurityKey) {
        _createAlertDialog(context, 'Information', 'Security key is not changed');
        return;
      }

      if (_securityKeyController.text != _securityKey) {
        _createAlertDialog(context, 'Information', 'Security key is not valid');
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString('access_token');
      
      _pelboxBloc.pelboxEventSink.add(UpdateSecurityKey(accessToken, _securityKeyController.text));
      Map response = await _pelboxBloc.pelbox.first;

      if (response['success']) {
        _createAlertDialog(context, 'Information', response['message']);
        _userSecurityKey = _securityKeyController.text;
      } else {
        _createAlertDialog(context, 'Error', 'There is a problem with updating security key');
      }
    }
  }

  String _validateSecurityKey(String input) {
    if (input.isEmpty) {
      return 'Enter a valid security key';
    }

    if (input.length < 10) {
      return 'Secutiy key needs to have at least 10 characters';
    }

    return null;
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

  @override
  void dispose() {
    super.dispose();

    _securityKeyController.dispose();
  }
}