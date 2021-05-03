import 'package:flutter/material.dart';
import 'package:pelbox_mobile/bloc/account_bloc.dart';
import 'package:pelbox_mobile/bloc/events/account_events.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditCityForm extends StatefulWidget {
  final String _city;

  EditCityForm(this._city);

  @override
  State<StatefulWidget> createState() {
    return CityForm(this._city);
  }
}

class CityForm extends State<EditCityForm> {
  final _formKey = GlobalKey<FormState>();

  String _city;
  final _cityController = TextEditingController();

  final _cityBloc = AccountBloc();

  CityForm(this._city) {
    _cityController.text = _city != null ? _city : "";
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: 'City Name',
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
            controller: _cityController,
            validator: (input) => _validateCityName(input),
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
      if (_cityController.text == _city) {
        _createAlertDialog(context, 'Information', 'City name is not changed');
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString('access_token');
      
      _cityBloc.accountEventSink.add(UpdateCity(accessToken, _cityController.text));
      Map response = await _cityBloc.account.first;

      if (response['success']) {
        _createAlertDialog(context, 'Information', response['message']);
        _city = _cityController.text;
      } else {
        _createAlertDialog(context, 'Error', 'There is a problem with updating city name');
      }
    }
  }

  String _validateCityName(String input) {
    if (input.isEmpty) {
      return 'Enter a valid city name';
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

    _cityController.dispose();
  }
}