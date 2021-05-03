import 'package:flutter/material.dart';
import 'package:pelbox_mobile/bloc/account_bloc.dart';
import 'package:pelbox_mobile/bloc/events/account_events.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditCountryForm extends StatefulWidget {
  final String _country;
  final List<dynamic> _countries;

  EditCountryForm(this._country, this._countries);

  @override
  State<StatefulWidget> createState() {
    return CountryForm(this._country, _countries);
  }
}

class CountryForm extends State<EditCountryForm> {
  final _formKey = GlobalKey<FormState>();

  String _country;
  List<dynamic> _countries;

  final _countryBloc = AccountBloc();

  String _selectedName;

  CountryForm(this._country, this._countries) {
    _country = _country != null ? _country : "";
    _selectedName = _country;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          DropdownButtonFormField(
            value: _country.isEmpty ? null : _country,
            isExpanded: true,
            decoration: InputDecoration(
              fillColor: Color.fromRGBO(255, 255, 255, 0.7),
              filled: true
            ),
            items: _countries.map((country) {
              String name;

              country.values.forEach((element) {
                name = element["name"];
              });

              return DropdownMenuItem(
                value: name,
                child: Text(name)
              );
            }).toList(), 
            onChanged: (selected) {
              _selectedName = selected;
            },
            validator: (_) => _validateCountry(),
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
      if (_country == _selectedName) {
        _createAlertDialog(context, 'Information', 'Country is not changed');
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString('access_token');
      
      _countryBloc.accountEventSink.add(UpdateCountry(accessToken, _selectedName));
      Map response = await _countryBloc.account.first;

      if (response['success']) {
        _createAlertDialog(context, 'Information', response['message']);
        _country = _selectedName;
      } else {
        _createAlertDialog(context, 'Error', 'There is a problem with updating country');
      }
    }
  }

  String _validateCountry() {
    if (_selectedName.isEmpty) {
      return 'Select a valid country name';
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