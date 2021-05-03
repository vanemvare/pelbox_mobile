import 'package:flutter/material.dart';

class OrderCard extends StatefulWidget {
  final String _categoryName;
  final double _price;
  final String _productTitle;
  final String _productImageURL;
  final String _status;

  OrderCard(this._categoryName, this._price, this._productTitle, this._productImageURL, this._status);

  @override
  State<StatefulWidget> createState() {
    return OrderInformation(_categoryName, _price, _productTitle, _productImageURL, _status);
  }
}

class OrderInformation extends State<OrderCard> {
  final String _categoryName;
  final double _price;
  final String _productTitle;
  final String _productImageURL;
  final String _status;
  Color _statusColor;

  OrderInformation(this._categoryName, this._price, this._productTitle, this._productImageURL, this._status) {
    switch (_status) {
      case "In a box":
        _statusColor = Color(0xff198754);
      break;

      case "Canceled":
        _statusColor = Color(0xffdc3545);
      break;

      case "Shipping":
        _statusColor = Color(0xff0d6efd);
      break;

      case "Delivered":
        _statusColor = Color(0xff198754);
      break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.8),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          CircleAvatar(
            radius: 75,
            backgroundImage: NetworkImage(
              _productImageURL,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text(
              _productTitle,
              style: TextStyle(
                fontSize: 14
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Category: $_categoryName, Price: $_price',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        'Status:',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: _statusColor,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        padding: EdgeInsets.all(5),
                        child: Text(
                          _status,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}