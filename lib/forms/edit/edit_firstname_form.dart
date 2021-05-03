import 'package:flutter/material.dart';
import 'package:pelbox_mobile/bloc/account_bloc.dart';
import 'package:pelbox_mobile/bloc/events/account_events.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditFirstNameForm extends StatefulWidget {
  final String _firstName;

  EditFirstNameForm(this._firstName);

  @override
  State<StatefulWidget> createState() {
    return FirstNameForm(this._firstName);
  }
}

class FirstNameForm extends State<EditFirstNameForm> {
  final _formKey = GlobalKey<FormState>();

  String _firstName;
  final _firstNameController = TextEditingController();

  final _firstNameBloc = AccountBloc();

  FirstNameForm(this._firstName) {
    _firstNameController.text = _firstName != null ? _firstName : "";
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: 'First Name',
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
            controller: _firstNameController,
            validator: (input) => _validateFirstName(input),
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
      if (_firstNameController.text == _firstName) {
        _createAlertDialog(context, 'Information', 'First name is not changed');
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString('access_token');
      
      _firstNameBloc.accountEventSink.add(UpdateFirstName(accessToken, _firstNameController.text));
      Map response = await _firstNameBloc.account.first;

      if (response['success']) {
        _createAlertDialog(context, 'Information', response['message']);
        _firstName = _firstNameController.text;
      } else {
        _createAlertDialog(context, 'Error', 'There is a problem with updating First Name');
      }
    }
  }

  String _validateFirstName(String input) {
    if (input.isEmpty) {
      return 'Enter a valid first name';
    }

    if (input.length < 2) {
      return 'First name needs to have at least 2 characters';
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

    _firstNameController.dispose();
  }
}