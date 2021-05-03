import 'package:flutter/material.dart';
import 'package:pelbox_mobile/bloc/account_bloc.dart';
import 'package:pelbox_mobile/bloc/events/account_events.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditGenderForm extends StatefulWidget {
  final String _gender;

  EditGenderForm(this._gender);

  @override
  State<StatefulWidget> createState() {
    return GenderForm(this._gender);
  }
}

class GenderForm extends State<EditGenderForm> {
  final _formKey = GlobalKey<FormState>();

  String _gender;

  final _genderBloc = AccountBloc();

  String _selectedGender;

  GenderForm(this._gender) {
    _gender = _gender != null ? _gender : "";
    _selectedGender = _gender;
  }

  final List<String> _genders = ["Male", "Female"];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          DropdownButtonFormField(
            value: _gender.isEmpty ? null : _gender,
            isExpanded: true,
            decoration: InputDecoration(
              fillColor: Color.fromRGBO(255, 255, 255, 0.7),
              filled: true
            ),
            items: _genders.map((name) {
              return DropdownMenuItem(
                value: name,
                child: Text(name)
              );
            }).toList(), 
            onChanged: (selected) {
              _selectedGender = selected;
            },
            validator: (_) => _validateGender(),
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
      if (_gender == _selectedGender) {
        _createAlertDialog(context, 'Information', 'Gender is not changed');
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString('access_token');
      
      _genderBloc.accountEventSink.add(UpdateGender(accessToken, _selectedGender));
      Map response = await _genderBloc.account.first;

      if (response['success']) {
        _createAlertDialog(context, 'Information', response['message']);
        _gender = _selectedGender;
      } else {
        _createAlertDialog(context, 'Error', 'There is a problem with updating gender');
      }
    }
  }

  String _validateGender() {
    if (_selectedGender.isEmpty) {
      return 'Select a valid gender';
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
}