import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'events/register_events.dart';

class RegisterBloc {
  final _registerStateController = StreamController<Map>();
  StreamSink<Map> get _inRegister => _registerStateController.sink;
  Stream<Map> get register => _registerStateController.stream;

  final _registerEventController = StreamController<RegisterEvent>();
  Sink<RegisterEvent> get registerEventSink => _registerEventController.sink;

  RegisterBloc() {
    _registerEventController.stream.listen(_eventToState);
  }

  void _eventToState(RegisterEvent event) {
    if (event is RegisterMember) {
      _registerMember(event.username, event.email, event.password, event.phoneToken)
      .then((response) {
        _inRegister.add(jsonDecode(response.body));
      })
      .catchError((error) => print(error));
    }
  }

  Future<http.Response> _registerMember(String username, String email, String password, String phoneToken) async {
    Map<String, dynamic> jsonMap = {
      'username': username,
      'email': email,
      'password': password,
      'phone_token': phoneToken,
    };

    return http.post(
        'http://10.0.2.2:9000/members/register/',
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode(jsonMap)
    );
  }

  void dispose() {
    _registerStateController.close();
    _registerEventController.close();
  }
}
