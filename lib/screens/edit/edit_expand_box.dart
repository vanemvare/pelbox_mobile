import 'package:flutter/material.dart';
import 'package:pelbox_mobile/forms/edit/edit_set_expand_box.dart';

class EditExpandBox extends StatefulWidget {
  final int _expandValue;

  EditExpandBox(this._expandValue);

  @override
  State<StatefulWidget> createState() {
    return SetExpandBox(_expandValue);
  }
}

class SetExpandBox extends State<EditExpandBox> {
  final int _expandValue;

  SetExpandBox(this._expandValue);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
            image: AssetImage('assets/images/background2.png'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Expand box'),
        ),
        body: Container(
            margin: EdgeInsets.all(17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                EditSetExpandBox(_expandValue)
              ],
            )),
      ),
    );
  }
}
