import 'package:flutter/material.dart';
import 'package:pelbox_mobile/screens/login_register_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: AssetImage('assets/images/background1.png'),
              fit: BoxFit.cover
            )
          ),
          child: Container(
            margin: EdgeInsets.all(17),
            child: LoginRegisterScreen()
          )
        ),
      ),
    );
  }
}