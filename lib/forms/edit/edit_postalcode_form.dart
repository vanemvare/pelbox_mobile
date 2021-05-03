import 'package:flutter/material.dart';
import 'package:pelbox_mobile/bloc/account_bloc.dart';
import 'package:pelbox_mobile/bloc/events/account_events.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPostalCodeForm extends StatefulWidget {
  final String _postalCode;

  EditPostalCodeForm(this._postalCode);

  @override
  State<StatefulWidget> createState() {
    return PostalCodeForm(this._postalCode);
  }
}

class PostalCodeForm extends State<EditPostalCodeForm> {
  final _formKey = GlobalKey<FormState>();

  String _postalCode;
  final _postalCodeController = TextEditingController();

  final _postalCodeBloc = AccountBloc();

  PostalCodeForm(this._postalCode) {
    _postalCodeController.text = _postalCode != null ? _postalCode : "";
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Postal Code',
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
            controller: _postalCodeController,
            validator: (input) => _validatePostalCode(input),
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
      if (_postalCodeController.text == _postalCode) {
        _createAlertDialog(context, 'Information', 'Postal code is not changed');
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString('access_token');
      
      _postalCodeBloc.accountEventSink.add(UpdatePostalCode(accessToken, _postalCodeController.text));
      Map response = await _postalCodeBloc.account.first;

      if (response['success']) {
        _createAlertDialog(context, 'Information', response['message']);
        _postalCode = _postalCodeController.text;
      } else {
        _createAlertDialog(context, 'Error', 'There is a problem with updating postal code');
      }
    }
  }

  String _validatePostalCode(String input) {
    if (input.isEmpty) {
      return 'Enter a valid postal code';
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

    _postalCodeController.dispose();
  }
}