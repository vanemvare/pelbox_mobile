import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:pelbox_mobile/bloc/events/login_events.dart';
import 'dart:convert';

class LoginBloc {
  final _loginStateController = StreamController<Map>();
  StreamSink<Map> get _inLogin => _loginStateController.sink;
  Stream<Map> get login => _loginStateController.stream;

  final _loginEventController = StreamController<LoginEvent>();
  Sink<LoginEvent> get loginEventSink => _loginEventController.sink;

  LoginBloc() {
    _loginEventController.stream.listen(_eventToState);
  }

  void _eventToState(LoginEvent event) {
    if (event is LoginMember) {
      _loginMember(event.username, event.password)
      .then((response) {
        _inLogin.add(jsonDecode(response.body));
      })
      .catchError((error) => print(error));
    }
  }

  Future<http.Response> _loginMember(String username, String password) async {
    Map<String, dynamic> jsonMap = {
      'username': username,
      'password': password,
      'email': '',
      'phone_token': '',
    };

    try {
      http.Response response = await http.post(
          'http://10.0.2.2:9000/members/login/',
          headers: {
            'Content-Type': 'application/json'
          },
          body: jsonEncode(jsonMap)
      );

      return response;
    } catch (error) {
      return new http.Response("{\"success\": false, \"message\": \"Something went wrong\"}", 500);
    }
  }

  void dispose() {
    _loginStateController.close();
    _loginEventController.close();
  }
}
