import 'dart:async';

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pelbox_mobile/bloc/account_bloc.dart';
import 'package:pelbox_mobile/bloc/delivery_bloc.dart';
import 'package:pelbox_mobile/bloc/events/account_events.dart';
import 'package:pelbox_mobile/bloc/events/delivery_events.dart';
import 'package:pelbox_mobile/screens/cards/notification_card.dart';
import 'package:pelbox_mobile/screens/modals/notification_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeliveryOrdersScreen extends StatefulWidget {
  final List<dynamic> _orders;

  DeliveryOrdersScreen(this._orders);

  @override
  State<StatefulWidget> createState() {
    return DeliveryOrders(_orders);
  }
}

class DeliveryOrders extends State<DeliveryOrdersScreen> {
  final List<dynamic> _orders;

  DeliveryOrders(this._orders);

  Map<String, dynamic> member = Map<String, dynamic>();
  bool _hasMemberData = false;

  @override
  void initState() {
    super.initState();
    _getMemberDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
            image: AssetImage('assets/images/background2.png'),
            fit: BoxFit.cover),
      ),
      child: SafeArea(
          child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: Text('Available Deliveries'),
                backgroundColor: Colors.transparent,
              ),
              body: _orders.length > 0
                  ? Container(
                      width: double.infinity,
                      height: double.infinity,
                      margin: EdgeInsets.all(17),
                      child: ListView(
                          children: _orders.map((order) {
                        return InkWell(
                          onTap: () {
                            showBarModalBottomSheet(
                              context: context,
                              builder: (context) => SingleChildScrollView(
                                controller: ModalScrollController.of(context),
                                child: Column(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.all(17),
                                        child: NotificationsModal(
                                            order["product_title"],
                                            order["city_address"],
                                            order["product_image"],
                                            order["created_at"])),
                                    order["courier_id"] == null
                                        ? RaisedButton(
                                            onPressed: () {
                                              _takeDelivery(order);
                                            },
                                            child: Text('TAKE DELIVERY',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white)),
                                            color: Color(0xff078dff),
                                          )
                                        : Column(children: [
                                            order["courier_id"] == member["id"]
                                                ? RaisedButton(
                                                    onPressed: () {
                                                      _leaveDelivery(order);
                                                    },
                                                    child: Text(
                                                        'LEAVE DELIVERY',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Colors.white)),
                                                    color: Colors.red,
                                                  )
                                                : Text(
                                                    "This delivery is taken!",
                                                    style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                          ]),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          child: NotificationCard(
                              order["product_title"],
                              order["city_address"],
                              order["product_image"],
                              order["created_at"],
                              order["color"]
                          ),
                        );
                      }).toList()),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.local_shipping,
                            color: Colors.white,
                            size: 150,
                          ),
                          Text('Currently there are no new orders to deliver.',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18))
                        ],
                      ),
                    ))),
    );
  }

  Future<void> _getMemberDetails() async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token');

    final _accountBloc = AccountBloc();
    _accountBloc.accountEventSink.add(AllSettings(accessToken));
    Map response = await _accountBloc.account.first;

    setState(() {
      _hasMemberData = true;
      member = response['message'];
    });
  }

  Future<void> _takeDelivery(dynamic order) async {
    final _deliveryBloc = DeliveryBloc();
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token');
    _deliveryBloc.deliveryEventSink.add(TakeDelivery(
        accessToken, order["organization_delivery_id"], order["order_id"]));
    Map response = await _deliveryBloc.delivery.first;

    if (response['success']) {
      await _createAlertDialog(context, 'Information', response['message']);

      setState(() {
        order["color"] = Colors.green;
        order["courier_id"] = member["id"];
      });
      Navigator.of(context).pop();
    } else {
      _createAlertDialog(
          context, 'Error', 'There is a problem with taking delivery');
    }
  }

  Future<void> _leaveDelivery(dynamic order) async {
    final _deliveryBloc = DeliveryBloc();
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token');
    _deliveryBloc.deliveryEventSink.add(LeaveDelivery(
        accessToken, order["organization_delivery_id"], order["order_id"]));
    Map response = await _deliveryBloc.delivery.first;

    if (response['success']) {
      await _createAlertDialog(context, 'Information', response['message']);

      setState(() {
        order["courier_id"] = null;
      });
      Navigator.of(context).pop();
    } else {
      _createAlertDialog(
          context, 'Error', 'There is a problem with leaving delivery');
    }
  }

  Future<void> _createAlertDialog(
      BuildContext context, String title, String message) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              MaterialButton(
                child: Text('Close'),
                onPressed: () => {Navigator.of(context).pop()},
              )
            ],
          );
        });
  }
}
