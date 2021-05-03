import 'package:flutter/material.dart';

class TotalSpendingsCard extends StatefulWidget {
  final double _totalPrice;

  TotalSpendingsCard(this._totalPrice);

  @override
  State<StatefulWidget> createState() {
    return TotalSpendings(_totalPrice);
  }
}

class TotalSpendings extends State<TotalSpendingsCard> {
  final double _totalPrice;

  TotalSpendings(this._totalPrice);

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
                'Total Spendings',
              ),
              subtitle: Text(
                '${_totalPrice.toString()}\$',
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
                  color: Color(0xff019688),
                ),
                child: Icon(
                  Icons.attach_money_rounded,
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