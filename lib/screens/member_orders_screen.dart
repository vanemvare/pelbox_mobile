import 'package:flutter/material.dart';
import 'package:pelbox_mobile/screens/member_orders_cards_screen.dart';

class MemberOrdersScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MemberOrders();
  }
}

class MemberOrders extends State<MemberOrdersScreen> {
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
        child: Container(
          child: Material(
            color: Colors.transparent,
            child: MemberOrdersCards()
          ),
        )
      ),
    );
  }
}
