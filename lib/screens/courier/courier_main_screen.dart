import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pelbox_mobile/bloc/account_bloc.dart';
import 'package:pelbox_mobile/bloc/events/account_events.dart';
import 'package:pelbox_mobile/screens/orders/delivery_orders_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CourierMainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CourierMain();
  }
}

class CourierMain extends State<CourierMainScreen> {
  int _numberOfNotifications;
  String _notificationBackgroundImage;

  int _numberOfOrders;
  String _ordersBackgroundImage = 'assets/images/no_notifications.png';

  int _numberOfDeliveries;
  String _deliveriesBackgroundImage = 'assets/images/no_notifications.png';

  List<dynamic> notifications = List<dynamic>();
  List<dynamic> orders = List<dynamic>();
  List<dynamic> deliveries = List<dynamic>();

  bool _hasDetails = false;

  @override
  void initState() {
    super.initState();

    _getNumberOfOrders();
    _getNumberOfDeliveries();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Courier Control Center'),
        ),
        body: _hasDetails
            ? Container(
                margin: EdgeInsets.all(17),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DeliveryOrdersScreen(orders)))
                            .then((value) {
                          setState(() {
                            _hasDetails = false;
                          });

                          setState(() {
                            _getNumberOfOrders();
                            _getNumberOfDeliveries();
                            _hasDetails = true;
                          });
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            shape: BoxShape.rectangle,
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('AVAILABLE DELIVERIES',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 2),
                              Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset(_ordersBackgroundImage,
                                          height: 25, width: 25),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 0, 0, 0),
                                        child: Text(_numberOfOrders.toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 25,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DeliveryOrdersScreen(deliveries)))
                            .then((value) {
                          setState(() {
                            _hasDetails = false;
                          });

                          setState(() {
                            _getNumberOfOrders();
                            _getNumberOfDeliveries();
                            _hasDetails = true;
                          });
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            shape: BoxShape.rectangle,
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('YOUR DELIVERIES',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 2),
                              Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset(_deliveriesBackgroundImage,
                                          height: 25, width: 25),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 0, 0, 0),
                                        child: Text(
                                            _numberOfDeliveries.toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 25,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: SpinKitCubeGrid(
                  color: Colors.white,
                  size: 50.0,
                ),
              ),
      ),
    );
  }

  Future<void> _getNumberOfOrders() async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token');

    final _accountBloc = AccountBloc();
    _accountBloc.accountEventSink.add(GetOrganizationOrders(accessToken));
    Map response = await _accountBloc.account.first;

    if (response['success']) {
      setState(() {
        orders = response['message'];

        for (var order in orders) {
          order["color"] = Colors.white;
        }

        _numberOfOrders = orders.length;
        _ordersBackgroundImage = orders.length == 0
            ? 'assets/images/no_notifications.png'
            : 'assets/images/has_notifications.png';
        _hasDetails = true;
      });
    }
  }

  Future<void> _getNumberOfDeliveries() async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token');

    final _accountBloc = AccountBloc();
    _accountBloc.accountEventSink.add(GetOrganizationDeliveries(accessToken));
    Map response = await _accountBloc.account.first;

    if (response['success']) {
      setState(() {
        deliveries = response['message'];

        for (var delivery in deliveries) {
          delivery["color"] = Colors.white;
        }

        _numberOfDeliveries = deliveries.length;
        _deliveriesBackgroundImage = deliveries.length == 0
            ? 'assets/images/no_notifications.png'
            : 'assets/images/has_notifications.png';
        _hasDetails = true;
      });
    }
  }
}
