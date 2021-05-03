import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pelbox_mobile/bloc/account_bloc.dart';
import 'package:pelbox_mobile/bloc/events/account_events.dart';
import 'package:pelbox_mobile/forms/edit/edit_country_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditCountryScreen extends StatefulWidget {
  final String _country;

  EditCountryScreen(this._country);

  @override
  State<StatefulWidget> createState() {
    return Country(_country);
  }
}

class Country extends State<EditCountryScreen> {
  List<dynamic> _countries = List<dynamic>();

  final String _country;

  bool _hasAllCountries = false;

  Country(this._country);

  @override
  void initState() {
    super.initState();
    _getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage('assets/images/background2.png'),
          fit: BoxFit.cover
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Edit Country'),
        ),
        body: _hasAllCountries ? Container(
          margin: EdgeInsets.all(17),
          child: Column(
            children: [
              SizedBox(
                height: 20
              ),
              EditCountryForm(_country, _countries)
            ],
          )
        )
        :
        Center(
          child: SpinKitCubeGrid(
            color: Colors.white,
            size: 50.0,
          ),
        ),
      ),
    );
  }

  Future<void> _getCountries() async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token');

    final _accountBloc = AccountBloc();
    _accountBloc.accountEventSink.add(AllCountries(accessToken));
    Map response = await _accountBloc.account.first;
    
    if (response['success']) {
      setState(() {
        _countries = response['message'];
        _hasAllCountries = true;
      });
    }
  }
}