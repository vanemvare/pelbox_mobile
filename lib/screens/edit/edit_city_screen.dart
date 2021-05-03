import 'package:flutter/material.dart';
import 'package:pelbox_mobile/forms/edit/edit_city_form.dart';

class EditCityScreen extends StatefulWidget {
  final String _city;

  EditCityScreen(this._city);

  @override
  State<StatefulWidget> createState() {
    return City(_city);
  }
}

class City extends State<EditCityScreen> {
  final String _city;

  City(this._city);

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
          title: Text('Edit City Name'),
        ),
        body: Container(
          margin: EdgeInsets.all(17),
          child: Column(
            children: [
              SizedBox(
                height: 20
              ),
              EditCityForm(_city)
            ],
          )
        ),
      ),
    );
  }
}