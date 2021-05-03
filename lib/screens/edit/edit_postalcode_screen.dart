import 'package:flutter/material.dart';
import 'package:pelbox_mobile/forms/edit/edit_postalcode_form.dart';

class EditPostalCodeScreen extends StatefulWidget {
  final String _postalCode;

  EditPostalCodeScreen(this._postalCode);

  @override
  State<StatefulWidget> createState() {
    return City(_postalCode);
  }
}

class City extends State<EditPostalCodeScreen> {
  final String _postalCode;

  City(this._postalCode);

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
          title: Text('Edit Postal Code'),
        ),
        body: Container(
          margin: EdgeInsets.all(17),
          child: Column(
            children: [
              SizedBox(
                height: 20
              ),
              EditPostalCodeForm(_postalCode)
            ],
          )
        ),
      ),
    );
  }
}