import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:pelbox_mobile/bloc/events/delivery_events.dart';
import 'dart:convert';

import 'package:rxdart/rxdart.dart';

class DeliveryBloc {
  final _deliveryStateController = BehaviorSubject<Map>();
  StreamSink<Map> get _inDelivery => _deliveryStateController.sink;
  Stream<Map> get delivery => _deliveryStateController.stream;

  final _deliveryEventController = BehaviorSubject<DeliveryEvent>();
  Sink<DeliveryEvent> get deliveryEventSink => _deliveryEventController.sink;

  DeliveryBloc() {
    _deliveryEventController.stream.listen(_eventToState);
  }

  void _eventToState(DeliveryEvent event) {
    if (event is TakeDelivery) {
      _assignDeliveryToMember(event.accessToken, event.organizationId, event.orderId)
      .then((response) {
        _inDelivery.add(jsonDecode(response.body));
      })
      .catchError((error) => print(error));
      return;
    }

    if (event is LeaveDelivery) {
      _removeDeliveryFromMember(event.accessToken, event.organizationId, event.orderId)
      .then((response) {
        _inDelivery.add(jsonDecode(response.body));
      })
      .catchError((error) => print(error));
      return;
    }
  }

  Future<http.Response> _assignDeliveryToMember(String accessToken, int organizationId, int orderId) async {
    Map<String, dynamic> jsonMap = {
      'access_token': accessToken,
    };

    String uri = "http://10.0.2.2:9000/organizations/${organizationId}/orders/${orderId}";

    return http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(jsonMap)
    );
  }

  Future<http.Response> _removeDeliveryFromMember(String accessToken, int organizationId, int orderId) async {
    Map<String, dynamic> jsonMap = {
      'access_token': accessToken,
    };

    String uri = "http://10.0.2.2:9000/organizations/${organizationId}/orders/${orderId}/leave";

    return http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(jsonMap)
    );
  }
}
