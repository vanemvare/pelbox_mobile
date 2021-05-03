import 'package:flutter/material.dart';
import 'package:pelbox_mobile/forms/edit/edit_gender_form.dart';

class EditGenderScreen extends StatefulWidget {
  final String _gender;

  EditGenderScreen(this._gender);

  @override
  State<StatefulWidget> createState() {
    return Gender(_gender);
  }
}

class Gender extends State<EditGenderScreen> {
  final String _gender;

  Gender(this._gender);

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
          title: Text('Edit Gender'),
        ),
        body: Container(
          margin: EdgeInsets.all(17),
          child: Column(
            children: [
              SizedBox(
                height: 20
              ),
              EditGenderForm(_gender)
            ],
          )
        )
      ),
    );
  }
}