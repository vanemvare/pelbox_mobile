import 'package:flutter/material.dart';
import 'package:pelbox_mobile/bloc/account_bloc.dart';
import 'package:pelbox_mobile/bloc/events/account_events.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditLastNameForm extends StatefulWidget {
  final String _lastName;

  EditLastNameForm(this._lastName);

  @override
  State<StatefulWidget> createState() {
    return LastNameForm(this._lastName);
  }
}

class LastNameForm extends State<EditLastNameForm> {
  final _formKey = GlobalKey<FormState>();

  String _lastName;
  final _lastNameController = TextEditingController();

  final _lastNameBloc = AccountBloc();

  LastNameForm(this._lastName) {
    _lastNameController.text = _lastName != null ? _lastName : "";
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Last Name',
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
            controller: _lastNameController,
            validator: (input) => _validateLastName(input),
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
      if (_lastNameController.text == _lastName) {
        _createAlertDialog(context, 'Information', 'Last name is not changed');
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString('access_token');
      
      _lastNameBloc.accountEventSink.add(UpdateLastName(accessToken, _lastNameController.text));
      Map response = await _lastNameBloc.account.first;

      if (response['success']) {
        _createAlertDialog(context, 'Information', response['message']);
        _lastName = _lastNameController.text;
      } else {
        _createAlertDialog(context, 'Error', 'There is a problem with updating last name');
      }
    }
  }

  String _validateLastName(String input) {
    if (input.isEmpty) {
      return 'Enter a valid Last Name';
    }

    if (input.length < 2) {
      return 'Last Name needs to have at least 2 characters';
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

    _lastNameController.dispose();
  }
}