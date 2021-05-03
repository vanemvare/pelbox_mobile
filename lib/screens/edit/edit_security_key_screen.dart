import 'package:flutter/material.dart';
import 'package:pelbox_mobile/forms/edit/edit_pelbox_security_key.dart';

class EditSecurityKeyScreen extends StatefulWidget {
  final String _userSecurityKey;
  final String _securityKey;

  EditSecurityKeyScreen(this._userSecurityKey, this._securityKey);

  @override
  State<StatefulWidget> createState() {
    return SecurityKey(_userSecurityKey, _securityKey);
  }
}

class SecurityKey extends State<EditSecurityKeyScreen> {
  final String _userSecurityKey;
  final String _securityKey;

  SecurityKey(this._userSecurityKey, this._securityKey);

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
          title: Text('Edit Security Key'),
        ),
        body: Container(
            margin: EdgeInsets.all(17),
            child: Column(
              children: [
                SizedBox(height: 20),
                EditPelBoxUserSecurityKeyForm(_userSecurityKey, _securityKey)
              ],
            )),
      ),
    );
  }
}
