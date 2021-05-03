import 'package:flutter/material.dart';
import 'package:pelbox_mobile/forms/login_form.dart';

class LoginScreen extends StatefulWidget {
  State<StatefulWidget> createState() {
    return Login();
  }
}

class Login extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Color(0x44000000),
        elevation: 0,
      ),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 80,
              ),
              Center(
                child: Text(
                  'Welcome back!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  'Log in with your username to begin',
                  style: TextStyle(
                    color: Color(0xffc3c2c9)
                  ),
                ),
              ),
              Center(
                child: Text(
                  'protecting your deliveries.',
                  style: TextStyle(
                    color: Color(0xffc3c2c9)
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  LoginForm(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}