import 'package:flutter/material.dart';
import 'package:pelbox_mobile/bloc/events/login_events.dart';
import 'package:pelbox_mobile/bloc/login_bloc.dart';
import 'package:pelbox_mobile/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Login();
  }
}

class Login extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _loginBloc = LoginBloc();

  bool _firstTimeOpening = true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: _loginBloc.login,
      builder: (context, snapshot) {
        Map data = snapshot.data;

        if (_firstTimeOpening) {
          _firstTimeOpening = false;
        } else {
          if (data['success']) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('access_token', data['access_token']);
              await prefs.setString('refresh_token', data['refresh_token']);
              await prefs.setBool('is_in_organization', data['is_in_organization']);

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (Route<dynamic> route) => false,
              );
            });
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _createAlertDialog(context, 'Error', data['message']);
            });
          }
        }

        return Form(
          key: _formKey,
          child: Container(
            child: Column(
              children: [
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
                      'Login',
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
          ),
        );
      }
    );
  }

  void _validateForm() {
    if (_formKey.currentState.validate()) {
      _loginBloc.loginEventSink.add(LoginMember(_usernameController.text, _passwordController.text));
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
    _passwordController.dispose();
  }
}