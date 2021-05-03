import 'package:flutter/material.dart';
import 'package:pelbox_mobile/bloc/account_bloc.dart';
import 'package:pelbox_mobile/bloc/events/account_events.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditCityAddressForm extends StatefulWidget {
  final String _cityAddress;

  EditCityAddressForm(this._cityAddress);

  @override
  State<StatefulWidget> createState() {
    return CityAddressForm(this._cityAddress);
  }
}

class CityAddressForm extends State<EditCityAddressForm> {
  final _formKey = GlobalKey<FormState>();

  String _cityAddress;
  final _cityAddressController = TextEditingController();

  final _cityAddressBloc = AccountBloc();

  CityAddressForm(this._cityAddress) {
    _cityAddressController.text = _cityAddress != null ? _cityAddress : "";
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: 'City Address',
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
            controller: _cityAddressController,
            validator: (input) => _validateCityAddress(input),
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
      if (_cityAddressController.text == _cityAddress) {
        _createAlertDialog(context, 'Information', 'Address is not changed');
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString('access_token');
      
      _cityAddressBloc.accountEventSink.add(UpdateCityAddress(accessToken, _cityAddressController.text));
      Map response = await _cityAddressBloc.account.first;

      if (response['success']) {
        _createAlertDialog(context, 'Information', response['message']);
        _cityAddress = _cityAddressController.text;
      } else {
        _createAlertDialog(context, 'Error', 'There is a problem with updating address');
      }
    }
  }

  String _validateCityAddress(String input) {
    if (input.isEmpty) {
      return 'Enter a valid city address';
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

    _cityAddressController.dispose();
  }
}