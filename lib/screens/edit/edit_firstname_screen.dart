import 'package:flutter/material.dart';
import 'package:pelbox_mobile/forms/edit/edit_firstname_form.dart';

class EditFirstNameScreen extends StatefulWidget {
  final String _firstName;

  EditFirstNameScreen(this._firstName);

  @override
  State<StatefulWidget> createState() {
    return FirstName(_firstName);
  }
}

class FirstName extends State<EditFirstNameScreen> {
  final String _firstName;

  FirstName(this._firstName);

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
          title: Text('Edit First Name'),
        ),
        body: Container(
          margin: EdgeInsets.all(17),
          child: Column(
            children: [
              SizedBox(
                height: 20
              ),
              EditFirstNameForm(_firstName)
            ],
          )
        ),
      ),
    );
  }
}