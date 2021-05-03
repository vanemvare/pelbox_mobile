import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pelbox_mobile/bloc/events/logout_events.dart';

class LogoutBloc {
  final _logoutStateController = StreamController<Map>();
  StreamSink<Map> get _inLogout => _logoutStateController.sink;
  Stream<Map> get logout => _logoutStateController.stream;

  final _logoutEventController = StreamController<LogoutEvent>();
  Sink<LogoutEvent> get logoutEventSink => _logoutEventController.sink;

  LogoutBloc() {
    _logoutEventController.stream.listen(_eventToState);
  }

  void _eventToState(LogoutEvent event) {
    if (event is LogoutMember) {
      _logoutMember(event.accessToken, event.refreshToken)
      .then((response) {
        _inLogout.add(jsonDecode(response.body));
      })
      .catchError((error) => print(error));
    }
  }

  Future<http.Response> _logoutMember(String accessToken, String refreshToken) async {
    Map<String, dynamic> jsonMap = {
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };

    return http.post(
        'http://10.0.2.2:9000/members/logout/',
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode(jsonMap)
    );
  }

  void dispose() {
    _logoutStateController.close();
    _logoutEventController.close();
  }
}
