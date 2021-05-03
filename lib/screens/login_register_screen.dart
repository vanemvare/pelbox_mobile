import 'package:flutter/material.dart';
import 'package:pelbox_mobile/screens/login_screen.dart';
import 'package:pelbox_mobile/screens/register_screen.dart';

class LoginRegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/images/pelbox_logo.png'),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'pel',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              'box',
              style: TextStyle(
                color: Color(0xff078dff),
                fontSize: 40,
                fontWeight: FontWeight.bold
              )
            )
          ],
        ),
        SizedBox(
          height: 105,
        ),
        Text(
          'Welcome to Pelbox',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Start securing your packages at',
          style: TextStyle(
            color: Color(0xffc3c2c9)
          ),
        ),
        Text(
          'the touch of your fingertips.',
          style: TextStyle(
            color: Color(0xffc3c2c9)
          ),
        ),
        SizedBox(
          height: 26,
        ),
        Container(
          width: double.infinity,
          height: 43,
          child: RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterScreen())
              );
            },
            child: Text(
              'Register',
              style: TextStyle(
                color: Colors.white
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
            ),
            color: Color(0xff078dff),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          height: 43,
          child: RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen())
              );
            },
            child: Text(
              'Login',
              style: TextStyle(
                color: Colors.white
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
            ),
            color: Color(0xff303030),
          ),
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }
}