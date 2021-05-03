import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pelbox_mobile/bloc/account_bloc.dart';
import 'package:pelbox_mobile/bloc/events/account_events.dart';
import 'package:pelbox_mobile/screens/cards/order_card.dart';
import 'package:pelbox_mobile/screens/modals/order_details_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberAllOrdersScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MemberAllOrders();
  }
}

class MemberAllOrders extends State<MemberAllOrdersScreen> {
  bool _hasAllOrders = false;
  List<dynamic> orders = List<dynamic>();

  @override
  void initState() {
    super.initState();
    _getAllMemberOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage('assets/images/background2.png'),
          fit: BoxFit.cover
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text('All Orders'),
          ),
          body: _hasAllOrders ? Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.all(17),
            child: Container(
              child: orders.length > 0 ? ListView(
                children: orders.map((order) {
                  return InkWell(
                    onTap: () {
                      showBarModalBottomSheet(
                        context: context,
                        builder: (context) => SingleChildScrollView(
                          controller: ModalScrollController.of(context),
                          child: Container(
                            margin: EdgeInsets.all(17),
                            child: OrderDetailsModal(order['category_name'], double.parse(order['price']), order['product_title'], order['product_image'], order['status_name'], order['product_short_description']),
                          ),
                        ),
                      );
                    },
                    child: OrderCard(order['category_name'], double.parse(order['price']), order['product_title'], order['product_image'], order['status_name']),
                  );
                }).toList(),
              )
              :
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_shopping_cart,
                    color: Colors.white,
                    size: 150,
                  ),
                  Text(
                    'Start shopping!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30
                    )
                  )
                ],
              )
            ),
          )
          :
          Center(
          child: SpinKitCubeGrid(
            color: Colors.white,
            size: 50.0,
            ),
          ),
        )
      ),
    );
  }

  Future<void> _getAllMemberOrders() async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token');

    final _accountBloc = AccountBloc();
    _accountBloc.accountEventSink.add(GetAllMemberOrders(accessToken));
    Map response = await _accountBloc.account.first;
    
    if (response['success']) {
      setState(() {
        orders = response['message'];
        _hasAllOrders = true;
      });
    }
  }
}