import 'package:flutter/material.dart';
import 'package:pelbox_mobile/forms/edit/edit_lastname_form.dart';

class EditLastNameScreen extends StatefulWidget {
  final String _lastName;

  EditLastNameScreen(this._lastName);

  @override
  State<StatefulWidget> createState() {
    return LastName(_lastName);
  }
}

class LastName extends State<EditLastNameScreen> {
  final String _lastName;

  LastName(this._lastName);

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
          title: Text('Edit Last Name'),
        ),
        body: Container(
          margin: EdgeInsets.all(17),
          child: Column(
            children: [
              SizedBox(
                height: 20
              ),
              EditLastNameForm(_lastName)
            ],
          )
        ),
      ),
    );
  }
}