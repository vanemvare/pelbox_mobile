import 'package:flutter/material.dart';
import 'package:pelbox_mobile/forms/edit/edit_lock_unlock_box.dart';

class EditSetLockUnlock extends StatefulWidget {
  final bool _locked;

  EditSetLockUnlock(this._locked);

  @override
  State<StatefulWidget> createState() {
    return SetLockUnlock(_locked);
  }
}

class SetLockUnlock extends State<EditSetLockUnlock> {
  final bool _locked;

  SetLockUnlock(this._locked);

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
          title: Text('Lock or Unlock Box'),
        ),
        body: Container(
            margin: EdgeInsets.all(17),
            child: Column(
              children: [
                SizedBox(height: 20),
                EditSetLockUnlockBox(_locked)
              ],
            )),
      ),
    );
  }
}
