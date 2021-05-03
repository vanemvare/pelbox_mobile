import 'package:flutter/material.dart';

class TotalOrdersCard extends StatefulWidget {
  final int _totalCount;

  TotalOrdersCard(this._totalCount);

  @override
  State<StatefulWidget> createState() {
    return TotalOrders(_totalCount);
  }
}

class TotalOrders extends State<TotalOrdersCard> {
  final int _totalCount;

  TotalOrders(this._totalCount);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Colors.white.withOpacity(0.8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              title: Text(
                'Total Orders',
              ),
              subtitle: Text(
                _totalCount.toString(),
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),
              ),
              trailing: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff078dff),
                ),
                child: Icon(
                  Icons.timeline,
                  color: Colors.white,
                  size: 30,
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}