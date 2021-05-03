import 'package:flutter/material.dart';
import 'package:pelbox_mobile/forms/edit/edit_cityaddress_form.dart';

class EditCityAddressScreen extends StatefulWidget {
  final String _cityAddress;

  EditCityAddressScreen(this._cityAddress);

  @override
  State<StatefulWidget> createState() {
    return CityAddress(_cityAddress);
  }
}

class CityAddress extends State<EditCityAddressScreen> {
  final String _cityAddress;

  CityAddress(this._cityAddress);

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
          title: Text('Edit City Address'),
        ),
        body: Container(
          margin: EdgeInsets.all(17),
          child: Column(
            children: [
              SizedBox(
                height: 20
              ),
              EditCityAddressForm(_cityAddress)
            ],
          )
        ),
      ),
    );
  }
}