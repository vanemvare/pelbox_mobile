import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pelbox_mobile/bloc/account_bloc.dart';
import 'package:pelbox_mobile/bloc/events/account_events.dart';
import 'package:pelbox_mobile/screens/cards/total_orders_card.dart';
import 'package:pelbox_mobile/screens/cards/total_spendings_card.dart';
import 'package:pelbox_mobile/screens/member_all_orders_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberOrdersCards extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainCards();
  }
}

class MainCards extends State<MemberOrdersCards> {
  bool _hasMemberDetails = false;
  bool _firstTimeOpening = true;
  Map<String, dynamic> ordersDetails = Map<String, dynamic>();

  @override
  void initState() {
    super.initState();
    _getAllMemberOrdersDetails();
  }
  
  @override
  Widget build(BuildContext context) {
    return _hasMemberDetails ? Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Orders'),
      ),
      body: Container(
        margin: EdgeInsets.all(17),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemberAllOrdersScreen())
                ).then((value) async {
                  setState(() {
                    _hasMemberDetails = false;
                  });

                  await _getAllMemberOrdersDetails();

                  setState(() {
                    _hasMemberDetails = true;
                  });
                });
              },
              child: TotalOrdersCard(ordersDetails['total_count'])
            ),
            TotalSpendingsCard(double.parse(ordersDetails['total_price']))
          ],
        ),
      ),
    )
    :
    Center(
      child: SpinKitCubeGrid(
        color: Colors.white,
        size: 50.0,
      ),
    );
  }

  Future<void> _getAllMemberOrdersDetails() async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token');

    final _accountBloc = AccountBloc();
    _accountBloc.accountEventSink.add(GetMemberOrdersDetails(accessToken));
    Map response = await _accountBloc.account.first;
    
    if (response['success']) {
      setState(() {
        ordersDetails = response['message'];

        if (_firstTimeOpening) {
          _hasMemberDetails = true;
          _firstTimeOpening = false;
        }
      });
    }
  }
}