import 'package:flutter/material.dart';
import 'package:pelbox_mobile/forms/edit/edit_set_dismantle_box.dart';

class EditDismantle extends StatefulWidget {
  final bool _dismantle;

  EditDismantle(this._dismantle);

  @override
  State<StatefulWidget> createState() {
    return SetDismantle(_dismantle);
  }
}

class SetDismantle extends State<EditDismantle> {
  final bool _dismantle;

  SetDismantle(this._dismantle);

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
          title: Text('Dismantle or Mantle Box'),
        ),
        body: Container(
            margin: EdgeInsets.all(17),
            child: Column(
              children: [
                SizedBox(height: 20),
                EditSetDismantleBox(_dismantle)
              ],
            )),
      ),
    );
  }
}
