import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rxdart/rxdart.dart';

import 'events/pelbox_events.dart';

class PelBoxBloc {
  final _pelboxStateController = BehaviorSubject<Map>();
  StreamSink<Map> get _inPelBox => _pelboxStateController.sink;
  Stream<Map> get pelbox => _pelboxStateController.stream;

  final _pelboxEventController = BehaviorSubject<PelBoxEvent>();
  Sink<PelBoxEvent> get pelboxEventSink => _pelboxEventController.sink;

  PelBoxBloc() {
    _pelboxEventController.stream.listen(_eventToState);
  }

  void _eventToState(PelBoxEvent event) {
    if (event is BoxAllSettings) {
      _allSettings(event.accessToken).then((response) {
        _inPelBox.add(jsonDecode(response.body));
      }).catchError((error) => print(error));
      return;
    }

    if (event is UpdateSecurityKey) {
      _updateSecurityKey(event.accessToken, event.securityKey).then((response) {
        _inPelBox.add(jsonDecode(response.body));
      }).catchError((error) => print(error));
      return;
    }

    if (event is PingBox) {
      _pingBox(event.accessToken).then((response) {
        _inPelBox.add(jsonDecode(response.body));
      }).catchError((error) => print(error));
      return;
    }

    if (event is GetBoxLocking) {
      _boxLockingState(event.accessToken).then((response) {
        _inPelBox.add(jsonDecode(response.body));
      }).catchError((error) => print(error));
      return;
    }

    if (event is UpdateLocking) {
      _updateLocking(event.accessToken, event.locked).then((response) {
        _inPelBox.add(jsonDecode(response.body));
      }).catchError((error) => print(error));
      return;
    }

    if (event is GetBoxDismantle) {
      _boxDismantleState(event.accessToken).then((response) {
        _inPelBox.add(jsonDecode(response.body));
      }).catchError((error) => print(error));
      return;
    }

    if (event is UpdateDismantle) {
      _updateDismantle(event.accessToken, event.dismantle).then((response) {
        _inPelBox.add(jsonDecode(response.body));
      }).catchError((error) => print(error));
      return;
    }

    if (event is UpdateExpandingValue) {
      _updateExpandingValue(event.accessToken, event.expandingValue)
          .then((response) {
        _inPelBox.add(jsonDecode(response.body));
      }).catchError((error) => print(error));
      return;
    }
  }

  Future<http.Response> _allSettings(String accessToken) async {
    return http.get(
      'http://10.0.2.2:9000/pelbox/settings/',
      headers: {
        'Content-Type': 'application/json',
        'access_token': accessToken,
      },
    );
  }

  Future<http.Response> _updateSecurityKey(
      String accessToken, String securityKey) async {
    Map<String, dynamic> jsonMap = {
      'access_token': accessToken,
      'security_key': securityKey,
    };

    return http.put('http://10.0.2.2:9000/pelbox/settings/security_key',
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(jsonMap));
  }

  Future<http.Response> _pingBox(String accessToken) async {
    try {
      http.Response response = await http.get('http://192.168.1.158:9001/ping',
          headers: {
            'Content-Type': 'application/json',
            'access_token': accessToken
          });

      return response;
    } catch (error) {
      return new http.Response(
          "{\"success\": false, \"message\": \"Something went wrong\"}", 500);
    }
  }

  Future<http.Response> _boxLockingState(String accessToken) async {
    try {
      http.Response response = await http.get(
        'http://10.0.2.2:9002/locking_state',
        headers: {
          'Content-Type': 'application/json',
          'access_token': accessToken,
        },
      );

      return response;
    } catch (error) {
      return new http.Response(
          "{\"success\": false, \"message\": \"Something went wrong\"}", 500);
    }
  }

  Future<http.Response> _updateLocking(String accessToken, bool locked) async {
    Map<String, dynamic> jsonMap = {
      'access_token': accessToken,
      'locked': locked,
    };

    try {
      http.Response response = await http.put(
          'http://10.0.2.2:9002/set_locking',
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(jsonMap));

      return response;
    } catch (error) {
      return new http.Response(
          "{\"success\": false, \"message\": \"Something went wrong\"}", 500);
    }
  }

  Future<http.Response> _boxDismantleState(String accessToken) async {
    try {
      http.Response response = await http.get(
        'http://10.0.2.2:9002/dismantle_state',
        headers: {
          'Content-Type': 'application/json',
          'access_token': accessToken,
        },
      );

      return response;
    } catch (error) {
      return new http.Response(
          "{\"success\": false, \"message\": \"Something went wrong\"}", 500);
    }
  }

  Future<http.Response> _updateDismantle(
      String accessToken, bool dismantle) async {
    Map<String, dynamic> jsonMap = {
      'access_token': accessToken,
      'dismantle': dismantle,
    };

    try {
      http.Response response = await http.put(
          'http://10.0.2.2:9002/set_dismantle',
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(jsonMap));

      return response;
    } catch (error) {
      return new http.Response(
          "{\"success\": false, \"message\": \"Something went wrong\"}", 500);
    }
  }

  Future<http.Response> _updateExpandingValue(
      String accessToken, int expandingValue) async {
    Map<String, dynamic> jsonMap = {
      'access_token': accessToken,
      'expanding-value': expandingValue,
    };

    try {
      http.Response response = await http.put(
          'http://10.0.2.2:9002/set_expanding_value',
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(jsonMap));

      return response;
    } catch (error) {
      return new http.Response(
          "{\"success\": false, \"message\": \"Something went wrong\"}", 500);
    }
  }
}
