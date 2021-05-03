import 'package:flutter/material.dart';
import 'package:pelbox_mobile/forms/register_form.dart';

class RegisterScreen extends StatefulWidget {
  State<StatefulWidget> createState() {
    return Register();
  }
}

class Register extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Color(0x44000000),
        elevation: 0,
      ),
      backgroundColor: Colors.black,
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
                  'Register',
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
                  'Create an account to begin securing',
                  style: TextStyle(
                    color: Color(0xffc3c2c9)
                  ),
                ),
              ),
              Center(
                child: Text(
                  'deliveries today!',
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
                  RegisterForm(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}