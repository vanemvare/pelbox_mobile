import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:pelbox_mobile/bloc/events/account_events.dart';
import 'dart:convert';

import 'package:rxdart/rxdart.dart';

class AccountBloc {
  final _accountStateController = BehaviorSubject<Map>();
  StreamSink<Map> get _inAccount => _accountStateController.sink;
  Stream<Map> get account => _accountStateController.stream;

  final _accountEventController = BehaviorSubject<AccountEvent>();
  Sink<AccountEvent> get accountEventSink => _accountEventController.sink;

  AccountBloc() {
    _accountEventController.stream.listen(_eventToState);
  }

  void _eventToState(AccountEvent event) {
    if (event is AllSettings) {
      _memberAccount(event.accessToken)
      .then((response) {
        _inAccount.add(jsonDecode(response.body));
      })
      .catchError((error) => print(error));
      return;
    }

    if (event is AllCountries) {
      _getAllCountries(event.accessToken)
      .then((response) {
        _inAccount.add(jsonDecode(response.body));
      })
      .catchError((error) => print(error));
      return;
    }

    if (event is UpdateFirstName) {
      _updateMemberFirstName(event.accessToken, event.firstName)
      .then((response) {
        _inAccount.add(jsonDecode(response.body));
      })
      .catchError((error) => print(error));
      return;
    }

    if (event is UpdateLastName) {
      _updateMemberLastName(event.accessToken, event.lastName)
      .then((response) {
        _inAccount.add(jsonDecode(response.body));
      })
      .catchError((error) => print(error));
      return;
    }

    if (event is UpdateCity) {
      _updateMemberCity(event.accessToken, event.city)
      .then((response) {
        _inAccount.add(jsonDecode(response.body));
      })
      .catchError((error) => print(error));
      return;
    }

    if (event is UpdateCityAddress) {
      _updateMemberCityAddress(event.accessToken, event.cityAddress)
      .then((response) {
        _inAccount.add(jsonDecode(response.body));
      })
      .catchError((error) => print(error));
      return;
    }

    if (event is UpdatePostalCode) {
      _updateMemberPostalCode(event.accessToken, event.postalCode)
      .then((response) {
        _inAccount.add(jsonDecode(response.body));
      })
      .catchError((error) => print(error));
      return;
    }

    if (event is UpdateCountry) {
      _updateMemberCountry(event.accessToken, event.countryName)
      .then((response) {
        _inAccount.add(jsonDecode(response.body));
      })
      .catchError((error) => print(error));
      return;
    }

    if (event is CountryCode) {
      _getCountryCode(event.accessToken, event.countryName)
      .then((response) {
        _inAccount.add(jsonDecode(response.body));
      })
      .catchError((error) => print(error));
      return;
    }

    if (event is UpdateGender) {
      _updateMemberGender(event.accessToken, event.gender)
      .then((response) {
        _inAccount.add(jsonDecode(response.body));
      })
      .catchError((error) => print(error));
      return;
    }

    if (event is GetMemberOrdersDetails) {
      _getMemberOrdersDetails(event.accessToken)
      .then((response) {
        _inAccount.add(jsonDecode(response.body));
      })
      .catchError((error) => print(error));
      return;
    }

    if (event is GetAllMemberOrders) {
      _getAllMemberOrders(event.accessToken)
      .then((response) {
        _inAccount.add(jsonDecode(response.body));
      })
      .catchError((error) => print(error));
      return;
    }

    if (event is GetUnreadNotifications) {
      _getUnreadNotifications(event.accessToken)
      .then((response) {
        _inAccount.add(jsonDecode(response.body));
      })
      .catchError((error) => print(error));
      return;
    }

    if (event is ReadNotification) {
      _readNotification(event.accessToken, event.id)
      .then((response) {
        _inAccount.add(jsonDecode(response.body));
      })
      .catchError((error) => print(error));
      return;
    }

    if (event is GetOrganizationOrders) {
      _getOrganizationOrders(event.accessToken)
      .then((response) {
        _inAccount.add(jsonDecode(response.body));
      })
      .catchError((error) => print(error));
      return;
    }

    if (event is GetOrganizationDeliveries) {
      _getOrganizationDeliveries(event.accessToken)
      .then((response) {
        _inAccount.add(jsonDecode(response.body));
      })
      .catchError((error) => print(error));
      return;
    }
  }

  Future<http.Response> _memberAccount(String accessToken) async {
    return http.get(
        'http://10.0.2.2:9000/members/profile/',
        headers: {
          'Content-Type': 'application/json',
          'access_token': accessToken,
          'phone_token': '',
        },
    );
  }

  Future<http.Response> _getAllCountries(String accessToken) async {
    return http.get(
        'http://10.0.2.2:9000/members/profile/get_countries',
        headers: {
          'Content-Type': 'application/json',
          'access_token': accessToken,
        },
    );
  }

  Future<http.Response> _updateMemberFirstName(String accessToken, String firstName) async {
    Map<String, dynamic> jsonMap = {
      'access_token': accessToken,
      'first_name': firstName,
    };

    return http.put(
        'http://10.0.2.2:9000/members/profile/first_name',
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode(jsonMap)
    );
  }

  Future<http.Response> _updateMemberLastName(String accessToken, String lastName) async {
    Map<String, dynamic> jsonMap = {
      'access_token': accessToken,
      'last_name': lastName,
    };

    return http.put(
        'http://10.0.2.2:9000/members/profile/last_name',
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode(jsonMap)
    );
  }

  Future<http.Response> _updateMemberCity(String accessToken, String city) async {
    Map<String, dynamic> jsonMap = {
      'access_token': accessToken,
      'city': city,
    };

    return http.put(
        'http://10.0.2.2:9000/members/profile/city',
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode(jsonMap)
    );
  }

  Future<http.Response> _updateMemberCityAddress(String accessToken, String cityAddress) async {
    Map<String, dynamic> jsonMap = {
      'access_token': accessToken,
      'city_address': cityAddress,
    };

    return http.put(
        'http://10.0.2.2:9000/members/profile/city_address',
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode(jsonMap)
    );
  }

  Future<http.Response> _updateMemberPostalCode(String accessToken, String postalCode) async {
    Map<String, dynamic> jsonMap = {
      'access_token': accessToken,
      'postal_code': postalCode,
    };

    return http.put(
        'http://10.0.2.2:9000/members/profile/postal_code',
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode(jsonMap)
    );
  }

  Future<http.Response> _updateMemberCountry(String accessToken, String countryName) async {
    Map<String, dynamic> jsonMap = {
      'access_token': accessToken,
      'country_name': countryName,
    };

    return http.put(
        'http://10.0.2.2:9000/members/profile/country_name',
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode(jsonMap)
    );
  }

  Future<http.Response> _getCountryCode(String accessToken, String countryName) async {
    return http.get(
        'http://10.0.2.2:9000/members/profile/country_code',
        headers: {
          'Content-Type': 'application/json',
          'access_token': accessToken,
          'country_name': countryName
        },
    );
  }

  Future<http.Response> _updateMemberGender(String accessToken, String gender) async {
    Map<String, dynamic> jsonMap = {
      'access_token': accessToken,
      'gender': gender,
    };

    return http.put(
        'http://10.0.2.2:9000/members/profile/gender',
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode(jsonMap)
    );
  }

  Future<http.Response> _getMemberOrdersDetails(String accessToken) async {
    return http.get(
        'http://10.0.2.2:9000/members/orders/details/',
        headers: {
          'Content-Type': 'application/json',
          'access_token': accessToken
        },
    );
  }

  Future<http.Response> _getAllMemberOrders(String accessToken) async {
    return http.get(
        'http://10.0.2.2:9000/members/orders/all/',
        headers: {
          'Content-Type': 'application/json',
          'access_token': accessToken
        },
    );
  }

  Future<http.Response> _getUnreadNotifications(String accessToken) async {
    return http.get(
        'http://10.0.2.2:9000/members/orders/notifications/',
        headers: {
          'Content-Type': 'application/json',
          'access_token': accessToken
        },
    );
  }

  Future<http.Response> _readNotification(String accessToken, String id) async {
    Map<String, dynamic> jsonMap = {
      'access_token': accessToken,
      'id': id,
    };

    return http.put(
        'http://10.0.2.2:9000/members/orders/notifications/',
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode(jsonMap)
    );
  }

  Future<http.Response> _getOrganizationOrders(String accessToken) async {
    final _accountBloc = AccountBloc();
    _accountBloc.accountEventSink.add(AllSettings(accessToken));
    Map response = await _accountBloc.account.first;

    int organizationId = response["message"]["organization_id"];

    String uri = "http://10.0.2.2:9000/organizations/${organizationId}/orders";
    return http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'access_token': accessToken
        },
    );
  }

  Future<http.Response> _getOrganizationDeliveries(String accessToken) async {
    final _accountBloc = AccountBloc();
    _accountBloc.accountEventSink.add(AllSettings(accessToken));
    Map response = await _accountBloc.account.first;

    int organizationId = response["message"]["organization_id"];

    String uri = "http://10.0.2.2:9000/organizations/${organizationId}/deliveries";
    return http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'access_token': accessToken
        },
    );
  }

  void dispose() {
    _accountStateController.close();
    _accountEventController.close();
  }
}
