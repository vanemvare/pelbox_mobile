import 'package:flutter/material.dart';

class OrderDetailsModal extends StatelessWidget {
  final String _categoryName;
  final double _price;
  final String _productTitle;
  final String _productImageURL;
  final String _status;
  final String _productShortDescription;

  OrderDetailsModal(this._categoryName, this._price, this._productTitle, this._productImageURL, this._status, this._productShortDescription);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Text(
              _productTitle,
              style: TextStyle(
                fontSize: 20
              ),
            ),
            SizedBox(
              height: 20
            ),
            Container(
              width: 300,
              height: 300,
              child: Image.network(
                _productImageURL
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              _productShortDescription,
              style: TextStyle(
                fontSize: 14
              ),
            ),
          ],
        ),
      ),
    );
  }
}