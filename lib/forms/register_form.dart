import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pelbox_mobile/bloc/events/register_events.dart';
import 'package:pelbox_mobile/bloc/register_bloc.dart';
import 'package:pelbox_mobile/screens/login_screen.dart';

class RegisterForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Register();
  }
}

class Register extends State<RegisterForm> {
  final FirebaseMessaging _messaging = FirebaseMessaging();
  
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _blocRegister = RegisterBloc();

  bool _firstTimeOpening = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: StreamBuilder<Object>(
        stream: _blocRegister.register,
        builder: (context, snapshot) {
          Map data = snapshot.data;

          if (_firstTimeOpening) {
            _firstTimeOpening = false;
          } else {
            if (data['success']) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _createAlertDialog(context, 'Information', 'Your account has been created').whenComplete(() => {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false,
                  )
                });
              });
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _createAlertDialog(context, 'Error', data['message']);
              });
            }
          }

          return Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'PICK A USERNAME',
                      style: TextStyle(
                        color: Color(0xffc3c2c9),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Username',
                    filled: true,
                    fillColor: Color.fromRGBO(255, 255, 255, 0.7),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none
                    ),
                    contentPadding: EdgeInsets.all(10)
                  ),
                  cursorColor: Color(0xff078dff),
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                  controller: _usernameController,
                  validator: (input) => _validateUsername(input),
                  enableSuggestions: false,
                  autocorrect: false,
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text(
                      'ACCOUNT INFORMATION',
                      style: TextStyle(
                        color: Color(0xffc3c2c9),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                    filled: true,
                    fillColor: Color.fromRGBO(255, 255, 255, 0.7),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none
                    ),
                    contentPadding: EdgeInsets.all(10)
                  ),
                  cursorColor: Color(0xff078dff),
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                  controller: _emailController,
                  validator: (input) => _validateEmail(input),
                  enableSuggestions: false,
                  autocorrect: false,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    fillColor: Color.fromRGBO(255, 255, 255, 0.7),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.all(10)
                  ),
                  cursorColor: Color(0xff078dff),
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                  controller: _passwordController,
                  validator: (input) => _validatePassword(input),
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 43,
                  child: RaisedButton(
                    onPressed: () => _validateForm(),
                    child: Text(
                      'Create account',
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
              ],
            ),
          );
        }
      ),
    );
  }

  Future<void> _validateForm() async {
    if (_formKey.currentState.validate()) {
      String token = await _messaging.getToken();
      _blocRegister.registerEventSink.add(RegisterMember(_usernameController.text, _emailController.text, _passwordController.text, token));
    }
  }

  String _validateUsername(String input) {
    if (input.isEmpty) {
      return 'Username is required.';
    }

    if (input.length < 6) {
      return 'Username needs to have at least 6 characters.';
    }

    return null;
  }

  String _validateEmail(String input) {
    if (input.isEmpty) {
      return 'A valid email is required.';
    }

    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(input);
    if (!(emailValid)) {
      return 'The email entered is not valid, please update it and try again.';
    }

    return null;
  }

  String _validatePassword(String input) {
    if (input.isEmpty) {
      return 'Password is required.';
    }

    if (input.length < 6) {
      return 'Password needs to have at least 6 characters.';
    }

    return null;
  }

  Future<void> _createAlertDialog(BuildContext context, String title, String message) async {
    await showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          MaterialButton(
            child: Text('Close'),
            onPressed: () => {
              Navigator.of(context).pop()
            },
          )
        ],
      );
    });
  }

  @override
  void dispose() {
    super.dispose();

    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}